//
//  GameWorld.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2014-12-08.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameWorld.h"

#import "Actor.h"
#import "ActorDieState.h"
#import "Boss.h"
#import "CCButton.h"
#import "CCDirector.h"
#import "CCSprite.h"
#import "Character.h"
#import "Coin.h"
#import "Elevator.h"
#import "Enemy.h"
#import "EnemyFactory.h"
#import "File.h"
#import "GameEntity.h"
#import "GameSession.h"
#import "LevelSelectionScene.h"
#import "LevelStartUI.h"
#import "MetaDataController.h"
#import "Weapon.h"
#import "WeaponSelectionScene.h"

@interface GameWorld()

@property (nonatomic, copy) NSString* levelID;
@property (nonatomic) float accumulatedCoins;
@property (nonatomic) float rateOfCoins_sec;

@property (nonatomic) CGPoint playAreaBottomLeft;
@property (nonatomic) CCSprite* grid;
@property (nonatomic) CCSprite* floor;

@property (nonatomic) Actor* actor;
@property (nonatomic) Boss* boss;

@property (nonatomic) NSMutableArray* elevators;
@property (nonatomic) NSMutableArray* characters;
@property (nonatomic) NSMutableArray* weapons;

@end

@implementation GameWorld

- (instancetype)initWithLevelID:(NSString*)levelID;
{
    self = [super init];
    
    self.levelID = levelID;
    self.accumulatedCoins = 0.0f;
    
    NSDictionary* metaData = [MetaDataController instance].levelMetaData[levelID];
    
    self.rateOfCoins_sec = [metaData[@"rateOfMoney_sec"] floatValue];

    NSString* background = metaData[@"background"];
    NSString* playArea = metaData[@"playArea"];
    
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    CCSprite* gameBackground = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%@", background]];
    gameBackground.position = ccp(viewSize.width / 2, viewSize.height / 2);
    [self addChild:gameBackground];
    
    CCSprite* gamePlayArea = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"%@", playArea]];
    gamePlayArea.position = ccp(viewSize.width / 2, viewSize.height / 2 + 4);
    self.playAreaBottomLeft = ccp(gamePlayArea.position.x - gamePlayArea.boundingBox.size.width / 2, gamePlayArea.position.y - gamePlayArea.boundingBox.size.height / 2);
    [self addChild:gamePlayArea];
    
    self.grid = [CCSprite spriteWithImageNamed:@"gridSize.png"];
    self.grid.anchorPoint = ccp(0, 0);
    
    self.floor = [CCSprite spriteWithImageNamed:@"floorSize.png"];
    self.floor.anchorPoint = ccp(0, 0);
    
    self.elevators = [NSMutableArray new];
    self.characters = [NSMutableArray new];
    self.weapons = [NSMutableArray new];
    
    self.drawNode = [CCDrawNode new];
    [self addChild:self.drawNode];
    
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    NSDictionary* levelMetaData = [MetaDataController instance].levelMetaData[self.levelID];
    NSArray* elevatorList = levelMetaData[@"elevators"];
    
    for (NSDictionary* elevatorMetaData in elevatorList) {
        NSString* elevatorID = elevatorMetaData[@"ID"];
        int floor = [elevatorMetaData[@"floor"] intValue];
        int capacity = [elevatorMetaData[@"capacity"] intValue];
        float delay_sec = [elevatorMetaData[@"delay_sec"] floatValue];
        float speed_sec = [elevatorMetaData[@"speed_sec"] floatValue];
        
        Elevator* elevator = [[Elevator alloc] initWithID:elevatorID capacity:capacity delay:delay_sec speed:speed_sec];
        
        switch (floor) {
            case 1:
                elevator.position = [self getFloorPositionFromGrid:ccp(0.5, 1)];
                elevator.scaleX = -1;
                break;
                
            case 2:
                elevator.position = [self getFloorPositionFromGrid:ccp(9.55, 2)];
                break;
        }
        
        [self addChild:elevator];
    }
    
    NSString* bossID = levelMetaData[@"bossID"];
    NSDictionary* bossMetaData = [MetaDataController instance].characterMetaData[bossID];
    float gridXPosition = [bossMetaData[@"gridXPosition"] floatValue];
    
    self.boss = (Boss*)[EnemyFactory createEnemyWithID:bossID];
    self.boss.position = [self getFloorPositionFromGrid:ccp(gridXPosition, 2)];
    [self addChild:self.boss];
    
    NSString* background = [NSString stringWithFormat:@"%@_background", bossID];
    CCSprite* sprite = [CCSprite spriteWithImageNamed:background];
    sprite.anchorPoint = ccp(0.5, 0);
    sprite.flipX = YES;
    sprite.position = [self getFloorPositionFromGrid:ccp(0.5, 2)];
    [self addChild:sprite];
    
    NSString* actorID = @"actor0";
    NSDictionary* actorMetaData = [MetaDataController instance].characterMetaData[actorID];
    float hitPoints = [actorMetaData[@"hitPoints"] floatValue];
    
    gridXPosition = [actorMetaData[@"gridXPosition"] floatValue];
    
    self.actor = [[Actor alloc] initWithID:actorID hitPoints:hitPoints];
    self.actor.position = [self getFloorPositionFromGrid:ccp(gridXPosition, 0)];
    [self addChild:self.actor];
}

- (CGPoint)getSpawnPoint
{
    return [self getFloorPositionFromGrid:ccp(0, 2)];
}

- (CGPoint)getGridFromPosition:(CGPoint)position
{
    CGSize gridSize = self.grid.boundingBox.size;
    
    float row = (position.y - self.playAreaBottomLeft.y) / gridSize.height;
    float column = (position.x - self.playAreaBottomLeft.x) / gridSize.width;
    
    return ccp(column, row);
}

- (CGPoint)getPositionFromGrid:(CGPoint)grid
{
    CGSize gridSize = self.grid.boundingBox.size;
    
    float x = self.playAreaBottomLeft.x + grid.x * gridSize.width;
    float y = self.playAreaBottomLeft.y + grid.y * gridSize.height;
    
    return ccp(x, y);
}

- (CGPoint)getCeilingPositionFromGrid:(CGPoint)grid
{
    int row = floor(grid.y);
    CGSize gridSize = self.grid.boundingBox.size;
    CGPoint position = [self getPositionFromGrid:ccp(grid.x, row)];
    position.y += gridSize.height - 0.1;
    
    return position;
}

- (CGPoint)getFloorPositionFromGrid:(CGPoint)grid
{
    int row = floor(grid.y);
    CGSize floorSize = self.floor.boundingBox.size;
    CGPoint position = [self getPositionFromGrid:ccp(grid.x, row)];
    position.y += floorSize.height;
    
    return position;
}

- (NSArray*)getCharactersInGrid:(CGPoint)grid
{
    NSMutableArray* characters = [NSMutableArray new];
    int gridRow = floor(grid.y);
    int gridColumn = floor(grid.x);
    
    for (Character* character in self.characters) {
        if (!character.visible) {
            continue;
        }
        
        int row = floor(character.grid.y);
        int column = floor(character.grid.x);
        
        if (gridRow == row && gridColumn == column) {
            [characters addObject:character];
        }
    }
    
    return characters;
}

- (NSArray*)getCharactersIntersectingGrid:(CGPoint)grid
{
    NSMutableArray* characters = [NSMutableArray new];
    int gridRow = floor(grid.y);
    int gridColumn = floor(grid.x);
    
    for (Character* character in self.characters) {
        if (!character.visible) {
            continue;
        }

        int row = floor(character.frontGrid.y);
        int minColumn = fmin(character.frontGrid.x, character.rearGrid.x);
        int maxColumn = fmax(character.frontGrid.x, character.rearGrid.x);
        
        if (gridRow == row && minColumn <= gridColumn && gridColumn <= maxColumn) {
            [characters addObject:character];
        }
    }
    
    return characters;
}

- (NSArray*)getWeaponsAtGrid:(CGPoint)grid
{
    NSMutableArray* weapons = [NSMutableArray new];
    int gridRow = floor(grid.y);
    int gridColumn = floor(grid.x);
    
    for (Weapon* weapon in self.weapons) {
        if (!weapon.isPlaced) {
            continue;
        }
        
        int row = floor(weapon.grid.y);
        int column = floor(weapon.grid.x);
        
        if (gridRow == row && gridColumn == column) {
            [weapons addObject:weapon];
        }
    }
    
    return weapons;
}

- (Elevator*)getElevatorAtGrid:(CGPoint)grid
{
    int gridRow = floor(grid.y);
    int gridColumn = floor(grid.x);
    
    for (Elevator* elevator in self.elevators) {
        CGPoint elevatorGrid = [self getGridFromPosition:elevator.position];
        int row = elevatorGrid.y;
        int column = elevatorGrid.x;
        
        if (gridRow == row && gridColumn == column) {
            return elevator;
        }
    }
    
    return nil;
}

- (unsigned long)enemiesOnScreen
{
    return (self.characters.count - 2);
}

- (void)addChild:(CCNode*)child z:(NSInteger)z name:(NSString*)name
{
    if ([child isKindOfClass:[GameEntity class]]) {
        GameEntity* gameEntity = (GameEntity*)child;
        gameEntity.gameWorld = self;
    }
    
    if ([child isKindOfClass:[Character class]]) {
        [self.characters addObject:child];
    }
    else if ([child isKindOfClass:[Weapon class]]) {
        [self.weapons addObject:child];
    }
    else if ([child isKindOfClass:[Elevator class]]) {
        [self.elevators addObject:child];
    }

    [super addChild:child z:z name:name];
}

- (void)removeChild:(CCNode*)child cleanup:(BOOL)cleanup
{
    [super removeChild:child cleanup:cleanup];
    
    if ([child isKindOfClass:[GameEntity class]]) {
        GameEntity* gameEntity = (GameEntity*)child;
        gameEntity.gameWorld = nil;
    }
    
    if ([child isKindOfClass:[Character class]]) {
        [self.characters removeObject:child];
    }
    else if ([child isKindOfClass:[Weapon class]]) {
        [self.weapons removeObject:child];
    }
    else if ([child isKindOfClass:[Elevator class]]) {
        [self.elevators removeObject:child];
    }
}

- (void)tick:(CCTime)delta
{
    for (int i = (int)self.children.count - 1; i >= 0; i--) {
        CCNode* child = self.children[i];
        
        if ([child isKindOfClass:[GameEntity class]]) {
            GameEntity* entity = (GameEntity*)child;
            
            if (entity.flaggedForRemoval) {
                [entity.currentState onExit];
                [self removeChild:entity];
            }
        }
    }

    for (int i = (int)self.children.count - 1; i >= 0; i--) {
        id child = self.children[i];
        
        if ([child respondsToSelector:@selector(tick:)]) {
            [child tick:delta];
        }
    }
    
    self.accumulatedCoins += self.rateOfCoins_sec * delta;
    
    while (self.accumulatedCoins >= 1) {
        self.accumulatedCoins -= 1;
        
        float xOffset = drand48() * 40 - 20;
        CGPoint position = ccp(self.actor.position.x + xOffset, self.actor.position.y);
        Coin* coin = [[Coin alloc] initWithAmount:1 position:position];
        
        [self addChild:coin];
    }
}

- (void)onTouchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    for (CCNode* child in self.children) {
        if ([child isKindOfClass:[Entity class]]) {
            Entity* entity = (Entity*)child;
            [entity onTouchEnded:touch withEvent:event];
        }
    }
}

- (void)onReturnButton:(CCButton*)button
{
    [[CCDirector sharedDirector] replaceScene:[LevelSelectionScene new]];
}

- (void)onRetryButton:(CCButton*)button
{
    [[CCDirector sharedDirector] replaceScene:[WeaponSelectionScene new]];
}

@end
