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
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *actionButtonTitle;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *backgroundImageName;
@property (assign, nonatomic) BOOL enableMotionEffects;

@property (nonatomic, assign) id <JUSDefaultEmptyViewController> delegate;

- (instancetype)initWithTitle:(NSString *)title
                     subtitle:(NSString *)subtitle
            actionButtonTitle:(NSString *)actionButtonTitle
                    imageName:(NSString *)imageName
          backgroundImageName:(NSString *)backgroundImageName
         enableMottionEffects:(BOOL)enableMottionEffects;
@end
