//
//  DRTabBar.m
//  Pods
//
//  Created by David Runemalm on 2015-03-20.
//
//

#import "DRTabBar.h"
#import "DRTabBarController.h"

@interface DRTabBar ()

@property (strong, nonatomic) NSMutableArray *tabBarItemConstraints;

@end

@implementation DRTabBar

#pragma mark - View lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _tabBarItems = [NSMutableArray new];
    _tabBarItemConstraints = [NSMutableArray new];
}

#pragma mark - Tabs

- (void)addTabBarItem:(DRTabBarItem *)tabBarItem
{
    // Add reference to tab bar
    tabBarItem.tabBar = self;

    // Add tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTab:)];
    [tabBarItem addGestureRecognizer:tapGestureRecognizer];

    // Set selection indicator image
    tabBarItem.selectedIndicatorImage = self.selectionIndicatorImage;
    
    // Add to collection
    [self.tabBarItems addObject:tabBarItem];
    
    // Add to view hierarchy
    [self addSubview:tabBarItem];
    tabBarItem.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)didTapOnTab:(UITapGestureRecognizer *)tapGestureRecognizer
{
    DRTabBarItem *tab = (DRTabBarItem *)tapGestureRecognizer.view;
    NSUInteger index = [self.tabBarItems indexOfObject:tab];
    [self.tabBarController tabBarDidSelectTab:tab atIndex:index];
}

#pragma mark - Layout

- (void)updateConstraints
{
    [super updateConstraints];
    
    // Remove existing constraints
    [self removeConstraints:self.tabBarItemConstraints];
    [self.tabBarItemConstraints removeAllObjects];
    
    
    
    NSUInteger count = 0;
    NSNumber *width = @( round(CGRectGetWidth([UIScreen mainScreen].bounds) / (CGFloat)self.tabBarItems.count) );
    for (DRTabBarItem *item in self.tabBarItems) {
        
        // Create variable bindings
        NSNumber *xOffset = @( (CGFloat)count * [width floatValue] );
        NSDictionary *views = NSDictionaryOfVariableBindings(item);
        NSDictionary *metrics = NSDictionaryOfVariableBindings(width, xOffset);
        
        // Create constraints
        [self.tabBarItemConstraints addObjectsFromArray:
            [NSLayoutConstraint constraintsWithVisualFormat:
                @"H:|-xOffset-[item(width)]" options:0 metrics:metrics views:views]];
        [self.tabBarItemConstraints addObjectsFromArray:
            [NSLayoutConstraint constraintsWithVisualFormat:
                @"V:|[item]|" options:0 metrics:metrics views:views]];
        
        count++;
    }
    
    // Add constraints
    [self addConstraints:self.tabBarItemConstraints];
}

#pragma mark - Properties

- (void)setSelectionIndicatorImage:(UIImage *)selectionIndicatorImage
{
    _selectionIndicatorImage = selectionIndicatorImage;
    for (DRTabBarItem *tab in self.tabBarItems) {
        tab.selectedIndicatorImage = selectionIndicatorImage;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    for (DRTabBarItem *tab in self.tabBarItems) {
        tab.selected = [self.tabBarItems indexOfObject:tab] == selectedIndex;
    }
}

@end
