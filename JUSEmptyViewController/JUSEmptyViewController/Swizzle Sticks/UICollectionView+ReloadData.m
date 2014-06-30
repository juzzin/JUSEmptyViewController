//
//  UICollectionView+ReloadData.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UICollectionView (ReloadData)

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
