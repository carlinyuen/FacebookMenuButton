//
//  FacebookMenuButton.m
//  FacebookMenuButtonExample
//
//  Created by . Carlin on 4/12/14.
//  Copyright (c) 2014 Carlin Creations. All rights reserved.
//

#import "FacebookMenuButton.h"

#import <QuartzCore/QuartzCore.h>

@interface FacebookMenuButton ()

    @property (nonatomic, strong) UIView *bar1;
    @property (nonatomic, strong) UIView *bar2;
    @property (nonatomic, strong) UIView *bar3;
    @property (nonatomic, strong) NSMutableArray *bars;

@end

@implementation FacebookMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateBarFrame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    [self updateBarFrame];
}

- (void)setBarColor:(UIColor *)barColor
{
    _barColor = barColor;

    [self updateBarColor];
}

// Create bars if they don't exist yet
- (void)createBars
{
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
            bar.backgroundColor = [UIColor whiteColor];
            [self addSubview:bar];
        }
    }
}

- (void)updateBarFrame
{
    NSLog(@"updateBars");
    [self createBars];

    // Setup for bar frame positions
    CGRect bounds = self.bounds;
    CGFloat barHeight = CGRectGetHeight(bounds) / 12;
    CGFloat barWidth = CGRectGetWidth(bounds) / 5 * 3;
    CGFloat paddingY = CGRectGetHeight(bounds) / 4;
    CGFloat paddingX = CGRectGetWidth(bounds) / 5;
    CGFloat paddingBar = CGRectGetHeight(bounds) / 8;
    CGFloat cornerRadius = barHeight / 2;

    // Update bar frames
    self.bar1.frame = CGRectMake(
        paddingX, paddingY,
        barWidth, barHeight
    );
    self.bar1.layer.cornerRadius = cornerRadius;

    self.bar2.frame = CGRectMake(
        paddingX, paddingY + barHeight + paddingBar,
        barWidth, barHeight
    );
    self.bar2.layer.cornerRadius = cornerRadius;

    self.bar3.frame = CGRectMake(
        paddingX, paddingY + barHeight * 2 + paddingBar * 2,
        barWidth, barHeight
    );
    self.bar3.layer.cornerRadius = cornerRadius;
}

- (void)updateBarColor
{
    self.bar1.backgroundColor
        = self.bar2.backgroundColor
        = self.bar3.backgroundColor
        = self.barColor;
}

/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
