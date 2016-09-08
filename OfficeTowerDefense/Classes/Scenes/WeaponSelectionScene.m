//
//  WeaponSelectionScene.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-11-24.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "WeaponSelectionScene.h"

#import "CCButton.h"
#import "CCDirector.h"
#import "CCLayoutBox.h"
#import "CCScrollView.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "CCSpriteFrameCache.h"
#import "CCTransition.h"
#import "DiamondUI2.h"
#import "GameSession.h"
#import "InputBlockerUI.h"
#import "LevelSelectionScene.h"
#import "MetaDataController.h"
#import "ModalDialog.h"
#import "NotificationNames.h"
#import "OptionsUI.h"
#import "PowerUpSelectionItemUI.h"
#import "SaveSettings.h"
#import "SoundManager.h"
#import "StoryScene.h"
#import "TimedGame.h"
#import "TrapSelectionItemUI.h"

extern const int SELECTED_BUTTONS_Y_POSITION;
extern const int SELECTED_BUTTONS_SPACING;

@interface WeaponSelectionScene()

@property (nonatomic, copy) NSString* levelID;

@property (nonatomic) int trapCount;
@property (nonatomic) int maxTraps;
@property (nonatomic) NSMutableArray* selectedTrapButtons;

@property (nonatomic) int powerUpCount;
@property (nonatomic) int maxPowerUps;
@property (nonatomic) NSMutableArray* selectedPowerUpButtons;

@property (nonatomic) CCButton* nextButton;

@property (nonatomic) DiamondUI* diamondUI;

@end

@implementation WeaponSelectionScene

- (instancetype)initWithLevelID:(NSString*)levelID
{
    self = [super init];
    
    NSDictionary* metaData = [MetaDataController instance].levelMetaData[levelID];
    self.levelID = levelID;
    
    self.trapCount = 0;
    self.maxTraps = [metaData[@"maxTraps"] intValue];
    self.selectedTrapButtons = [NSMutableArray new];
    
    for (int i = 0; i < self.maxTraps; i++) {
        [self.selectedTrapButtons addObject:[NSNull null]];
    }
    
    self.powerUpCount = 0;
    self.maxPowerUps = [metaData[@"maxPowerUps"] intValue];
    self.selectedPowerUpButtons = [NSMutableArray new];
    
    for (int i = 0; i < self.maxPowerUps; i++) {
        [self.selectedPowerUpButtons addObject:[NSNull null]];
    }
    
    return self;
}

-(void)onEnter
{
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    
    CCSprite* background = [CCSprite spriteWithImageNamed:@"bgWeaponSelection.png"];
    background.position = ccp(viewSize.width / 2, viewSize.height / 2);
    [self addChild:background];
        
    [self initTrapMenu];
    [self initPowerUpMenu];

    InputBlockerUI* inputBlocker = [[InputBlockerUI alloc] initWithImageNamed:@"bgWeaponSelectionTop.png"];
    inputBlocker.anchorPoint = ccp(0.5, 1);
    inputBlocker.position = ccp(viewSize.width / 2, viewSize.height);
    [self addChild:inputBlocker];

    inputBlocker = [[InputBlockerUI alloc] initWithImageNamed:@"bgWeaponSelectionBottom.png"];
    inputBlocker.anchorPoint = ccp(0.5, 0);
    inputBlocker.position = ccp(viewSize.width / 2, 0);
    [self addChild:inputBlocker];

    [self initTrapHolders];
    [self initPowerUpHolders];

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnReturnUI.plist"];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(viewSize.width - button.boundingBox.size.width, viewSize.height - 20);
    [button setTarget:self selector:@selector(onReturnButtonClicked)];
    [self addChild:button];

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnNextUI.plist"];
    normalFrame = [CCSpriteFrame frameWithImageNamed:@"btnNextUI_normal"];
    highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"btnNextUI_selected"];
    disabledFrame = [CCSpriteFrame frameWithImageNamed:@"btnNextUI_disabled"];
    button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(viewSize.width - button.boundingBox.size.width, button.boundingBox.size.height * 2);
    button.enabled = NO;
    [button setTarget:self selector:@selector(onNextButtonClicked)];
    self.nextButton = button;
    [self addChild:button];
    
    int diamonds = [SaveSettings getPlayerDiamonds];
    
#ifdef DEBUG
    diamonds = 1000;
#endif
    
    self.diamondUI = [DiamondUI2 new];
    [self.diamondUI setAmount:diamonds];
    self.diamondUI.position = ccp(viewSize.width - 102, viewSize.height - 32);
    [self addChild:self.diamondUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onAddDiamondsClicked:)
                                                 name:ADD_DIAMONDS_CLICKED
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDiamondsCollected:)
                                                 name:DIAMONDS_COLLECTED
                                               object:nil];
    
    [super onEnter];
}

- (void)onExit
{
    [super onExit];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)update:(CCTime)delta
{
    for (int i = (int)self.children.count - 1; i >= 0; i--) {
        id child = self.children[i];
        
        if ([child respondsToSelector:@selector(tick:)]) {
            [child tick:delta];
        }
    }    
}

- (void)initTrapMenu
{
    CCLayoutBox* selectionItems = [CCLayoutBox new];
    selectionItems.direction = CCLayoutBoxDirectionVertical;
    selectionItems.spacing = 42;
    
    NSMutableArray *allWeapons = [NSMutableArray array];
    // Add the players unlocked traps first
    [allWeapons addObjectsFromArray:[SaveSettings getPlayerTraps]];
    
    NSArray* weaponIDS = [MetaDataController instance].weaponMetaData.allKeys;
    NSArray* sortedIDs = [weaponIDS sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    for (NSString* weaponID in sortedIDs) {
        if ([weaponID hasPrefix:@"trap"]) {
            #ifdef DEBUG
            if (![allWeapons containsObject:weaponID]) {
                [allWeapons addObject:weaponID];
            }
            #else
            if([self isTrapLocked:weaponID]) {
                [allWeapons addObject:weaponID];
            }
            #endif
        }
    }
    
    for (int j = (int)allWeapons.count - 1; j >= 0; j--) {
        UIEntity* item = [[TrapSelectionItemUI alloc] initWithID:allWeapons[j] isLocked:[self isTrapLocked:allWeapons[j]] target:self selector:@selector(onTrapButtonSelected:)];
        
        [selectionItems addChild:item];
    }
    
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:selectionItems];
    scrollView.position = ccp(viewSize.width / 2 - 220, 127);
    scrollView.contentSizeType = CCSizeTypePoints;
    scrollView.contentSize = CGSizeMake(200, 160);
    scrollView.horizontalScrollEnabled = NO;
    scrollView.pagingEnabled = NO;
    scrollView.bounces = NO;
    [self addChild:scrollView];
}

- (void)initTrapHolders
{
    for (int i = 0; i < self.maxTraps; i++) {
        CCSprite* holder = [CCSprite spriteWithImageNamed:@"trapHolder.png"];
        float x = holder.boundingBox.size.width + i * (holder.boundingBox.size.width + SELECTED_BUTTONS_SPACING);
        float y = SELECTED_BUTTONS_Y_POSITION;
        
        holder.position = ccp(x, y);
        [self addChild:holder];
    }
}

- (void)initPowerUpMenu
{
    CCLayoutBox* selectionItems = [CCLayoutBox new];
    selectionItems.direction = CCLayoutBoxDirectionVertical;
    selectionItems.spacing = 42;
    
    NSArray* weaponIDS = [MetaDataController instance].weaponMetaData.allKeys;
    NSArray* sortedIDs = [weaponIDS sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    for (NSString* weaponID in sortedIDs.reverseObjectEnumerator) {
        if ([weaponID hasPrefix:@"powerUp"]) {
            UIEntity* item = [[PowerUpSelectionItemUI alloc] initWithID:weaponID target:self selector:@selector(onPowerUpButtonSelected:)];
        
            [selectionItems addChild:item];
        }
    }
    
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:selectionItems];
    scrollView.position = ccp(viewSize.width / 2 + 28, 127);
    scrollView.contentSizeType = CCSizeTypePoints;
    scrollView.contentSize = CGSizeMake(200, 160);
    scrollView.horizontalScrollEnabled = NO;
    scrollView.pagingEnabled = NO;
    scrollView.bounces = NO;
    [self addChild:scrollView];
}

- (void)initPowerUpHolders
{
    CGSize size = [CCDirector sharedDirector].viewSize;
    for (int i = 0; i < self.maxPowerUps; i++) {
        CCSprite* holder = [CCSprite spriteWithImageNamed:@"powerUpHolder.png"];
        float x = size.width - holder.boundingBox.size.width - i * (holder.boundingBox.size.width + SELECTED_BUTTONS_SPACING);
        float y = SELECTED_BUTTONS_Y_POSITION;
        
        holder.position = ccp(x, y);
        [self addChild:holder];
    }
}

- (void)onTrapButtonSelected:(CCButton*)button
{
    if (self.trapCount == self.maxTraps) {
        return;
    }
    
    self.trapCount++;
    button.enabled = NO;
    
    for (int i = 0; i < self.maxTraps; i++) {
        if (self.selectedTrapButtons[i] == [NSNull null]) {
            self.selectedTrapButtons[i] = button;
            
            NSString* trapID = button.userObject;
            CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_normal", trapID]];
            CCSpriteFrame* selectedFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_selected", trapID]];
            CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_disabled", trapID]];
            CCButton* trapButton = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:selectedFrame disabledSpriteFrame:disabledFrame];
            float x = trapButton.boundingBox.size.width + i * (trapButton.boundingBox.size.width + SELECTED_BUTTONS_SPACING);
            float y = SELECTED_BUTTONS_Y_POSITION;
            
            trapButton.position = ccp(x, y);
            trapButton.userObject = button;
            [trapButton setTarget:self selector:@selector(onTrapButtonDeselected:)];
            [self addChild:trapButton];
            break;
        }
    }
    
    self.nextButton.enabled = YES;
    [SoundManager playEffect:BUTTONPRESS];
}

- (void)onTrapButtonDeselected:(CCButton*)button
{
    self.trapCount--;
    
    CCButton* selectedButton = button.userObject;
    selectedButton.enabled = YES;
    
    for (int i = 0; i < self.maxTraps; i++) {
        if (self.selectedTrapButtons[i] == selectedButton) {
            self.selectedTrapButtons[i] = [NSNull null];
            break;
        }
    }
    
    [button removeFromParent];
    self.nextButton.enabled = (self.trapCount > 0);
    [SoundManager playEffect:BUTTONPRESS];
}

- (void)onPowerUpButtonSelected:(CCButton*)button
{
    if (self.powerUpCount == self.maxPowerUps) {
        return;
    }
    
    self.powerUpCount++;
    button.enabled = NO;
    CGSize size = [CCDirector sharedDirector].viewSize;
    
    for (int i = 0; i < self.maxPowerUps; i++) {
        if (self.selectedPowerUpButtons[i] == [NSNull null]) {
            self.selectedPowerUpButtons[i] = button;
            
            NSString* powerUpID = button.userObject;
            CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_normal", powerUpID]];
            CCSpriteFrame* selectedFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_selected", powerUpID]];
            CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_disabled", powerUpID]];
            CCButton* powerUpButton = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:selectedFrame disabledSpriteFrame:disabledFrame];
            float x = size.width - powerUpButton.boundingBox.size.width - i * (powerUpButton.boundingBox.size.width + SELECTED_BUTTONS_SPACING);
            float y = SELECTED_BUTTONS_Y_POSITION;
            
            powerUpButton.position = ccp(x, y);
            powerUpButton.userObject = button;
            [powerUpButton setTarget:self selector:@selector(onPowerUpButtonDeselected:)];
            [self addChild:powerUpButton];
            break;
        }
    }
    
    [SoundManager playEffect:BUTTONPRESS];
}

- (void)onPowerUpButtonDeselected:(CCButton*)button
{
    self.powerUpCount--;
    
    CCButton* selectedButton = button.userObject;
    selectedButton.enabled = YES;
    
    for (int i = 0; i < self.maxPowerUps; i++) {
        if (self.selectedPowerUpButtons[i] == selectedButton) {
            self.selectedPowerUpButtons[i] = [NSNull null];
            break;
        }
    }
    
    [button removeFromParent];
    [SoundManager playEffect:BUTTONPRESS];
}

- (void)onReturnButtonClicked
{
    [SoundManager playEffect:BUTTONPRESS];
    [[CCDirector sharedDirector] replaceScene:[LevelSelectionScene new]];
}

- (void)onNextButtonClicked
{
    [SoundManager playEffect:BUTTONPRESS];

    NSMutableArray* traps = [NSMutableArray new];
 
    for (int i = 0; i < self.maxTraps; i++) {
        if (self.selectedTrapButtons[i] != [NSNull null]) {
            CCButton* button = self.selectedTrapButtons[i];
            
            [traps addObject:button.userObject];
        }
    }
    
    NSMutableArray* powerUps = [NSMutableArray new];
    
    for (int i = 0; i < self.maxPowerUps; i++) {
        if (self.selectedPowerUpButtons[i] != [NSNull null]) {
            CCButton* button = self.selectedPowerUpButtons[i];
            
            [powerUps addObject:button.userObject];
        }
    }

    NSDictionary* metaData = [MetaDataController instance].levelMetaData[self.levelID];
    NSArray* comic = metaData[@"introComic"];
    Game* game = [[TimedGame alloc] initWithLevelID:self.levelID traps:traps powerUps:powerUps];
    
    if (comic.count > 0) {
        CCTransition* transition = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionLeft duration:0.25f];
        StoryScene* scene = [[StoryScene alloc] initWithFiles:comic nextScene:game];
        
        [[CCDirector sharedDirector] replaceScene:scene withTransition:transition];
    }
    else {
        [[CCDirector sharedDirector] replaceScene:game];
    }
}

- (BOOL)isTrapLocked:(NSString *)trapId
{
    BOOL locked = YES;
    
    NSArray* weaponIDS = [SaveSettings getPlayerTraps];
    NSArray* sortedIDs = [weaponIDS sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    for (NSString* weaponID in sortedIDs.reverseObjectEnumerator) {
        if ([trapId isEqualToString:weaponID]) {
            locked = NO;
        }
    }
    
    #ifdef DEBUG
        locked = NO;
    #endif
    
    return locked;
}

- (void)addModalDialog:(UIEntity*)ui removeOnScreenTouch:(BOOL)removeOnScreenTouch;
{
    ModalDialog* dialog = [[ModalDialog alloc] initWithUI:ui removeOnScreenTouch:removeOnScreenTouch];
    [self addChild:dialog];
}

- (void)onAddDiamondsClicked:(NSNotification*)notification
{
    [self addModalDialog:[[OptionsUI alloc] initWithScreen:SCREEN_TYPE_STORE] removeOnScreenTouch:NO];
}

- (void)onDiamondsCollected:(NSNotification *)notification
{
    NSDictionary* info = notification.userInfo;
    
    int diamonds = [SaveSettings getPlayerDiamonds];
    diamonds += [info[@"amount"] intValue];
    
    [SaveSettings setPlayerDiamonds:diamonds];
    [self.diamondUI setAmount:diamonds];
}

@end
