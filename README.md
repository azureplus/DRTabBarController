# DRTabBarController

[![CI Status](http://img.shields.io/travis/David Runemalm/DRTabBarController.svg?style=flat)](https://travis-ci.org/David Runemalm/DRTabBarController)
[![Version](https://img.shields.io/cocoapods/v/DRTabBarController.svg?style=flat)](http://cocoadocs.org/docsets/DRTabBarController)
[![License](https://img.shields.io/cocoapods/l/DRTabBarController.svg?style=flat)](http://cocoadocs.org/docsets/DRTabBarController)
[![Platform](https://img.shields.io/cocoapods/p/DRTabBarController.svg?style=flat)](http://cocoadocs.org/docsets/DRTabBarController)

## Demo

![alt tag](https://raw.githubusercontent.com/runemalm/DRTabBarController/develop/Example/demo.gif)

## Description

Use the DRTabBarController if you want the native UITabBarController but with the tabs at the top.

Compare with the tab view in the iOS Youtube app.

* Interface mimics UITabBarController
* Get your tab panel at the top

## Version

Version 0.1.0

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Below is a quick example how your instantiation might look like:

```objc      
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

// Create tab bar controller
DRTabBarController *tabBarController = [[DRTabBarController alloc]
initWithViewControllers:@[self.firstViewController,
self.secondViewController,
self.thirdViewController]];

// Set as root view and make window visible
self.window.rootViewController = tabBarController;
[self.window makeKeyAndVisible];
return YES;
}
```

## Requirements

## Installation

DRTabBarController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod "DRTabBarController"

## Author

David Runemalm, david.runemalm@gmail.com

## License

DRTabBarController is available under the MIT license. See the LICENSE file for more info.
