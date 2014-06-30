//
//  JUSDefaultEmptyViewController.h
//  JUSReloadDataHook
//
//  Created by Justin on 6/30/14.
//
//

#import <UIKit/UIKit.h>

@protocol JUSDefaultEmptyViewController <NSObject>
@optional
- (void)emptyViewDidTapButton;
@end

@interface JUSDefaultEmptyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (nonatomic, assign) id <JUSDefaultEmptyViewController> delegate;
@end
