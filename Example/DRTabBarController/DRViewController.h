//
//  DRViewController.h
//  DRTabBarController
//
//  Created by David Runemalm on 03/19/2015.
//  Copyright (c) 2014 David Runemalm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRTabBarController.h"

@interface DRViewController : UIViewController <DRTabBarControllerChild>

@property (strong, nonatomic) DRTabBarController *drTabBarController;
@property (strong, nonatomic) DRTabBarItem *drTabBarItem;

@end
