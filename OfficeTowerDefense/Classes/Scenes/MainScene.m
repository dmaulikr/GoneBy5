//
//  MainScene.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-10-20.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MainScene.h"

#import "CCButton.h"
#import "CCDirector.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "CCSpriteFrameCache.h"
#import "CCTransition.h"
#import "LevelSelectionScene.h"
#import "SaveSettings.h"
#import "SoundManager.h"
#import "StoryScene.h"
#import "TimedGame.h"
#import "MetaDataController.h"

@implementation MainScene

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    [[MetaDataController instance] loadMetaData];
    // User automatically has access to trap0
    [SaveSettings setPlayerTraps:@"trap0"];
    
    [self loadBackground];
    [self loadButtons];
}

- (void)loadBackground
{
    CCSprite* background = [CCSprite spriteWithImageNamed:@"mainScreen.png"];
    background.position = ccp(self.boundingBox.size.width / 2, self.boundingBox.size.height / 2);
    [self addChild:background];
}

- (void)loadButtons
{
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    CGFloat centerX = viewSize.width / 2;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnStart.plist"];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"btnStart_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"btnStart_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"btnStart_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(centerX, 45);
    [button setTarget:self selector:@selector(onStartButtonClicked)];
    [self addChild:button];
}

- (void)onStartButtonClicked
{
    [SoundManager playEffect:BUTTONPRESS];

    if (![SaveSettings getLaunchedComic]) {
        [SaveSettings setSongEnabled:YES];
        [SaveSettings setSoundEnabled:YES];
        
        CCScene* levelSelectionScene = [LevelSelectionScene new];
        NSArray *comic = @[@"story1.png", @"story2.png", @"story3.png", @"story4.png"];

        CCTransition* transition = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionLeft duration:0.25f];
        StoryScene* scene = [[StoryScene alloc] initWithFiles:comic nextScene:levelSelectionScene];
        [SaveSettings setLaunchedComic];
        
        [[CCDirector sharedDirector] replaceScene:scene withTransition:transition];
    }
    else {
        CCScene* scene = [LevelSelectionScene new];
        [[CCDirector sharedDirector] replaceScene:scene];
    }
}

@end
