//
//  FacebookMenuButton.m
//  FacebookMenuButtonExample
//
//  Created by . Carlin on 4/12/14.
//  Copyright (c) 2014 Carlin Creations. All rights reserved.
//

#import "FacebookMenuButton.h"

#import <QuartzCore/QuartzCore.h>

    #define SIZE_DEFAULT_BAR_HEIGHT 2
    #define SIZE_DEFAULT_BAR_SPACING 5
    #define SIZE_DEFAULT_BAR_WIDTH 26

    #define TIME_ANIMATION_DURATION .5

    #define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@interface FacebookMenuButton ()

    /** Bar elements */
    @property (nonatomic, strong) UIView *bar1;
    @property (nonatomic, strong) UIView *bar2;
    @property (nonatomic, strong) UIView *bar3;

    /** Array to hold bars for quick access */
    @property (nonatomic, strong) NSArray *bars;

    /** Timing function for cubic bezier animation */
    @property (nonatomic, strong) CAMediaTimingFunction *timingFunction;

    @property (nonatomic, assign) BOOL inited;

@end

@implementation FacebookMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    [self updateBarFrame];
}

- (void)setBarTint:(UIColor *)barTint
{
    _barTint = barTint;

    [self updateBarTint];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    [self animateBars:selected];
}

// Create bars if they don't exist yet
- (void)createBars
{
    if (!self.inited) {
        self.barWidth = SIZE_DEFAULT_BAR_WIDTH;
        self.barHeight = SIZE_DEFAULT_BAR_HEIGHT;
        self.barSpacing = SIZE_DEFAULT_BAR_SPACING;
        self.barTint = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        [self updateBarTint];
        self.inited = true;
    }
    if (!self.bar1) {
        self.bar1 = [UIView new];
    }
    if (!self.bar2) {
        self.bar2 = [UIView new];
    }
    if (!self.bar3) {
        self.bar3 = [UIView new];
    }
    if (!self.bars) {
        NSMutableArray *bars = [NSMutableArray new];
        [bars addObject:self.bar1];
        [bars addObject:self.bar2];
        [bars addObject:self.bar3];
        for (UIView *bar in bars) {
            bar.backgroundColor = self.barTint;
            [self addSubview:bar];
        }
        self.bars = bars;
    }
}

- (void)updateBarFrame
{
    NSLog(@"updateBarFrame");

    // Create them if they don't exist
    [self createBars];

    // Setup for bar frame positions
    CGRect bounds = self.bounds;
    NSInteger paddingY = (CGRectGetHeight(bounds) - (self.bars.count * (self.barHeight + self.barSpacing))) / 2;
    NSInteger paddingX = (CGRectGetWidth(bounds) - self.barWidth) / 2;
    CGFloat cornerRadius = self.barHeight / 2;

    // Update bar frames
    CGFloat yOffset = paddingY;
    for (UIView *bar in self.bars)
    {
        bar.frame = CGRectMake(
            paddingX, yOffset,
            self.barWidth, self.barHeight
        );
        bar.layer.cornerRadius = cornerRadius;
        yOffset += self.barHeight + self.barSpacing;
    }
}

- (void)updateBarTint
{
    for (UIView *bar in self.bars) {
        bar.backgroundColor = self.barTint;
    }
}

- (void)animateBars:(BOOL)selected
{
    NSLog(@"animateBars: %i", selected);

    // Create timing function if needed
    if (!self.timingFunction) {
        self.timingFunction = [CAMediaTimingFunction
            functionWithControlPoints:1.0 :0.0 :0.645 :0.650];
    }

    // Setup
    CALayer *layer;
    CAKeyframeAnimation *animation;

    // Animate to closed X
    if (selected)
    {
        // Bar 1
        layer = self.bar1.layer;

        // Animate rotation
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(DEGREES_TO_RADIANS(0))
            , @(DEGREES_TO_RADIANS(145))
            , @(DEGREES_TO_RADIANS(130))
            , @(DEGREES_TO_RADIANS(135))
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"rotation"];

        // Animate position
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(0)
            , @(-self.barSpacing)
            , @(-self.barSpacing)
            , @(-self.barSpacing)
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"translation"];

        // Bar 2
        layer = self.bar2.layer;
        animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        animation.duration = TIME_ANIMATION_DURATION / 2;
        animation.values = @[ @(0.0) ];
        animation.keyTimes = @[ @(1.0) ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"opacity"];

        // Bar 3
        layer = self.bar3.layer;

        // Animate rotation
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(DEGREES_TO_RADIANS(0))
            , @(DEGREES_TO_RADIANS(-145))
            , @(DEGREES_TO_RADIANS(-130))
            , @(DEGREES_TO_RADIANS(-135))
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"rotation"];

        // Animate position
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(0)
            , @(self.barSpacing)
            , @(self.barSpacing)
            , @(self.barSpacing)
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"translation"];
    }
    else    // Show hamburger
    {
        // Bar 1
        layer = self.bar1.layer;

        // Animate rotation
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(DEGREES_TO_RADIANS(135))
            , @(DEGREES_TO_RADIANS(-10))
            , @(DEGREES_TO_RADIANS(5))
            , @(DEGREES_TO_RADIANS(0))
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"rotation"];

        // Animate position
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(-self.barSpacing)
            , @(-self.barSpacing)
            , @(-self.barSpacing)
            , @(0)
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"translation"];

        // Bar 2
        layer = self.bar2.layer;
        animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        animation.duration = TIME_ANIMATION_DURATION / 2;
        animation.values = @[ @(1.0) ];
        animation.keyTimes = @[ @(1.0) ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"opacity"];

        // Bar 3
        layer = self.bar3.layer;

        // Animate rotation
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(DEGREES_TO_RADIANS(-135))
            , @(DEGREES_TO_RADIANS(10))
            , @(DEGREES_TO_RADIANS(-5))
            , @(DEGREES_TO_RADIANS(0))
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"rotation"];

        // Animate position
        animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        animation.duration = TIME_ANIMATION_DURATION;
        animation.values = @[
            @(self.barSpacing)
            , @(self.barSpacing)
            , @(self.barSpacing)
            , @(0)
        ];
        animation.keyTimes = @[
            @(0.0), @(0.45), @(0.75), @(1.0)
        ];
        animation.timingFunction = self.timingFunction;
        animation.fillMode = kCAFillModeBoth;
        [layer addAnimation:animation forKey:@"translation"];
    }
}

/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
