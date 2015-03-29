//
//  DRTabBarController.m
//  Pods
//
//  Created by David Runemalm on 2015-03-19.
//
//

#import "DRTabBarController.h"
#import "DRTabBar.h"
#import "DRTabBarItem.h"

NSUInteger const kTabBarHeight = 49;

@interface DRTabBarController ()

@property (strong, nonatomic) NSArray *initialViewControllers;
@property (strong, nonatomic) NSMutableArray *viewControllerConstraints;
@property (strong, nonatomic) NSMutableArray *tabBarConstraints;

@end

@implementation DRTabBarController

- (id)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        [self commonInit];
        self.initialViewControllers = viewControllers;
    }
    return self;
}

- (void)commonInit
{
    _viewControllers = [@[] mutableCopy];
    _tabBarItems = [@[] mutableCopy];
    _selectedIndex = 0;
    _initialViewControllers = @[];
    _viewControllerConstraints = [NSMutableArray new];
    _tabBarConstraints = [NSMutableArray new];
    
    // Create subviews
    [self createSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Add subviews
    [self.view addSubview:self.tabBar];
    
    // Layout view controllers?
    if (self.initialViewControllers.count > 0) {
        self.viewControllers = [NSMutableArray arrayWithArray:self.initialViewControllers];
    }
    
    // Init properties
    [self initProperties];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initProperties
{
    // Set background color
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Subviews

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    [self updateViewControllerConstraints];
    [self updateTabBarConstraints];
}

- (void)createSubviews
{
    self.tabBar = [self createTabBar];
}

- (DRTabBar *)createTabBar
{
    DRTabBar *tabBar = [DRTabBar new];
    tabBar.backgroundColor = [UIColor clearColor];
    tabBar.tabBarController = self;
    return tabBar;
}

#pragma mark - Layout

- (void)updateViewControllerConstraints
{
    // Remove old constraints
    [self.view removeConstraints:self.viewControllerConstraints];
    [self.viewControllerConstraints removeAllObjects];
    
    for (UIViewController *viewController in self.viewControllers) {
        
        // Disable autoresizing mask
        viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Create variable binding
        UIView *tabBar = self.tabBar;
        UIView *view = viewController.view;
        NSDictionary *views = NSDictionaryOfVariableBindings(view, tabBar);
        NSDictionary *metrics = nil;
        
        // Create constraints
        [self.viewControllerConstraints addObjectsFromArray:
             [NSLayoutConstraint constraintsWithVisualFormat:
                @"H:|[view]|" options:0 metrics:nil views:views]];
        [self.viewControllerConstraints addObjectsFromArray:
            [NSLayoutConstraint constraintsWithVisualFormat:
                @"V:[tabBar][view]|" options:0 metrics:metrics views:views]];
    }
    
    // Add constraints
    [self.view addConstraints:self.viewControllerConstraints];
}

- (void)updateTabBarConstraints
{
    // Remove old constraints
    [self.view removeConstraints:self.tabBarConstraints];
    self.tabBarConstraints = [NSMutableArray new];
    
    // Disable autoresizing mask
    self.tabBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Create variable binding
    UIView *tabBar = self.tabBar;
    id topLayoutGuide = self.topLayoutGuide;
    NSNumber *height = self.viewControllers.count > 1 ? @(kTabBarHeight) : @(0);
    NSDictionary *views = NSDictionaryOfVariableBindings(tabBar, topLayoutGuide);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(height);
    
    // Create constraints
    [self.tabBarConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"H:|[tabBar]|" options:0 metrics:nil views:views]];
    [self.tabBarConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"V:[topLayoutGuide][tabBar(height)]" options:0 metrics:metrics views:views]];
    
    // Add constraints
    [self.view addConstraints:self.tabBarConstraints];
}

#pragma mark - Tab Bar

- (void)tabBarDidSelectTab:(DRTabBarItem *)tab atIndex:(NSUInteger)index
{
    self.selectedIndex = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:self.viewControllers[index]];
    }
}

#pragma mark - View Controllers

- (void)addViewControllers:(NSArray *)viewControllers
{
    NSInteger count = 0;
    for (UIViewController<DRTabBarControllerChild> *controller in viewControllers) {
        [self addViewController:controller];
        count++;
    }
}

- (void)addViewController:(UIViewController<DRTabBarControllerChild> *)viewController
{
    // Set reference to tab bar view controller
    viewController.drTabBarController = self;
    
    // Add as child view controller
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    [_viewControllers addObject:viewController];
    
    // Create tab bar item?
    if (!viewController.drTabBarItem) {
        DRTabBarItem *tabBarItem = [DRTabBarItem new];
        tabBarItem.title = viewController.title ? viewController.title : @"No title";
        viewController.drTabBarItem = tabBarItem;
        
        // Set selection indicator image
        tabBarItem.selectedIndicatorImage = self.tabBar.selectionIndicatorImage;
    }
    viewController.drTabBarItem.viewController = viewController;
    [self.tabBar addTabBarItem:viewController.drTabBarItem];
}

- (void)removeViewControllers:(NSArray *)viewControllers
{
    for (UIViewController<DRTabBarControllerChild> *viewController in viewControllers) {
        [self removeViewController:viewController];
    }
}

- (void)removeViewController:(UIViewController<DRTabBarControllerChild> *)viewController
{
    // Remove tab bar item
    DRTabBarItem *tabBarItem = viewController.drTabBarItem;
    [self removeTabBarItem:tabBarItem];
    
    // Remove view controller
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
    [self.viewControllers removeObject:viewController];
}

#pragma mark - Tab Bar

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    // TODO: ..
}

- (void)removeTabBarItems
{
    for (DRTabBarItem *tabBarItem in self.tabBarItems) {
        [tabBarItem removeFromSuperview];
    }
    _tabBarItems = [@[] mutableCopy];
}

- (void)removeTabBarItem:(DRTabBarItem *)tabBarItem
{
    [tabBarItem removeFromSuperview];
    [self.tabBarItems removeObject:tabBarItem];
}

#pragma mark - Properties

- (UIViewController *)selectedViewController
{
    for (UIViewController *viewController in self.viewControllers) {
        if (!viewController.view.hidden) {
            return viewController;
        }
    }
    return nil;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    [self removeViewControllers:self.viewControllers];
    [self addViewControllers:viewControllers];
    self.selectedIndex = 0;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    // Show view controller corresponding to index
    NSUInteger count = 0;
    for (UIViewController<DRTabBarControllerChild> *viewController in self.viewControllers) {
        
        BOOL shouldHide = count != selectedIndex && !viewController.view.hidden;
        BOOL shouldShow = count == selectedIndex && viewController.view.hidden;
        
        // Notify?
        if (shouldHide) {
            [viewController viewWillDisappear:YES];
            if ([viewController respondsToSelector:@selector(willEndBeeingSelectedViewController)]) {
                [viewController willEndBeeingSelectedViewController];
            }
        } else if (shouldShow) {
            [viewController viewWillAppear:YES];
            if ([viewController respondsToSelector:@selector(willBecomeSelectedViewController)]) {
                [viewController willBecomeSelectedViewController];
            }
        }
        
        // Hide / Show
        if (shouldHide) {
            viewController.view.hidden = YES;
        } else if (shouldShow) {
            viewController.view.hidden = NO;
        }
        
        // Notify?
        if (shouldHide) {
            [viewController viewDidDisappear:YES];
            if ([viewController respondsToSelector:@selector(didEndBeeingSelectedViewController)]) {
                [viewController didEndBeeingSelectedViewController];
            }
        } else if (shouldShow) {
            [viewController viewDidAppear:YES];
            if ([viewController respondsToSelector:@selector(didBecomeSelectedViewController)]) {
                [viewController didBecomeSelectedViewController];
            }
        }
        
        count++;
    }
    
    // Tell tab bar to select tab
    self.tabBar.selectedIndex = selectedIndex;
    
    // Make sure tab bar is on top
    [self.view bringSubviewToFront:self.tabBar];
}

@end
