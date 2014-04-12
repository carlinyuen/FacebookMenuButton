//
//  FacebookMenuButton.h
//  FacebookMenuButtonExample
//
//  Created by . Carlin on 4/12/14.
//  Copyright (c) 2014 Carlin Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookMenuButton : UIButton

    /** Color for the menu bars, will be slightly transparent when unpressed */
    @property (nonatomic, strong) UIColor *barTint;

    /* Width of the menu bars */
    @property (nonatomic, assign) NSInteger barWidth;

    /* Height or thickness of the menu bars */
    @property (nonatomic, assign) NSInteger barHeight;

    /* Space between the menu bars */
    @property (nonatomic, assign) NSInteger barSpacing;

    /* Duration of the animation when selected */
    @property (nonatomic, assign) NSTimeInterval animationDuration;

@end
