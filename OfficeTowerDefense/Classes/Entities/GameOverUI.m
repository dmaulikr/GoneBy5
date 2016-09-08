//
//  GameOverUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOverUI.h"

#import "CCButton.h"
#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "CCSpriteFrameCache.h"
#import "DiamondFX.h"
#import "GameOverUILoseState.h"
#import "GameOverUIWinState.h"
#import "LevelSelectionScene.h"
#import "MetaDataController.h"
#import "SoundManager.h"
#import "StoryScene.h"

@interface GameOverUI()

@property (nonatomic, copy) NSString* ANIMATION_LOSE;
@property (nonatomic, copy) NSString* ANIMATION_WIN;

@property (nonatomic, strong)NSString *level;
@property (nonatomic) BOOL winGame;
@property (nonatomic) BOOL isFirstTime;
@end

@implementation GameOverUI

- (instancetype)initWithWin:(NSString *)level firstTime:(BOOL)isFirstTime
{
    self = [super init];
    
    self.ID = @"gameOverUI";
    self.winGame = YES;
    self.level = level;
    self.isFirstTime = isFirstTime;
    
    NSString* filePath = [NSString stringWithFormat:@"%@.plist", self.ID];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];
    [self createAnimations];
    

    return self;
}

- (instancetype)initWithLose:(NSString *)level
{
    self = [super init];
    
    self.ID = @"gameOverUI";
    self.winGame = NO;
    self.level = level;
    
    NSString* filePath = [NSString stringWithFormat:@"%@.plist", self.ID];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];
    [self createAnimations];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_LOSE = @"lose";
    self.ANIMATION_WIN = @"win";
    
    [self createAnimationWithName:self.ANIMATION_LOSE anchorPoint:ccp(0.5, 0) duration:1 loopCount:0 startFrame:1 endFrame:1];
    [self createAnimationWithName:self.ANIMATION_WIN anchorPoint:ccp(0.5, 0) duration:0.5 loopCount:0 startFrame:0 endFrame:0];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    CGSize size = [CCDirector sharedDirector].viewSize;
    BOOL hasRewards = NO;
    
    if (self.winGame) {
        [SoundManager playEffect:WIN_LAUGH];
        
        NSDictionary* metaData = [MetaDataController instance].levelMetaData[self.level];
        NSDictionary* reward = metaData[@"rewards"];
        
        if (self.isFirstTime) {
            if (reward[@"diamonds"]) {
                hasRewards = YES;
                NSNumber* diamonds = reward[@"diamonds"];
                
                if (diamonds > 0) {
                    DiamondFX* diamondFx = [DiamondFX new];
                    diamondFx.anchorPoint = ccp(0, 1);
                    diamondFx.position = ccp(-(size.width / 4) + 60, size.height / 2 - 10);
                    [self addChild:diamondFx];
                    
                    CCLabelBMFont* diamondLabel = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"x %@", diamonds] fntFile:@"fontDinCondensed32_black.fnt"];
                    diamondLabel.anchorPoint = ccp(0.5, 1);
                    diamondLabel.alignment = CCTextAlignmentRight;
                    diamondLabel.position = ccp(-size.width / 4 + 60, size.height / 2 - 40);
                    [self addChild:diamondLabel];
                }
            }
        
            NSString* trapID = reward[@"traps"];
            
            if (trapID.length > 0) {
                hasRewards = YES;
                
                NSString* filePath = [NSString stringWithFormat:@"%@.plist", trapID];
                    
                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];
                CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_normal", trapID]];
                
                CCSprite* sprite = [[CCSprite alloc] initWithSpriteFrame:normalFrame];
                sprite.anchorPoint = ccp(0.5, 1);
                sprite.position = ccp(-(size.width / 4) - 30, size.height / 2);
                [self addChild:sprite];
                    
                CCLabelBMFont* unlocked = [CCLabelBMFont labelWithString:@"UNLOCKED" fntFile:@"fontDinCondensed32_black.fnt"];
                unlocked.anchorPoint = ccp(0.5, 1);
                unlocked.alignment = CCTextAlignmentCenter;
                unlocked.position = ccp(-(size.width / 4) - 30, size.height / 2 - sprite.contentSize.height - 3);
                [self addChild:unlocked];
            }
        }
        
        NSString* message = (hasRewards) ? @"No overtime today!\nI've got something\nnew for you:" : @"No overtime today!";
        
        CCLabelBMFont* text = [CCLabelBMFont labelWithString:message fntFile:@"fontDinCondensed60_black.fnt"];
        text.anchorPoint = ccp(0, 1);
        text.alignment = CCTextAlignmentLeft;
        text.position = ccp(-size.width / 4 - 75, size.height / 2 + 98);
        [self addChild:text];
    }
    else {
        [SoundManager playEffect:LOSE_HMM];
        CCLabelBMFont* text = [CCLabelBMFont labelWithString:@"Looks like you're\nstaying late tonight!" fntFile:@"fontDinCondensed60_black.fnt"];
        text.anchorPoint = ccp(0, 1);
        text.alignment = CCTextAlignmentLeft;
        text.position = ccp(-size.width / 4 - 75, size.height / 2 + 98);
        [self addChild:text];
    }
    
    self.cascadeOpacityEnabled = YES;
    self.position = ccp(size.width / 2, 0);
    
    State* state = (self.winGame) ? [GameOverUIWinState new] : [GameOverUILoseState new];
    [self setState:state];

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnNextUI.plist"];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"btnNextUI_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"btnNextUI_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"btnNextUI_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(-27, size.height / 2 - 68);
    [button setTarget:self selector:@selector(onNextButtonClicked)];
    [self addChild:button];
}

- (void)onNextButtonClicked
{
    if (self.winGame) {
        NSDictionary *metaData = [MetaDataController instance].levelMetaData[self.level];
        NSArray *comic = metaData[@"outroComic"];
        
        if (comic.count > 0) {
            StoryScene* scene = [[StoryScene alloc] initWithFiles:comic nextScene:[LevelSelectionScene new]];
            [[CCDirector sharedDirector] replaceScene:scene];
        }
        else {
            [[CCDirector sharedDirector] replaceScene:[LevelSelectionScene new]];
        }
    }
    else {
        [[CCDirector sharedDirector] replaceScene:[LevelSelectionScene new]];
    }
}

@end
