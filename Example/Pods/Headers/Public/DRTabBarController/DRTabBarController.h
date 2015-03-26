//
//  DRTabBarController.h
//  Pods
//
//  Created by David Runemalm on 2015-03-19.
//
//

@class DRTabBarItem;

#import <UIKit/UIKit.h>
#import "DRTabBar.h"

@class DRTabBarController;

@protocol DRTabBarControllerChild <NSObject>

@property (strong, nonatomic) DRTabBarController *drTabBarController;
@property (strong, nonatomic) DRTabBarItem *drTabBarItem;

@optional
- (void)willEndBeeingSelectedViewController;
- (void)willBecomeSelectedViewController;
- (void)didEndBeeingSelectedViewController;
- (void)didBecomeSelectedViewController;

@end

@protocol DRTabBarControllerDelegate <NSObject>

@optional
- (void)tabBarController:(DRTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@interface DRTabBarController : UIViewController

@property (assign, nonatomic) id<DRTabBarControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *tabBarItems;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (readonly, nonatomic) UIViewController *selectedViewController;
@property (assign, nonatomic) NSUInteger selectedIndex;
@property (strong, nonatomic) DRTabBar *tabBar;
@property (strong, nonatomic) UIImage *tabBarSelectionIndicatorImage;

- (id)initWithViewControllers:(NSArray *)viewControllers;
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)tabBarDidSelectTab:(DRTabBarItem *)tab atIndex:(NSUInteger)index;

@end
