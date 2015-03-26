//
//  DRTabBarItem.m
//  Pods
//
//  Created by David Runemalm on 2015-03-19.
//
//

#import "DRTabBarItem.h"
#import "DRTabBar.h"

@interface DRTabBarItem ()

@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation DRTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    // Load interface from xib
    [[NSBundle mainBundle] loadNibNamed:@"DRTabBarItem" owner:self options:nil];
    
    // Set constraints
    self.customConstraints = [NSMutableArray new];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.view];
    [self setNeedsUpdateConstraints];
    
    // Init properties
    self.enabled = YES;
    self.imageInsets = UIEdgeInsetsZero;
    self.image = nil;
    self.title = @"No title";
    self.view.backgroundColor = [UIColor clearColor];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.selectedImageView.contentMode = UIViewContentModeCenter;
    self.selectedIndicatorImageView.contentMode = UIViewContentModeScaleToFill;
    self.selected = NO;
    
    // Load image
    self.imageView.image = self.image;
}

- (void)updateConstraints
{
    [self removeConstraints:self.customConstraints];
    [self.customConstraints removeAllObjects];
    
    UIView *view = self.view;
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.customConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"H:|[view]|" options:0 metrics:nil views:views]];
    [self.customConstraints addObjectsFromArray:
        [NSLayoutConstraint constraintsWithVisualFormat:
            @"V:|[view]|" options:0 metrics:nil views:views]];
    
    [self addConstraints:self.customConstraints];
    
    [super updateConstraints];
}

#pragma mark - Properties

- (void)setSelected:(BOOL)selected
{
    self.imageView.hidden = selected;
    self.selectedImageView.hidden = !selected;
    self.selectedIndicatorImageView.hidden = !selected;
}

- (NSString *)title
{
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (UIImage *)selectedImage
{
    return self.selectedImageView.image;
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    self.selectedImageView.image = selectedImage;
}

- (UIImage *)selectedIndicatorImage
{
    return self.selectedIndicatorImageView.image;
}

- (void)setSelectedIndicatorImage:(UIImage *)selectedIndicatorImage
{
    self.selectedIndicatorImageView.image = selectedIndicatorImage;
}

@end
