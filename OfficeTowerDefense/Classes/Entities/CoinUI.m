//
//  CoinUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CoinUI.h"

#import "CCLabelBMFont.h"
#import "CoinUIState.h"

@interface CoinUI()

@property (nonatomic, copy) NSString* ANIMATION;

@property (nonatomic) CCLabelBMFont* label;

@end

@implementation CoinUI

- (instancetype)init
{
    self = [super initWithID:@"coinUI"];
    
    [self setAmount:0];
    [self setState:[CoinUIState new]];
    
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

@end
