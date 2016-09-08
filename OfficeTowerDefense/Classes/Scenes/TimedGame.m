//
//  TimedGame.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-11-11.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TimedGame.h"

#import "Actor.h"
#import "Boss.h"
#import "BossLoseState.h"
#import "BossTransformState.h"
#import "CCDirector.h"
#import "ClockUI.h"
#import "DiamondUI.h"
#import "GameSession.h"
#import "GameWorld.h"
#import "MetaDataController.h"
#import "Wave.h"

@interface TimedGame()

@property (nonatomic) BOOL checkedHasBossFight;

@property (nonatomic) ClockUI* clockUI;

@end

@implementation TimedGame

- (instancetype)initWithLevelID:(NSString*)levelID traps:(NSArray*)traps powerUps:(NSArray*)powerUps
{
    self = [super initWithLevelID:levelID traps:traps powerUps:powerUps];
    self.checkedHasBossFight = NO;

    NSDictionary* metaData = [MetaDataController instance].levelMetaData[levelID];
    CCTime duration_sec = [metaData[@"duration_sec"] floatValue];
    
    [[GameSession instance] startWithDuration:duration_sec];
    [self setupUI];
    
    return self;
}

- (void)onUpdate:(CCTime)delta
{
    if ([GameSession instance].elapsedTime_sec == [GameSession instance].duration_sec && !self.checkedHasBossFight) {
        self.checkedHasBossFight = YES;
        
        State* state = (self.hasBossFight) ? [BossTransformState new] : [BossLoseState new];
        [self.gameWorld.boss setState:state];
    }
}

- (void)setupUI
{
    [super setupUI];
    
    CGSize size = [CCDirector sharedDirector].viewSize;

    self.clockUI = [ClockUI new];
    self.clockUI.position = ccp(75, size.height - 28);
    [self addChild:self.clockUI];
}

@end
