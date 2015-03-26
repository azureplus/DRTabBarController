//
//  DRAppDelegate.h
//  DRTabBarController
//
//  Created by CocoaPods on 03/19/2015.
//  Copyright (c) 2014 David Runemalm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRTabBarController.h"
#import "DRViewController.h"

@interface DRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) DRTabBarController *tabBarViewController;
@property (strong, nonatomic) DRViewController *firstViewController;
@property (strong, nonatomic) DRViewController *secondViewController;
@property (strong, nonatomic) DRViewController *thirdViewController;

@end
