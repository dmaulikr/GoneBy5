//
//  OptionsUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OptionsUI.h"

#import "CCButton.h"
#import "CCDirector.h"
#import "CCLayoutBox.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "CCSpriteFrameCache.h"
#import "Game.h"
#import "InputBlockerUI.h"
#import "LevelSelectionScene.h"
#import "OptionsSettings.h"
#import "OptionsStore.h"
#import "SoundManager.h"

@interface OptionsUI()

@property (nonatomic) ScreenType currentScreen;
@property (nonatomic) UIEntity* contentNode;
@property (nonatomic) CCLayoutBox* buttonLayoutBox;
@property (nonatomic) CCButton* buttonExit;
@property (nonatomic) CCButton* buttonStore;
@property (nonatomic) CCButton* buttonSetting;

@end

@implementation OptionsUI

- (instancetype)initWithScreen:(ScreenType)screen
{
    self = [super init];
    
    CCSpriteFrame* frame = [CCSpriteFrame frameWithImageNamed:@"bgOptionsUI.png"];
    self.sprite.anchorPoint = ccp(0.5, 0.5);
    [self.sprite setSpriteFrame:frame];
    
    [self setupButtons];
    
    self.contentNode = [UIEntity new];
    self.contentNode.position = ccp(119, 30);
    self.contentNode.contentSize = CGSizeMake(frame.rect.size.width - 172, self.buttonLayoutBox.boundingBox.size.height - 3);
    [self.sprite addChild:self.contentNode];
    
    InputBlockerUI* inputBlocker = [[InputBlockerUI alloc] initWithImageNamed:@"bgOptionsUITop.png"];
    inputBlocker.anchorPoint = ccp(0.5, 1);
    inputBlocker.position = ccp(self.sprite.boundingBox.size.width / 2, self.sprite.boundingBox.size.height);
    [self.sprite addChild:inputBlocker];
    
    inputBlocker = [[InputBlockerUI alloc] initWithImageNamed:@"bgOptionsUIBottom.png"];
    inputBlocker.anchorPoint = ccp(0.5, 0);
    inputBlocker.position = ccp(self.sprite.boundingBox.size.width / 2, 0);
    [self.sprite addChild:inputBlocker];
    
    self.currentScreen = SCREEN_TYPE_NONE;
    [self changeContent:screen];
    
    return self;
}

- (void)tick:(CCTime)delta
{
    [self.contentNode tick:delta];
}

- (void)setupButtons
{
    self.buttonLayoutBox = [CCLayoutBox new];
    self.buttonLayoutBox.anchorPoint = CGPointMake(0.5, 0);
    self.buttonLayoutBox.direction = CCLayoutBoxDirectionVertical;
    self.buttonLayoutBox.spacing = 0;
    self.buttonLayoutBox.position = ccp(75, 30);
    [self.sprite addChild:self.buttonLayoutBox];
    
    NSArray* buttonNames = @[@"btnExitUI", @"btnStoreUI", @"btnSettingsUI"];

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnOptionsUI.plist"];

    for (NSString* buttonName in buttonNames) {
        NSString* normal = [NSString stringWithFormat:@"%@_normal", buttonName];
        NSString* selected = [NSString stringWithFormat:@"%@_selected", buttonName];
        NSString* disabled = [NSString stringWithFormat:@"%@_disabled", buttonName];
        
        CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:normal];
        CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:selected];
        CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:disabled];
        
        if ([buttonName isEqualToString:@"btnExitUI"]) {
            self.buttonExit = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
            [self.buttonLayoutBox addChild:self.buttonExit];
            [self.buttonExit setTarget:self selector:@selector(onExitButtonClicked)];
        }
        else if ([buttonName isEqualToString:@"btnStoreUI"]) {
            self.buttonStore = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
            [self.buttonLayoutBox addChild:self.buttonStore];
            [self.buttonStore setTarget:self selector:@selector(onStoreButtonClicked)];
        }
        else if ([buttonName isEqualToString:@"btnSettingsUI"]) {
            self.buttonSetting = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
            [self.buttonLayoutBox addChild:self.buttonSetting];
            [self.buttonSetting setTarget:self selector:@selector(onSettingsButtonClicked)];
        }
    }
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnReturnUI.plist"];
    
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(self.sprite.boundingBox.size.width - button.boundingBox.size.width, self.sprite.boundingBox.size.height / 2);
    [button setTarget:self selector:@selector(onReturnButtonClicked)];
    [self.sprite addChild:button];
}

- (void)onReturnButtonClicked
{
    [SoundManager playEffect:BUTTONPRESS];
    [self removeFromParent];
}

- (void)onExitButtonClicked
{
    [self changeContent:SCREEN_TYPE_NONE];
}

- (void)onStoreButtonClicked
{
    [self changeContent:SCREEN_TYPE_STORE];
}

- (void)onSettingsButtonClicked
{
    [self changeContent:SCREEN_TYPE_SETTINGS];
}

- (void)changeContent:(ScreenType)type
{
    if (self.currentScreen == type) {
        return;
    }
    
    self.currentScreen = type;
    [self downButtonState:self.currentScreen];
    [self.contentNode removeAllChildren];

    switch (type) {
        case SCREEN_TYPE_SETTINGS:
            [self.contentNode addChild:[[OptionsSettings alloc] initWithFrame:self.contentNode.boundingBox withTitle:@"SETTINGS"]];
            break;

        case SCREEN_TYPE_STORE:
            [self.contentNode addChild:[[OptionsStore alloc] initWithFrame:self.contentNode.boundingBox withTitle:@"SHOP"]];
            break;

        case SCREEN_TYPE_NONE:
            [[CCDirector sharedDirector] replaceScene:[LevelSelectionScene new]];
            break;
    }
    
    [SoundManager playEffect:BUTTONPRESS];
}

- (void)downButtonState:(ScreenType)type
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnOptionsUI.plist"];
    
    CCSpriteFrame* img = [CCSpriteFrame frameWithImageNamed:@"btnSettingsUI_normal"];
    [self.buttonSetting setBackgroundSpriteFrame:img forState:CCControlStateNormal];
    
    img = [CCSpriteFrame frameWithImageNamed:@"btnStoreUI_normal"];
    [self.buttonStore setBackgroundSpriteFrame:img forState:CCControlStateNormal];
    
    img = [CCSpriteFrame frameWithImageNamed:@"btnExitUI_normal"];
    [self.buttonExit setBackgroundSpriteFrame:img forState:CCControlStateNormal];

    switch (type) {
        case SCREEN_TYPE_SETTINGS:
            img = [CCSpriteFrame frameWithImageNamed:@"btnSettingsUI_selected"];
            [self.buttonSetting setBackgroundSpriteFrame:img forState:CCControlStateNormal];
            break;

        case SCREEN_TYPE_STORE:
            img = [CCSpriteFrame frameWithImageNamed:@"btnStoreUI_selected"];
            [self.buttonStore setBackgroundSpriteFrame:img forState:CCControlStateNormal];
            break;

        case SCREEN_TYPE_NONE:
            img = [CCSpriteFrame frameWithImageNamed:@"btnExitUI_selected"];
            [self.buttonExit setBackgroundSpriteFrame:img forState:CCControlStateNormal];
            break;
    }
}

@end
