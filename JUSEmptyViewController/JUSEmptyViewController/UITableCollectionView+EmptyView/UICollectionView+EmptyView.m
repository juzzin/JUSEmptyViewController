//
//  UICollectionView+EmptyView.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "UICollectionView+EmptyView.h"
#import "UICollectionView+ReloadData.h"
#import <objc/runtime.h>

@implementation UICollectionViewController (EmptyView)
@dynamic emptyViewState;

- (void)configureEmptyViewController:(UIViewController *)emptyController
{
    // Set frame
    emptyController.view.frame = self.view.frame;
    UIView *view = emptyController.view;
    
    typeof(self) __weak weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:JUSReloadDataNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (note.object == self.collectionView) {
                                                          [weakSelf displayViewIfDataSourceIsEmpty:emptyController];
                                                      }
                                                  }];
}

- (void)displayViewIfDataSourceIsEmpty:(UIViewController *)emptyController
{
    id <UICollectionViewDataSource> dataSource = self.collectionView.dataSource;
    UIView *view = emptyController.view;
    
    if ([self.collectionView respondsToSelector:@selector(numberOfItemsInSection:)]) {
        
        NSInteger count = [dataSource collectionView:self.collectionView numberOfItemsInSection:0];
        
        if (count == 0 && ![self.emptyViewState isEqual: @1]) {
            // Disable bouncing
#warning This is a bug, since it overrides both settings.
            self.collectionView.alwaysBounceVertical = NO;
            
            // Add empty view controller as child
            [self addChildViewController:emptyController];
            [self.view addSubview:view];
            [self.view bringSubviewToFront:view];
        } else {
            // Enable bouncing
            self.collectionView.alwaysBounceVertical = YES;
            
            [emptyController.view removeFromSuperview];
            [emptyController removeFromParentViewController];
        }
    }
}

#pragma mark - Enable/Disable

- (void)enableEmptyViewController
{
    self.emptyViewState = nil;
}

- (void)disableEmptyViewController
{
    self.emptyViewState = @1;
}

#pragma mark - Properties

- (void)setEmptyViewState:(NSNumber *)state {
    objc_setAssociatedObject(self, @selector(emptyViewState), state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)emptyViewState {
    return objc_getAssociatedObject(self, @selector(emptyViewState));
}

@end
