//
//  DRAppDelegate.m
//  DRTabBarController
//
//  Created by CocoaPods on 03/19/2015.
//  Copyright (c) 2014 David Runemalm. All rights reserved.
//

#import "DRAppDelegate.h"
#import "DRTabBarController.h"
#import "DRViewController.h"

@implementation DRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Get storyboard
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    // Create view controllers
    self.firstViewController = [storyBoard instantiateViewControllerWithIdentifier:@"FirstView"];
    self.firstViewController.title = @"First";
    self.secondViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SecondView"];
    self.secondViewController.title = @"Second";
    self.thirdViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ThirdView"];
    self.thirdViewController.title = @"Third";
    
    // Third tab has an icon
    self.thirdViewController.drTabBarItem = [DRTabBarItem new];
    self.thirdViewController.drTabBarItem.title = @"";
    self.thirdViewController.drTabBarItem.image = [UIImage imageNamed:@"tab-icon-info"];
    self.thirdViewController.drTabBarItem.selectedImage = [UIImage imageNamed:@"tab-icon-info"];
    
    // Create tab bar controller
    DRTabBarController *tabBarController = [[DRTabBarController alloc]
                                                initWithViewControllers:@[self.firstViewController,
                                                                          self.secondViewController,
                                                                          self.thirdViewController]];
    // ..set selection indicator image
    UIImage *selectionIndicatorImage = [[UIImage imageNamed:@"tab-selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                                                                            resizingMode:UIImageResizingModeStretch];
    tabBarController.tabBar.selectionIndicatorImage = selectionIndicatorImage;
    
    // ..set tab bar background image
    UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"tab-bar-background"];
    tabBarController.tabBar.backgroundImage = tabBarBackgroundImage;
    
    // Create example view controller
    UIViewController *exampleViewController = [UIViewController new];
    [exampleViewController addChildViewController:tabBarController];
    [exampleViewController.view addSubview:tabBarController.view];
    [tabBarController didMoveToParentViewController:exampleViewController];
    
    // Create wrapped example view controller
    UINavigationController *wrappedExampleViewController = [[UINavigationController alloc] initWithRootViewController:exampleViewController];
    wrappedExampleViewController.title = @"Tabbed";
    
    // Create dummy view controller
    UIViewController *dummyViewController = [UIViewController new];
    dummyViewController.title = @"Dummy";
    
    // Create main tab view
    UITabBarController *mainTabBarController = [[UITabBarController alloc] init];
    [mainTabBarController setViewControllers:@[wrappedExampleViewController, dummyViewController]];
    
    
    
    // Set as root view and make window visible
    self.window.rootViewController = mainTabBarController;
    [self.window makeKeyAndVisible];
    return YES;
    
    
    
    /*
    
    // Get storyboard
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    // Create view controllers
    self.firstViewController = [storyBoard instantiateViewControllerWithIdentifier:@"FirstView"];
    self.firstViewController.title = @"First";
    self.secondViewController = [storyBoard instantiateViewControllerWithIdentifier:@"SecondView"];
    self.secondViewController.title = @"Second";
    self.thirdViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ThirdView"];
    self.thirdViewController.title = @"Third";
    
    // Third tab has an icon
    self.thirdViewController.drTabBarItem = [DRTabBarItem new];
    self.thirdViewController.drTabBarItem.title = @"";
    self.thirdViewController.drTabBarItem.image = [UIImage imageNamed:@"tab-icon-info"];
    self.thirdViewController.drTabBarItem.selectedImage = [UIImage imageNamed:@"tab-icon-info"];
    
    // Create tab bar controller
    DRTabBarController *tabBarController = [[DRTabBarController alloc]
                                                    initWithViewControllers:@[self.firstViewController,
                                                                              self.secondViewController,
                                                                              self.thirdViewController]];
    
    // ..set selection indicator image
    UIImage *selectionIndicatorImage = [[UIImage imageNamed:@"tab-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                                                                                resizingMode:UIImageResizingModeStretch];
    tabBarController.tabBar.selectionIndicatorImage = selectionIndicatorImage;

    // Set as root view and make window visible
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;*/
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
