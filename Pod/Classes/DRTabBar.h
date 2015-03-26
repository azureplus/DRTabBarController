//
//  DRTabBar.h
//  Pods
//
//  Created by David Runemalm on 2015-03-20.
//
//

#import <UIKit/UIKit.h>
#import "DRTabBarItem.h"

@interface DRTabBar : UIView

@property (strong, nonatomic) DRTabBarController *tabBarController;
@property (strong, nonatomic) NSMutableArray *tabBarItems;
@property (assign, nonatomic) NSUInteger selectedIndex;
@property (strong, nonatomic) UIImage *selectionIndicatorImage;

- (void)addTabBarItem:(DRTabBarItem *)tabBarItem;
- (void)didTapOnTab:(DRTabBarItem *)tab;

@end
