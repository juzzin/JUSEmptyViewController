//
//  UITableView+EmptyView.h
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "JUSDefaultEmptyViewController.h"
#import <UIKit/UIKit.h>

@interface UITableViewController (EmptyView)
@property (nonatomic, strong) NSNumber *emptyViewState;
- (void)configureEmptyViewController:(UIViewController *)emptyController;
- (void)enableEmptyViewController;
- (void)disableEmptyViewController;
@end
