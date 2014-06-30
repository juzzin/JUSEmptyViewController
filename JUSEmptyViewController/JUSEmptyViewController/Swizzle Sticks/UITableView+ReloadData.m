//
//  UITableView+ReloadData.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "UITableView+ReloadData.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UITableView (ReloadData)

+ (void)load
{
    if (class_respondsToSelector(self, @selector(reloadData))) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            swizzleReloadData(self);
        });
    }
}

@end
