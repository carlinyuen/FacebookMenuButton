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

@interface FacebookMenuButton ()

    @property (nonatomic, strong) UIView *bar1;
    @property (nonatomic, strong) UIView *bar2;
    @property (nonatomic, strong) UIView *bar3;
    @property (nonatomic, strong) NSMutableArray *bars;

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
        self.bars = [NSMutableArray new];
        [self.bars addObject:self.bar1];
        [self.bars addObject:self.bar2];
        [self.bars addObject:self.bar3];

        for (UIView *bar in self.bars) {
            bar.backgroundColor = self.barTint;
            [self addSubview:bar];
        }
    }
}

- (void)updateBarFrame
{
    NSLog(@"updateBarFrame");

    // Create them if they dne
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

/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
