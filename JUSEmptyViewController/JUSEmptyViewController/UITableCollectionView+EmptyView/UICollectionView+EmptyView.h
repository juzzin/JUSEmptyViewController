//
//  UICollectionView+EmptyView.h
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "JUSDefaultEmptyViewController.h"
#import <UIKit/UIKit.h>

@interface UICollectionViewController (EmptyView)
- (void)configureEmptyViewController:(UIViewController *)emptyController;
@end
