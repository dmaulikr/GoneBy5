//
//  Game.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-19.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Game.h"

#import "Actor.h"
#import "ButtonControl.h"
#import "CCButton.h"
#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCSpriteFrame.h"
#import "CCSpriteFrameCache.h"
#import "Coin.h"
#import "CoinFX.h"
#import "CoinUI.h"
#import "DiamondUI.h"
#import "GameSession.h"
#import "GameOverUI.h"
#import "GameWorld.h"
#import "LevelStartUI.h"
#import "MetaDataController.h"
#import "ModalDialog.h"
#import "NotificationNames.h"
#import "OptionsUI.h"
#import "SaveSettings.h"
#import "SoundManager.h"
#import "State.h"
#import "TrapRemovalCursor.h"
#import "WeaponCursor.h"
#import "Wave.h"

const int SELECTED_BUTTONS_Y_POSITION = 22;
const int SELECTED_BUTTONS_SPACING = 5;

@interface Game()

@property (nonatomic, copy) NSString* levelID;
@property (nonatomic) CCTime remainingDelta;

@property (nonatomic) NSMutableArray* waves;
@property (nonatomic) int currentWaveIndex;

@property (nonatomic, copy) NSArray* traps;
@property (nonatomic, copy) NSArray* powerUps;
@property (nonatomic) NSMutableArray* buttons;

@property (nonatomic) BOOL pauseGame;
@property (nonatomic) BOOL hasBossFight;
@property (nonatomic) int coins;
@property (nonatomic) int diamonds;

@property (nonatomic) DiamondUI* diamondUI;
@property (nonatomic) CoinUI* coinUI;
@property (nonatomic) OptionsUI* optionsUI;

@end

@implementation Game

- (instancetype)initWithLevelID:(NSString*)levelID traps:(NSArray*)traps powerUps:(NSArray*)powerUps
{
    self = [super init];
    
    self.levelID = levelID;
    self.remainingDelta = 0;
    self.userInteractionEnabled = YES;
    
    NSDictionary* metaData = [MetaDataController instance].levelMetaData[levelID];
    NSArray* wavesMetaData = metaData[@"waves"];
    
    self.waves = [NSMutableArray new];
    self.currentWaveIndex = -1;
    
    for (int i = 0; i < wavesMetaData.count; i++) {
        Wave* wave = [[Wave alloc] initWithLevelID:levelID waveIndex:i];
        [self.waves addObject:wave];
    }
    
    self.hasBossFight = [metaData[@"hasBossFight"] boolValue];
    self.coins = [metaData[@"money"] intValue];
    self.traps = traps;
    self.powerUps = powerUps;
    
    #ifdef DEBUG
    self.diamonds = 1000;
    #else
    self.diamonds = [SaveSettings getPlayerDiamonds];
    #endif
    
    self.gameWorld = [[GameWorld alloc] initWithLevelID:levelID];
    [self addChild:self.gameWorld];
    
    self.buttons = [NSMutableArray new];
    [self setupTraps];
    [self setupPowerUps];
    
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onActorDied:) name:ACTOR_DIED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAddDiamondsClicked:) name:ADD_DIAMONDS_CLICKED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBossDied:) name:BOSS_DIED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBossLose:) name:BOSS_LOSE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCoinsCollected:) name:COINS_COLLECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCoinsSpent:) name:COINS_SPENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDiamondsCollected:) name:DIAMONDS_COLLECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDiamondsSpent:) name:DIAMONDS_SPENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onModalDialogRemoved:) name:MODAL_DIALOG_REMOVED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTrapCooldown:) name:TRAP_COOLDOWN object:nil];

    NSDictionary* metaData = [MetaDataController instance].levelMetaData[self.levelID];

    [self addModalDialog:[[LevelStartUI alloc] initWithLevelID:self.levelID tip:metaData[@"tip"]] removeOnScreenTouch:YES];
    self.pauseGame = YES;
}

- (void)onExit
{
    [super onExit];
    
    [SoundManager stopMusic];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    for (ButtonControl* button in self.buttons) {
        [button removeAllDelegates];
    }
}

- (void)addChild:(CCNode*)child z:(NSInteger)z name:(NSString*)name
{
    [super addChild:child z:z name:name];
    
    if ([child isKindOfClass:[ButtonControl class]]) {
        ButtonControl* button = (ButtonControl*)child;
        
        [self.buttons addObject:button];
    }
}

- (void)addModalDialog:(UIEntity*)ui removeOnScreenTouch:(BOOL)removeOnScreenTouch;
{
    ModalDialog* dialog = [[ModalDialog alloc] initWithUI:ui removeOnScreenTouch:removeOnScreenTouch];
    [self addChild:dialog];
    
    [SoundManager pauseMusic];
    self.pauseGame = YES;
}

- (void)onModalDialogRemoved:(NSNotification*)notification
{
    [SoundManager playMusic:MUSIC_BACKGROUND];
    self.pauseGame = NO;
}

- (void)update:(CCTime)delta
{
    const CCTime UPDATE_DELTA = 1.0 / 60.0;
    
    self.remainingDelta += delta * [GameSession instance].timeScale;
    
    while (self.remainingDelta >= UPDATE_DELTA) {
        if (!self.pauseGame) {
            [GameSession instance].elapsedTime_sec = fmin([GameSession instance].duration_sec, [GameSession instance].elapsedTime_sec + UPDATE_DELTA);
        }
        
        for (int i = (int)self.children.count - 1; i >= 0; i--) {
            CCNode* child = self.children[i];
            
            if ([child isKindOfClass:[Entity class]]) {
                Entity* entity = (Entity*)child;
                
                if (entity.flaggedForRemoval) {
                    [entity.currentState onExit];
                    [self removeChild:entity];
                }
            }
        }

        for (int i = (int)self.children.count - 1; i >= 0; i--) {
            id child = self.children[i];
            
            if (child != self.gameWorld && [child respondsToSelector:@selector(tick:)]) {
                if ([child isKindOfClass:[ButtonControl class]]) {
                    if (!self.pauseGame) {
                        [child tick:UPDATE_DELTA];
                    }
                }
                else {
                    [child tick:UPDATE_DELTA];
                }
            }
        }
        
        if ([GameSession instance].status == GAME_STATUS_IN_PROGRESS && !self.pauseGame) {
            [self.gameWorld tick:UPDATE_DELTA];
            
            if (self.currentWaveIndex == -1 || self.currentWaveIndex < self.waves.count - 1) {
                float levelPercentage = [GameSession instance].elapsedTime_sec / [GameSession instance].duration_sec;
                Wave* nextWave = self.waves[self.currentWaveIndex + 1];
                
                if (levelPercentage >= nextWave.triggerPercentage) {
                    self.currentWaveIndex++;
                }
            }
            
            if (self.currentWaveIndex >= 0) {
                Wave* wave = self.waves[self.currentWaveIndex];
                [wave tick:UPDATE_DELTA gameWorld:self.gameWorld];
            }

            [self onUpdate:UPDATE_DELTA];
        }
        
        self.remainingDelta -= UPDATE_DELTA;
    }
}

- (void)onUpdate:(CCTime)delta
{
}

- (void)setupUI
{
    CGSize size = [CCDirector sharedDirector].viewSize;
        
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"fastForwardUI.plist"];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"fastForwardUI_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"fastForwardUI_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"fastForwardUI_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.togglesSelectedState = YES;
    button.position = ccp(size.width - button.boundingBox.size.width, size.height - 15);
    [button setTarget:self selector:@selector(onFastForwardClicked:)];
    [self addChild:button];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pauseUI.plist"];
    normalFrame = [CCSpriteFrame frameWithImageNamed:@"pauseUI_normal"];
    highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"pauseUI_selected"];
    disabledFrame = [CCSpriteFrame frameWithImageNamed:@"pauseUI_disabled"];
    button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(size.width - button.boundingBox.size.width * 2 - SELECTED_BUTTONS_SPACING, size.height - 15);
    [button setTarget:self selector:@selector(onPauseClicked:)];
    [self addChild:button];
    
    self.coinUI = [CoinUI new];
    [self.coinUI setAmount:self.coins];
    self.coinUI.position = ccp(197, size.height - 28);
    [self addChild:self.coinUI];

    self.diamondUI = [DiamondUI new];
    [self.diamondUI setAmount:self.diamonds];
    self.diamondUI.position = ccp(319, size.height - 29);
    [self addChild:self.diamondUI];
}

- (void)setupTraps
{
    for (int i = 0; i < self.traps.count; i++) {
        NSString* trapID = self.traps[i];
        WeaponCursor* weaponCursor = [[WeaponCursor alloc] initWithWeaponID:trapID gameWorld:self.gameWorld];
        CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_normal", trapID]];
        CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_selected", trapID]];
        CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_disabled", trapID]];
        ButtonControl* button = [[ButtonControl alloc] initWithNormalFrame:normalFrame highlightedFrame:highlightedFrame disabledFrame:disabledFrame];
        float x = button.boundingBox.size.width + i * (button.boundingBox.size.width + SELECTED_BUTTONS_SPACING);
        float y = SELECTED_BUTTONS_Y_POSITION;
        
        button.position = ccp(x, y);
        button.userObject = trapID;
        [button addDelegate:weaponCursor];
        
        NSDictionary* metaData = [MetaDataController instance].weaponMetaData[trapID];
        int trapCost = [metaData[@"cost"] intValue];
        
        CCSprite* coin = [[CCSprite alloc] initWithImageNamed:@"coinBkgnd.png"];
        coin.anchorPoint = ccp(0.5, 0);
        coin.position = ccp(button.boundingBox.size.width * 3/4 + 5, 0);
        [button addChild:coin z:1000];
        
        NSString* labelString = [NSString stringWithFormat:@"%@", metaData[@"cost"]];
        CCLabelBMFont* label = [CCLabelBMFont labelWithString:labelString fntFile:@"fontDinCondensed30_white.fnt" width:coin.boundingBox.size.width alignment:CCTextAlignmentCenter];
        label.anchorPoint = ccp(0.5, 0.5);
        label.position = ccp(coin.boundingBox.size.width / 2, 7);
        [coin addChild:label z:1000];
        
        button.enabled = (self.coins >= trapCost);
        
        [self addChild:button];
    }
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"trapRemover.plist"];
    TrapRemovalCursor* removalCursor = [[TrapRemovalCursor alloc] initWithGameWorld:self.gameWorld];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"trapRemover_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"trapRemover_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"trapRemover_disabled"];
    ButtonControl* button = [[ButtonControl alloc] initWithNormalFrame:normalFrame highlightedFrame:highlightedFrame disabledFrame:disabledFrame];
    CGSize size = [CCDirector sharedDirector].viewSize;
    float x = size.width - button.boundingBox.size.width;
    float y = SELECTED_BUTTONS_Y_POSITION;
    
    button.position = ccp(x, y);
    button.enabled = true;
    [button addDelegate:removalCursor];
    [self addChild:button];
}

- (void)setupPowerUps
{
    CGSize size = [CCDirector sharedDirector].viewSize;
    
    for (int i = 0; i < self.powerUps.count; i++) {
        NSString* powerUpID = self.powerUps[i];
        WeaponCursor* weaponCursor = [[WeaponCursor alloc] initWithWeaponID:powerUpID gameWorld:self.gameWorld];
        CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_normal", powerUpID]];
        CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_selected", powerUpID]];
        CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_disabled", powerUpID]];
        ButtonControl* button = [[ButtonControl alloc] initWithNormalFrame:normalFrame highlightedFrame:highlightedFrame disabledFrame:disabledFrame];
        float x = size.width - 50 - button.boundingBox.size.width - i * (button.boundingBox.size.width + SELECTED_BUTTONS_SPACING);
        float y = SELECTED_BUTTONS_Y_POSITION;

        button.position = ccp(x, y);
        button.userObject = powerUpID;
        [button addDelegate:weaponCursor];
        
        NSDictionary* metaData = [MetaDataController instance].weaponMetaData[powerUpID];
        int cost = [metaData[@"cost"] intValue];
        
        CCSprite* diamond = [[CCSprite alloc] initWithImageNamed:@"diamondBkgnd.png"];
        diamond.anchorPoint = ccp(0.5, 0);
        diamond.position = ccp(button.boundingBox.size.width * 3/4 + 5, 0);
        [button addChild:diamond z:1000];
        
        NSString* labelString = [NSString stringWithFormat:@"%@", metaData[@"cost"]];
        CCLabelBMFont* label = [CCLabelBMFont labelWithString:labelString fntFile:@"fontDinCondensed30_white.fnt" width:diamond.boundingBox.size.width alignment:CCTextAlignmentCenter];
        label.anchorPoint = ccp(0.5, 0);
        label.position = ccp(diamond.boundingBox.size.width / 2, -1);
        [diamond addChild:label z:1000];
        
        button.enabled = (self.diamonds >= cost);
        
        [self addChild:button];
    }
}

- (void)onFastForwardClicked:(CCButton*)sender
{
    [GameSession instance].timeScale = ([GameSession instance].timeScale == 1.0) ? 2.0 : 1.0;
}

- (void)onPauseClicked:(CCButton*)sender
{
    [self addModalDialog:[[OptionsUI alloc] initWithScreen:SCREEN_TYPE_SETTINGS] removeOnScreenTouch:NO];
}

- (void)onAddDiamondsClicked:(NSNotification*)notification
{
    [self addModalDialog:[[OptionsUI alloc] initWithScreen:SCREEN_TYPE_STORE] removeOnScreenTouch:NO];
}

- (void)touchBegan:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    for (ButtonControl* button in self.buttons) {
        [button onTouchBegan:touch withEvent:event];
    }
    
    [self.gameWorld onTouchBegan:touch withEvent:event];
}

- (void)touchMoved:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    for (ButtonControl* button in self.buttons) {
        [button onTouchMoved:touch withEvent:event];
    }
    
    [self.gameWorld onTouchMoved:touch withEvent:event];
}

- (void)touchEnded:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    for (ButtonControl* button in self.buttons) {
        [button onTouchEnded:touch withEvent:event];
    }
    
    [self.gameWorld onTouchEnded:touch withEvent:event];
}

- (void)touchCancelled:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
    for (ButtonControl* button in self.buttons) {
        [button onTouchCancelled:touch withEvent:event];
    }
    
    [self.gameWorld onTouchCancelled:touch withEvent:event];
}

- (void)onActorDied:(NSNotification*)notification
{
    [self onGameOver:NO];
}

- (void)onBossLose:(NSNotification*)notification
{
    [self onGameOver:YES];
}

- (void)onBossDied:(NSNotification*)notification
{
    [self onGameOver:YES];
}

- (void)onGameOver:(BOOL)isWin
{
    if (isWin) {
        NSArray *levels = [SaveSettings getSavedLevels];

        if (![levels containsObject:self.levelID]) {
            NSDictionary* metaData = [MetaDataController instance].levelMetaData[self.levelID];
            NSDictionary* reward = metaData[@"rewards"];
            
            if (reward[@"diamonds"]) {
                int diamonds = [SaveSettings getPlayerDiamonds];
                diamonds += [reward[@"diamonds"] intValue];
                [SaveSettings setPlayerDiamonds:diamonds];
            }
            
            if (reward[@"traps"]) {
                if ([reward[@"traps"] isKindOfClass:[NSArray class]]) {
                } else if ([reward[@"traps"] isKindOfClass:[NSString class]]) {
                    [SaveSettings setPlayerTraps:reward[@"traps"]];
                }
            }
        }
        
        [GameSession instance].status = GAME_STATUS_WIN;
        [self addModalDialog:[[GameOverUI alloc] initWithWin:self.levelID firstTime:![levels containsObject:self.levelID]] removeOnScreenTouch:NO];
        [SaveSettings setLevelCompleted:self.levelID];
    }
    else {
        [GameSession instance].status = GAME_STATUS_LOSE;
        [self addModalDialog:[[GameOverUI alloc] initWithLose:self.levelID] removeOnScreenTouch:NO];
    }
    
    for (ButtonControl* button in self.buttons) {
        button.paused = YES;
    }
}

- (void)onCoinsCollected:(NSNotification*)notification
{
    NSDictionary* info = notification.userInfo;
    
    self.coins += [info[@"amount"] intValue];
    [self.coinUI setAmount:self.coins];
    [self updateTrapButtons];
    
    CoinFX* fx = [CoinFX new];
    fx.position = ccp(self.coinUI.position.x - 45, self.coinUI.position.y - 18);
    [self addChild:fx];
}

- (void)onCoinsSpent:(NSNotification*)notification
{
    NSDictionary* info = notification.userInfo;
    
    self.coins -= [info[@"amount"] intValue];
    [self.coinUI setAmount:self.coins];
    [self updateTrapButtons];
}

- (void)onDiamondsCollected:(NSNotification*)notification
{
    NSDictionary* info = notification.userInfo;
    
    int diamonds = [SaveSettings getPlayerDiamonds];
    diamonds += [info[@"amount"] intValue];
    
    [SaveSettings setPlayerDiamonds:diamonds];
    self.diamonds = diamonds;
    
    [self.diamondUI setAmount:diamonds];
    [self updatePowerUpButtons];

    CoinFX* fx = [CoinFX new];
    fx.position = ccp(self.diamondUI.position.x - 45, self.diamondUI.position.y - 18);
    [self addChild:fx];
}

- (void)onDiamondsSpent:(NSNotification*)notification
{
    NSDictionary* info = notification.userInfo;
    
    self.diamonds -= [info[@"amount"] intValue];
    
    [SaveSettings setPlayerDiamonds:self.diamonds];
    
    [self.diamondUI setAmount:self.diamonds];
    [self updatePowerUpButtons];
}

- (void)updateTrapButtons
{
    for (ButtonControl* button in self.buttons) {
        NSString* ID = button.userObject;
        
        if ([ID hasPrefix:@"trap"] && ![ID isEqualToString:@"trapRemover"]) {
            NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
            int cost = [metaData[@"cost"] intValue];
            
            button.enabled = (self.coins >= cost);
        }
    }
}

- (void)updatePowerUpButtons
{
    for (ButtonControl* button in self.buttons) {
        NSString* ID = button.userObject;
        
        if ([ID hasPrefix:@"powerUp"]) {
            NSDictionary* metaData = [MetaDataController instance].weaponMetaData[ID];
            int cost = [metaData[@"cost"] intValue];
            
            button.enabled = (self.diamonds >= cost);
        }
    }
}

- (void)onTrapCooldown:(NSNotification*)notification
{
    NSString* trapID = notification.userInfo[@"ID"];
    
    for (ButtonControl* button in self.buttons) {
        NSString* ID = button.userObject;
        
        if ([trapID isEqualToString:ID]) {
            NSDictionary* metaData = [MetaDataController instance].weaponMetaData[trapID];
            float coolDown_sec = [metaData[@"purchaseInterval_sec"] floatValue];
            
            [button setCoolDownTime:coolDown_sec];
            break;
        }
    }
}

@end