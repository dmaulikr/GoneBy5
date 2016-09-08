//
//  TrapRemovalCursor.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TrapRemovalCursor.h"

#import "GameWorld.h"
#import "Trap.h"
#import "TrapRemover.h"
#import "TrapRemoverRemoveTrapState.h"
#import "Weapon.h"
#import "WeaponIdleState.h"

@interface TrapRemovalCursor() <ButtonControlDelegate>

@property (nonatomic) TrapRemover* remover;
@property (nonatomic) GameWorld* gameWorld;

@end

@implementation TrapRemovalCursor

- (instancetype)initWithGameWorld:(GameWorld*)gameWorld
{
    self = [super init];
    
    self.gameWorld = gameWorld;
    
    return self;
}

- (void)onButtonControlTouchDown:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    self.remover = [TrapRemover new];
    [self.gameWorld addChild:self.remover];
    self.remover.position = touch.locationInWorld;
}

- (void)onButtonControlTouchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    self.remover.position = touch.locationInWorld;
    
    if (self.remover.grid.x < 0 || self.remover.grid.x >= 10 || self.remover.grid.y < 0 || self.remover.grid.y >= 3) {
        if (![self.remover.currentState isKindOfClass:[WeaponIdleState class]]) {
            [self.remover setState:[WeaponIdleState new]];
        }
        return;
    }
    
    NSArray* weapons = [self.gameWorld getWeaponsAtGrid:self.remover.grid];
    
    for (Weapon* weapon in weapons) {
        if ([weapon isKindOfClass:[Trap class]]) {
            if (weapon.placement == PLACEMENT_BOTTOM) {
                self.remover.position = ccp(weapon.position.x, weapon.position.y + weapon.sprite.boundingBox.size.height / 4);
            }
            else if (weapon.placement == PLACEMENT_TOP) {
                self.remover.position = ccp(weapon.position.x, weapon.position.y - weapon.sprite.boundingBox.size.height / 4);
            }
            
            if (![self.remover.currentState isKindOfClass:[TrapRemoverRemoveTrapState class]]) {
                [self.remover setState:[TrapRemoverRemoveTrapState new]];
            }
            
            return;
        }
    }
    
    if (![self.remover.currentState isKindOfClass:[WeaponIdleState class]]) {
        [self.remover setState:[WeaponIdleState new]];
    }
}

- (void)onButtonControlTouchUp:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    NSArray* weapons = [self.gameWorld getWeaponsAtGrid:self.remover.grid];
    
    for (Weapon* weapon in weapons) {
        if ([weapon isKindOfClass:[Trap class]]) {
            [weapon removeFromParent];
        }
    }
    
    [self.remover removeFromParent];
    self.remover = nil;
}

@end
