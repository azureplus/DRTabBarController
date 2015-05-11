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

@property (strong, nonatomic) NSMutableArray *tabBarConstraints;
@property (strong, nonatomic) NSMutableArray *transitionViewConstraints;
@property (strong, nonatomic) NSMutableArray *selectedViewConstraints;
@property (strong, nonatomic) NSMutableArray *viewHierarchyConstraints;
@property (strong, nonatomic) UIView *transitionView;

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
    _tabBarConstraints = [NSMutableArray new];
    _transitionViewConstraints = [NSMutableArray new];
    _selectedViewConstraints = [NSMutableArray new];
    _viewHierarchyConstraints = [NSMutableArray new];
    
    // Create subviews
    [self createSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Add subviews
    [self addSubviews];
    
    // Layout view controllers?
    if (self.initialViewControllers.count > 0) {
        self.viewControllers = [NSMutableArray arrayWithArray:self.initialViewControllers];
    }
    
    // Init properties
    [self initProperties];
    
    // Trigger constraints update
    [self.view setNeedsUpdateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initProperties
{
    // Set background color
    self.view.backgroundColor = [UIColor whiteColor];
    self.isTabBarHidden = NO;
}

#pragma mark - Subviews

- (void)updateViewConstraints
{
    [self updateTabBarConstraints];
    [self updateTransitionViewConstraints];
    [self updateSelectedViewConstraints];
    [self updateViewHierarchyConstraints];
    [super updateViewConstraints];
}

- (void)createSubviews
{
    self.tabBar = [self createTabBar];
    self.transitionView = [self createTransitionView];
}

- (DRTabBar *)createTabBar
{
    DRTabBar *tabBar = [DRTabBar new];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.tabBarController = self;
    tabBar.translatesAutoresizingMaskIntoConstraints = NO;
    return tabBar;
}

- (UIView *)createTransitionView
{
    UIView *transitionView = [UIView new];
    transitionView.translatesAutoresizingMaskIntoConstraints = NO;
    return transitionView;
}

- (void)addSubviews
{
    [self.view addSubview:self.tabBar];
    [self.view addSubview:self.transitionView];
}

#pragma mark - Layout

- (void)updateTabBarConstraints
{
    // Remove old constraints
    [self.view removeConstraints:self.tabBarConstraints];
    self.tabBarConstraints = [NSMutableArray new];
    
    // Create variable binding
    UIView *tabBar = self.tabBar;
    id topLayoutGuide = self.topLayoutGuide;
    CGFloat height = self.viewControllers.count > 1 && !self.isTabBarHidden ? kTabBarHeight : 0;
    NSDictionary *views = NSDictionaryOfVariableBindings(tabBar, topLayoutGuide);
    
    // Create constraints
    [self.tabBarConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"H:|[tabBar]|" options:0 metrics:nil views:views]];
    [self.tabBarConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"V:[topLayoutGuide][tabBar]" options:0 metrics:nil views:views]];
    self.tabBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self.tabBar
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.0
                                                                constant:height];
    [self.tabBarConstraints addObject:self.tabBarHeightConstraint];
    
    // Add constraints
    [self.view addConstraints:self.tabBarConstraints];
}

- (void)updateTransitionViewConstraints
{
    // Remove old constraints
    [self.view removeConstraints:self.transitionViewConstraints];
    self.transitionViewConstraints = [NSMutableArray new];
    
    // Create variable binding
    UIView *transitionView = self.transitionView;
    id<UILayoutSupport> bottomLayoutGuide = self.bottomLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(transitionView, bottomLayoutGuide);
    NSDictionary *metrics = nil;
    
    // Create constraints
    [self.transitionViewConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"H:|[transitionView]|" options:0 metrics:nil views:views]];
    [self.transitionViewConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"V:[transitionView][bottomLayoutGuide]" options:0 metrics:metrics views:views]];
    
    // Add constraints
    [self.view addConstraints:self.transitionViewConstraints];
}

- (void)updateSelectedViewConstraints
{
    // Remove old constraints
    [self.view removeConstraints:self.selectedViewConstraints];
    self.selectedViewConstraints = [NSMutableArray new];
    
    // Create variable binding
    UIView *selectedView = self.selectedViewController.view;
    NSDictionary *views = NSDictionaryOfVariableBindings(selectedView);
    NSDictionary *metrics = nil;
    
    // Create constraints
    [self.selectedViewConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"H:|[selectedView]|" options:0 metrics:nil views:views]];
    [self.selectedViewConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"V:|[selectedView]|" options:0 metrics:metrics views:views]];
    
    // Add constraints
    [self.view addConstraints:self.selectedViewConstraints];
}

- (void)updateViewHierarchyConstraints
{
    // Remove old constraints
    [self.view removeConstraints:self.viewHierarchyConstraints];
    [self.viewHierarchyConstraints removeAllObjects];
    
    // Create variable binding
    UIView *tabBar = self.tabBar;
    UIView *transitionView = self.transitionView;
    id<UILayoutSupport> bottomLayoutGuide = self.bottomLayoutGuide;
    NSDictionary *views = NSDictionaryOfVariableBindings(tabBar, transitionView, bottomLayoutGuide);
    NSDictionary *metrics = nil;
    
    // Create constraints
    [self.viewHierarchyConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"V:[tabBar][transitionView][bottomLayoutGuide]" options:0 metrics:metrics views:views]];
    
    // Add constraints
    [self.view addConstraints:self.viewHierarchyConstraints];
}

#pragma mark - Tab bar

- (void)tabBarDidSelectTab:(DRTabBarItem *)tab atIndex:(NSUInteger)index
{
    self.selectedIndex = index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:self.viewControllers[index]];
    }
}

#pragma mark - View controllers

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
    //[self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    [_viewControllers addObject:viewController];
    
    // Create tab bar item?
    if (!viewController.drTabBarItem) {
        DRTabBarItem *tabBarItem = [DRTabBarItem new];
        tabBarItem.title = viewController.title ? viewController.title : @"No title";
        tabBarItem.selectedIndicatorImage = self.tabBar.selectionIndicatorImage;
        
        // .. add to view controller
        viewController.drTabBarItem = tabBarItem;
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
    [self setIsTabBarHidden:hidden withAnimation:animated];
}

- (void)setIsTabBarHidden:(BOOL)isTabBarHidden withAnimation:(BOOL)animation
{
    _isTabBarHidden = isTabBarHidden;
    
    self.tabBarHeightConstraint.constant = !isTabBarHidden ? kTabBarHeight : 0;
    
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else {
        [self.view layoutIfNeeded];
    }
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

- (void)setIsTabBarHidden:(BOOL)isTabBarHidden
{
    [self setIsTabBarHidden:isTabBarHidden withAnimation:NO];
}

- (UIViewController<DRTabBarControllerChild> *)selectedViewController
{
    if (self.viewControllers.count > self.selectedIndex) {
        return [self.viewControllers objectAtIndex:self.selectedIndex];
    }
    return nil;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    [self removeViewControllers:self.viewControllers];
    [self addViewControllers:viewControllers];
    
    if(viewControllers.count > 0) {
        self.selectedIndex = _selectedIndex;
    } else {
        // TODO: Remove current view controller..
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if(self.isViewLoaded) {
        
        UIViewController<DRTabBarControllerChild> *previousViewController = self.selectedViewController;
        UIViewController<DRTabBarControllerChild> *selectedViewController = [self.viewControllers objectAtIndex:selectedIndex];
        
        // Disable auto-resizing mask
        selectedViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [previousViewController.view removeFromSuperview];
        
        [self.transitionView addSubview:selectedViewController.view];
        
        // Notify controllers
        if ([previousViewController respondsToSelector:@selector(didEndBeeingSelectedViewController)]) {
            [previousViewController didEndBeeingSelectedViewController];
        }
        if ([selectedViewController respondsToSelector:@selector(didEndBeeingSelectedViewController)]) {
            [selectedViewController didBecomeSelectedViewController];
        }
        
        // Tell tab bar to select tab
        self.tabBar.selectedIndex = selectedIndex;
        
        [self.view setNeedsUpdateConstraints];
    }
    
    _selectedIndex = selectedIndex;
}

@end
