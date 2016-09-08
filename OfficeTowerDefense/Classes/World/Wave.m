//
//  Wave.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Wave.h"

#import "Boss.h"
#import "BossPointState.h"
#import "BossSitState.h"
#import "Enemy.h"
#import "EnemyFactory.h"
#import "GameSession.h"
#import "GameWorld.h"
#import "MetaDataController.h"

@interface Wave()

@property (nonatomic) float triggerPercentage;
@property (nonatomic) int maxEnemiesOnScreen;
@property (nonatomic) float minSpawnInterval_sec;
@property (nonatomic) float maxSpawnInterval_sec;
@property (nonatomic) float spawnDelay_sec;
@property (nonatomic, strong) NSMutableArray* enemyList;

@end

@implementation Wave

- (instancetype)initWithLevelID:(NSString*)levelID waveIndex:(int)waveIndex
{
    self = [super init];
    
    self.spawnDelay_sec = 0;

    NSDictionary* metaData = [MetaDataController instance].levelMetaData[levelID];
    NSDictionary* waveMetaData = metaData[@"waves"][waveIndex];
    
    self.triggerPercentage = [waveMetaData[@"triggerPercentage"] floatValue];
    self.maxEnemiesOnScreen = [waveMetaData[@"maxEnemiesOnScreen"] intValue];
    self.minSpawnInterval_sec = [waveMetaData[@"minSpawnInterval_sec"] intValue];
    self.maxSpawnInterval_sec = [waveMetaData[@"maxSpawnInterval_sec"] intValue];
    
    NSArray* enemyPool = waveMetaData[@"enemyPool"];
    
    self.enemyList = [NSMutableArray new];
    
    for (NSDictionary* enemyInfo in enemyPool) {
        NSString* enemyID = enemyInfo[@"enemyID"];
        int spawnPercentage = [enemyInfo[@"spawnPercentage"] floatValue] * 100;
    
        for (unsigned long i = 0; i < spawnPercentage; i++) {
            [self.enemyList addObject:enemyID];
        }
    }
        
    return self;
}

- (void)tick:(CCTime)delta gameWorld:(GameWorld*)gameWorld
{
    self.spawnDelay_sec += delta;
    
    if (gameWorld.enemiesOnScreen >= self.maxEnemiesOnScreen || self.spawnDelay_sec < self.minSpawnInterval_sec) {
        return;
    }
    
    if (self.spawnDelay_sec >= self.maxSpawnInterval_sec || arc4random() % 10 == 0) {
        self.spawnDelay_sec = 0;

        int randomIndex = arc4random() % self.enemyList.count;
        NSString* enemyID = self.enemyList[randomIndex];
        Enemy* enemy = [EnemyFactory createEnemyWithID:enemyID];
        
        if ([gameWorld.boss.currentState isKindOfClass:[BossSitState class]]) {
            [gameWorld.boss setState:[BossPointState new]];
        }
            
        enemy.position = [gameWorld getSpawnPoint];
        [gameWorld addChild:enemy];
    }
}

@end
