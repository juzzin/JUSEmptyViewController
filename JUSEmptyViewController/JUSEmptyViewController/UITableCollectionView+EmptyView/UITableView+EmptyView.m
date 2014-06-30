//
//  UITableView+EmptyView.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "UITableView+EmptyView.h"
#import "UITableView+ReloadData.h"
#import <objc/runtime.h>

@implementation UITableViewController (EmptyView)
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
                                                      if (note.object == self.tableView) {
                                                          [weakSelf displayViewIfDataSourceIsEmpty:emptyController];
                                                      }
                                                  }];
}

- (void)displayViewIfDataSourceIsEmpty:(UIViewController *)emptyController
{
    id <UITableViewDataSource> dataSource = self.tableView.dataSource;
    UIView *view = emptyController.view;
    
    if ([self.tableView respondsToSelector:@selector(numberOfRowsInSection:)]) {
        
        NSInteger count = [dataSource tableView:self.tableView numberOfRowsInSection:0];
        
        if (count == 0 && ![self.emptyViewState isEqual: @1]) {
            // Disable bouncing
#warning Potentially overrides default settings. Fix!
            self.tableView.alwaysBounceVertical = NO;
            
            // Remove table cell seperators
#warning Like above. Fix!
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            // Add empty view controller as child
            [self addChildViewController:emptyController];
            [self.view addSubview:view];
            [self.view bringSubviewToFront:view];
        } else {
            // Enable bouncing
            self.tableView.alwaysBounceVertical = YES;
            
            // Restore table cell seperators
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            
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
