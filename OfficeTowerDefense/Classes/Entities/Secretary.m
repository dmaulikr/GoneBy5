//
//  Secretary.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-14.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Secretary.h"

#import "Actor.h"
#import "ColdFX.h"
#import "DizzyFX.h"
#import "EnemyEnterElevatorState.h"
#import "File.h"
#import "FilesFall.h"
#import "GameWorld.h"
#import "HitFX.h"
#import "SecretaryScaredState.h"
#import "SecretaryWalkState.h"

@interface Secretary()

@property (nonatomic) CGPoint filePosition;

@end

@implementation Secretary

- (instancetype)initWithID:(NSString*)ID coins:(int)coins hitPoints:(float)hitPoints speed:(float)speed_per_sec filePosition:(CGPoint)filePosition
{
    self = [super initWithID:ID coins:coins hitPoints:hitPoints speed:speed_per_sec];
    
    self.filePosition = filePosition;
    
    return self;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    self.files = [NSMutableArray new];
    
    float tempHitPoints = self.hitPoints;
    int fileCount = 0;
    
    while (tempHitPoints > 0) {
        File* file;
        
        if (tempHitPoints >= 16) {
            file = [[File alloc] initWithID:@"file4" hitPoints:16];
            tempHitPoints -= 16;
        }
        else if (tempHitPoints >= 8) {
            file = [[File alloc] initWithID:@"file3" hitPoints:8];
            tempHitPoints -= 8;
        }
        else if (tempHitPoints >= 4) {
            file = [[File alloc] initWithID:@"file2" hitPoints:4];
            tempHitPoints -= 4;
        }
        else if (tempHitPoints >= 2) {
            file = [[File alloc] initWithID:@"file1" hitPoints:2];
            tempHitPoints -= 2;
        }
        else {
            file = [[File alloc] initWithID:@"file0" hitPoints:1];
            tempHitPoints -= 1;
        }
        
        file.position = ccp(self.filePosition.x, self.filePosition.y + fileCount * file.height);
        fileCount++;
        
        [self.files addObject:file];
        [self addChild:file];
    }
    
    [self setState:[SecretaryWalkState new]];
}

- (void)scare
{
    if ([self.currentState isKindOfClass:[SecretaryScaredState class]] || [self.currentState isKindOfClass:[EnemyEnterElevatorState class]]) {
        return;
    }
    
    [self setState:[SecretaryScaredState new]];
}

- (void)exitElevator
{
    [self setState:[SecretaryWalkState new]];
}

- (void)givesFilesTo:(Actor*)actor
{
    while (self.files.count > 0) {
        File* file = [self.files lastObject];
        
        [self removeChild:file];
        [self.files removeLastObject];
        
        [actor addDamage:file.hitPoints];
    }
}

- (void)takeDamage:(float)damage overlay:(OverlayType)overlay dieAnimationName:(NSString *)animationName
{
    [super takeDamage:damage overlay:overlay dieAnimationName:animationName];
    
    File* file;
    
    do {
        file = [self.files lastObject];
        
        if (file) {
            damage = [file takeDamage:damage];
        
            if (damage >= 0) {
                [self.files removeLastObject];
                [self removeChild:file];
            
                CGPoint worldPosition = [self convertToWorldSpace:file.position];
                FilesFall* filesFall = [[FilesFall alloc] initWithPosition:worldPosition];
            
                [self.gameWorld addChild:filesFall];
            }
        }
    } while (file && damage > 0);
}

- (unsigned long)fileCount
{
    return self.files.count;
}

- (BOOL)isWalking
{
    return [self.currentState isKindOfClass:[SecretaryWalkState class]];
}

@end
