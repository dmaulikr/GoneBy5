//
//  DiamondUI2.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-05-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondUI2.h"

#import "CCButton.h"
#import "CCSpriteFrameCache.h"

@implementation DiamondUI2

- (instancetype)init
{
    self = [super initWithID:@"diamondUI"];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"addUI.plist"];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"addUI_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"addUI_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"addUI_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(32, 14);
    [button setTarget:self selector:@selector(onAddClicked:)];
    [self addChild:button];
    
    [self setAmount:0];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION = @"animation";
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:1 loopCount:0 startFrame:1 endFrame:1];
}

@end
