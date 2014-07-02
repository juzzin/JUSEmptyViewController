//
//  JUSDefaultEmptyViewController.m
//  JUSReloadDataHook
//
//  Created by Justin on 6/30/14.
//
//

#import "JUSDefaultEmptyViewController.h"

@interface JUSDefaultEmptyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) UIMotionEffectGroup *contentViewMotionEffect;
@property (nonatomic, strong) UIMotionEffectGroup *backgroundImageViewMotionEffect;
@end

@implementation JUSDefaultEmptyViewController

- (void)viewDidLoad {
    self.titleLabel.text = self.title;
    self.subtitleLabel.text = self.subtitle;
    self.imageView.image = [UIImage imageNamed:self.imageName];
    [self.actionButton setTitle:self.actionButtonTitle forState:UIControlStateNormal];
    
    //    // Background pattern image
    UIImage *patternImage = [UIImage imageNamed:self.backgroundImageName];
    self.backgroundImageView.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    if (self.enableMotionEffects) {
        // Create and apply the motion effect for the foreground view.
        {
            UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
            xAxis.minimumRelativeValue = @(-30.0);
            xAxis.maximumRelativeValue = @(30.0);
            
            UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            yAxis.minimumRelativeValue = @(-15.0);
            yAxis.maximumRelativeValue = @(15.0);
            
            self.contentViewMotionEffect = [[UIMotionEffectGroup alloc] init];
            self.contentViewMotionEffect.motionEffects = @[xAxis, yAxis];
            
            [self.contentView addMotionEffect:self.contentViewMotionEffect];
        }
        
        // Create and apply the motion effect for the foreground image view.
        {
            UIInterpolatingMotionEffect *xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
            xAxis.minimumRelativeValue = @(30.0);
            xAxis.maximumRelativeValue = @(-30.0);
            
            UIInterpolatingMotionEffect *yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            yAxis.minimumRelativeValue = @(15.0);
            yAxis.maximumRelativeValue = @(-15.0);
            
            self.backgroundImageViewMotionEffect = [[UIMotionEffectGroup alloc] init];
            self.backgroundImageViewMotionEffect.motionEffects = @[xAxis, yAxis];
            
            [self.backgroundImageView addMotionEffect:self.backgroundImageViewMotionEffect];
        }
    }
}

- (IBAction)actionButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(emptyViewDidTapButton)]) {
        [self.delegate emptyViewDidTapButton];
    }
}

@end
