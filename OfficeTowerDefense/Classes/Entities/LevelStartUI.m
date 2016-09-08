//
//  LevelStartUI.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-23.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelStartUI.h"

#import "CCLabelBMFont.h"
#import "CCSprite.h"

@interface LevelStartUI()

@property (nonatomic, copy) NSString* ANIMATION;
@property (nonatomic, strong) NSString* levelID;
@property (nonatomic, strong) NSString* tip;

@end

@implementation LevelStartUI

- (instancetype)initWithLevelID:(NSString*)levelID tip:(NSString *)tip
{
    self = [super initWithID:@"levelStartUI"];
    
    self.contentSize = self.sprite.boundingBox.size;
    self.anchorPoint = ccp(0, 0.5);
    self.userInteractionEnabled = YES;
    self.levelID = levelID;
    self.tip = tip;
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION = @"animation";
    
    [self createAnimationWithName:self.ANIMATION anchorPoint:ccp(0.5, 0) duration:1 loopCount:0 startFrame:0 endFrame:0];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    
    CCLabelBMFont* label = [CCLabelBMFont labelWithString:[self.levelID substringFromIndex:5] fntFile:@"fontDinCondensed160_white.fnt"];
    label.anchorPoint = ccp(0.5, 0.9);
    label.width = self.sprite.boundingBox.size.width;
    label.alignment = CCTextAlignmentCenter;
    label.position = ccp(self.sprite.boundingBox.size.width / 2, self.sprite.boundingBox.size.height / 2);
    [self.sprite addChild:label];
    
    if (self.tip.length > 0) {
        CCLabelBMFont* tip = [CCLabelBMFont labelWithString:self.tip fntFile:@"fontDinCondensed30_white.fnt"];
        tip.anchorPoint = ccp(0.5, 1);
        tip.width = self.sprite.boundingBox.size.width;
        tip.alignment = CCTextAlignmentCenter;
        tip.position = ccp(self.sprite.boundingBox.size.width / 2, -10);
        [self.sprite addChild:tip];
    }
}


@end
