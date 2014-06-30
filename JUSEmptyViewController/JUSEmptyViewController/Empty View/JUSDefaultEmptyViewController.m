//
//  JUSDefaultEmptyViewController.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/30/14.
//
//

#import "JUSDefaultEmptyViewController.h"

@implementation JUSDefaultEmptyViewController

- (IBAction)actionButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(emptyViewDidTapButton)]) {
        [self.delegate emptyViewDidTapButton];
    }
}

@end
