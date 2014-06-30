//
//  ReloadDataSwizzle.h
//  JUSReloadDataHook
//
//  Created by Justin on 6/29/14.
//
//

#import <Foundation/Foundation.h>

extern NSString * const JUSReloadDataNotification;

static NSMutableDictionary *implementationLookupTable;
void swizzleReloadData(id self);