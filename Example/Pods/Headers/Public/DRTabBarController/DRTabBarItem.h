//
//  DRTabBarItem.h
//  Pods
//
//  Created by David Runemalm on 2015-03-19.
//
//

@class DRTabBarController;
@class DRTabBar;
@protocol DRTabBarControllerChild;

#import <UIKit/UIKit.h>

@interface DRTabBarItem : UIView

@property (strong, nonatomic) UIViewController<DRTabBarControllerChild> *viewController;
@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) BOOL enabled;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) UIImage *selectedIndicatorImage;
@property (readonly, nonatomic) UIImage *defaultSelectedIndicatorImage;
@property (assign, nonatomic) UIEdgeInsets imageInsets;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) DRTabBar *tabBar;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIndicatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
