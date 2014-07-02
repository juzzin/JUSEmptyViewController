//
//  JUSEmptyView.m
//  JUSEmptyViewController
//
//  Created by Justin on 7/2/14.
//
//

#import "JUSEmptyView.h"

@implementation JUSEmptyView

- (void)didMoveToSuperview
{
    self.frame = self.superview.bounds;
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.15
                     animations:^{ self.alpha = 1.0f; }
                     completion:NULL];
}

@end
