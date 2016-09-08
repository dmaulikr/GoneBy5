//
//  WeaponCursor.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-01-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WeaponCursor.h"

#import "ButtonControl.h"
#import "GameSession.h"
#import "GameWorld.h"
#import "NotificationNames.h"
#import "Trap.h"
#import "WeaponFactory.h"
#import "WeaponIdleState.h"

@interface WeaponCursor() <ButtonControlDelegate>

@property (nonatomic, copy) NSString* weaponID;
@property (nonatomic) GameWorld* gameWorld;
@property (nonatomic) Weapon* weapon;

@end

@implementation WeaponCursor

- (instancetype)initWithWeaponID:(NSString*)weaponID gameWorld:(GameWorld*)gameWorld
{
    self = [super init];
    
    self.weaponID = weaponID;
    self.gameWorld = gameWorld;
    self.weapon = nil;
    
    return self;
}

- (void)onButtonControlTouchDown:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    self.weapon = [WeaponFactory getWeaponWithID:self.weaponID];
    [self.gameWorld addChild:self.weapon];
    self.weapon.cascadeOpacityEnabled = YES;
    self.weapon.scale = 1.25;
    self.weapon.opacity = 0.5;
    self.weapon.position = touch.locationInWorld;
}

- (void)onButtonControlTouchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    self.weapon.position = touch.locationInWorld;
    self.weapon.opacity = (self.weapon.canBePlaced) ? 1.0 : 0.5;

    if (self.weapon.grid.x < 0 || self.weapon.grid.x >= 10 || self.weapon.grid.y < 0 || self.weapon.grid.y >= 3) {
        return;
    }

    [self.weapon snapToGrid:1.25];
}

- (void)onButtonControlTouchUp:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (self.weapon.canBePlaced) {
        [self.weapon place];
        
        NSNumber* cost = [NSNumber numberWithInt:self.weapon.cost];
        NSDictionary* infoAmount = @{ @"amount" : cost };

        if ([self.weapon isKindOfClass:[Trap class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:COINS_SPENT object:nil userInfo:infoAmount];
        
            NSDictionary* infoID = @{ @"ID" : self.weapon.ID };
            [[NSNotificationCenter defaultCenter] postNotificationName:TRAP_COOLDOWN object:nil userInfo:infoID];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:DIAMONDS_SPENT object:nil userInfo:infoAmount];
        }
    }
    else {
        [self.weapon removeFromParent];
    }
    
    self.weapon = nil;
}

@end
