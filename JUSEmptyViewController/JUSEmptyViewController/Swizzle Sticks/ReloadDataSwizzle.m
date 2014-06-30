//
//  ReloadDataSwizzle.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import "ReloadDataSwizzle.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

NSString * const JUSReloadDataNotification = @"JUSReloadDataNotification";

void _reloadData_new(id self, SEL _cmd)
{
    // Fetch original implementation from lookup table
    NSString *key = NSStringFromClass([self class]);
    NSValue *impValue = [implementationLookupTable valueForKey:key];
    IMP reloadData_orig = [impValue pointerValue];
    
    // If found, call original implementation
    if (reloadData_orig) {
        ((void(*)(id,SEL))reloadData_orig)(self,_cmd);
    }
    
    // Trigger notification
    [[NSNotificationCenter defaultCenter] postNotificationName:JUSReloadDataNotification
                                                        object:self];
}

void swizzleReloadData(id self)
{
    if (!implementationLookupTable) {
        implementationLookupTable = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    
    // Swizzle reloadData
    Method method = class_getInstanceMethod([self class], @selector(reloadData));
    IMP reloadData_orig = method_setImplementation(method, (IMP)_reloadData_new);
    
    // Store original implementation in lookup table
    [implementationLookupTable setValue:[NSValue valueWithPointer:reloadData_orig]
                                 forKey:NSStringFromClass([self class])];
}