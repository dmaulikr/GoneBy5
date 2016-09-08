//
//  ClockUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ClockUI.h"

#import "CCLabelBMFont.h"
#import "Clock.h"
#import "ClockUIState.h"
#import "GameSession.h"

@interface ClockUI()

@property (nonatomic, copy) NSString* ANIMATION;

@property (nonatomic) CCLabelBMFont* label;

@end

@implementation ClockUI

- (instancetype)init
{
    self = [super initWithID:@"clockUI"];
    
    Clock* clock = [Clock new];
    clock.position = ccp(-45, 12);
    [self addChild:clock];
    
    [self setState:[ClockUIState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION = @"animation";
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:1 loopCount:0 startFrame:0 endFrame:0];
}

- (void)setElapsedTime:(CCTime)elapsedTime_sec
{
    CCTime duration_min = ceil([GameSession instance].duration_sec / 60.0);
    CCTime duration_sec = duration_min * 60.0 - [GameSession instance].duration_sec;
    
    CCTime hours = 4.0;
    CCTime minutes = floor(elapsedTime_sec / 60.0);
    CCTime seconds = floor(elapsedTime_sec - minutes * 60.0) + duration_sec;
    
    while (seconds >= 60.0) {
        seconds -= 60.0;
        
        minutes++;
    }
    
    minutes += 60.0 - duration_min;
    
    if (minutes == 60.0) {
        minutes = 0;
        hours++;
    }
    
    NSString* text = [NSString stringWithFormat:@"%0.0f:%02.0f:%02.0f", hours, minutes, seconds];
    
    if (!self.label) {
        self.label = [CCLabelBMFont labelWithString:text fntFile:@"fontDinCondensed36_white.fnt"];
        self.label.anchorPoint = ccp(0.5, 0);
        [self addChild:self.label];
    }
    
    self.label.string = text;
}

@end
