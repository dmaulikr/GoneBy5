//
//  DiamondUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-10.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "DiamondUI.h"

#import "CCButton.h"
#import "CCLabelBMFont.h"
#import "CCSpriteFrame.h"
#import "CCSpriteFrameCache.h"
#import "DiamondUIState.h"
#import "NotificationNames.h"

@interface DiamondUI()

@property (nonatomic) CCLabelBMFont* label;

@end

@implementation DiamondUI

- (instancetype)init
{
    self = [super initWithID:@"diamondUI"];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"addUI.plist"];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"addUI_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"addUI_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"addUI_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(45, 14);
    [button setTarget:self selector:@selector(onAddClicked:)];
    [self addChild:button];

    [self setAmount:0];
    [self setState:[DiamondUIState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION = @"animation";
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:1 loopCount:0 startFrame:0 endFrame:0];
}

- (void)setAmount:(int)amount
{
    NSString* text = [NSString stringWithFormat:@"%d", amount];
    
    if (!self.label) {
        self.label = [CCLabelBMFont labelWithString:text fntFile:@"fontDinCondensed36_white.fnt"];
        self.label.anchorPoint = ccp(0.5, 0);
        [self addChild:self.label];
    }
    
    self.label.string = text;
}

- (void)onAddClicked:(CCButton*)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ADD_DIAMONDS_CLICKED object:nil];
}

@end
