//
//  DSXVerticalSlider.h
//  DSXAwesomeKit
//
//  Created by David Schukin on 1/5/14.
//

#import "DSXVerticalSlider.h"
#import <Masonry/Masonry.h>

@interface DSXVerticalSlider ()

@property (nonatomic, assign) CGFloat startingY;
@property (nonatomic, assign) CGFloat offsetFromStartingY;
@property (nonatomic, strong) UIView *thumbView;

@end

@implementation DSXVerticalSlider

#pragma mark - UIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self != nil)
    {
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.thumbView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(self.thumbView.mas_width);
        
        // Set constraint on the thumbView's 'centerY' attribute rather than 'top',
        // so that its midpoint can reach the top/bottom of the slider and thus
        // slightly overlap the edge of the slider like UISlider
        make.centerY.equalTo(self.mas_top).with.offset([self currentThumbViewOffsetY]);
    }];
}

#pragma mark - Thumb view

- (UIView *)thumbView
{
    if (_thumbView == nil)
    {
        _thumbView = [[UIView alloc] init];
        _thumbView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(panGestureRecognized:)];
        panGesture.minimumNumberOfTouches = 1;
        panGesture.maximumNumberOfTouches = 1;
        [_thumbView addGestureRecognizer:panGesture];
        
        [self addSubview:_thumbView];
    }
    
    return _thumbView;
}

#pragma mark - Gesture recognition

- (void)panGestureRecognized:(UIPanGestureRecognizer *)panGesture
{
    if (panGesture.state == UIGestureRecognizerStateBegan)
    {
        self.startingY = CGRectGetMinY(self.thumbView.frame);
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [panGesture translationInView:self];
        self.offsetFromStartingY = translation.y;
        
        [self setNeedsUpdateConstraints];
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded)
    {
        self.startingY = CGRectGetMinY(self.thumbView.frame);
    }
}

- (CGFloat)currentThumbViewOffsetY
{
    CGFloat thumbViewY      = self.startingY + self.offsetFromStartingY;
    CGFloat thumbViewMinY   = 0;
    CGFloat thumbViewMaxY   = CGRectGetHeight(self.bounds);
    
    if (thumbViewY <= thumbViewMinY)
    {
        thumbViewY = thumbViewMinY;
    }
    else if (thumbViewY >= thumbViewMaxY)
    {
        thumbViewY = thumbViewMaxY;
    }
    
    return thumbViewY;
}

@end
