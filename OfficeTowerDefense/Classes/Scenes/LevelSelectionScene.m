//
//  LevelSelectionScene.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-10-20.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "LevelSelectionScene.h"

#import "ccTypes.h"
#import "CCButton.h"
#import "CCDirector.h"
#import "CCLabelBMFont.h"
#import "CCLayoutBox.h"
#import "CCScrollView.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "CCSpriteFrameCache.h"
#import "GameSession.h"
#import "InputBlockerUI.h"
#import "MainScene.h"
#import "MetaDataController.h"
#import "SaveSettings.h"
#import "SoundManager.h"
#import "WeaponSelectionScene.h"

@interface LevelSelectionScene()

@end

@implementation LevelSelectionScene

- (void)onEnter
{
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    
    CCSprite* background = [CCSprite spriteWithImageNamed:@"bgLevelSelection.png"];
    background.position = ccp(viewSize.width / 2, viewSize.height / 2);
    [self addChild:background];

    [self initAllPages];
    
    InputBlockerUI* inputBlocker = [[InputBlockerUI alloc] initWithImageNamed:@"bgLevelSelectionTop.png"];
    inputBlocker.anchorPoint = ccp(0.5, 1);
    inputBlocker.position = ccp(viewSize.width / 2, viewSize.height);
    [self addChild:inputBlocker];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnReturnUI.plist"];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_normal"];
    CCSpriteFrame* highlightedFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_selected"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"btnReturnUI_disabled"];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:highlightedFrame disabledSpriteFrame:disabledFrame];
    button.position = ccp(viewSize.width - button.boundingBox.size.width, viewSize.height - 20);
    [button setTarget:self selector:@selector(onReturnButtonClicked)];
    
    [self addChild:button];
    
    [super onEnter];
}

- (void)initAllPages
{
    NSDictionary* metaData = [MetaDataController instance].levelMetaData;
    NSArray* completedLevels = [SaveSettings getSavedLevels];

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"btnLevelUI.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"levelEmpty.plist"];
    
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    int level = 1;
    NSMutableArray* buttonLayouts = [NSMutableArray new];
    
    for (int row = 0; row < 6; row++) {
        CCLayoutBox* buttonLayout = [CCLayoutBox new];
        buttonLayout.direction = CCLayoutBoxDirectionHorizontal;
        buttonLayout.spacing = 2;
            
        for (int column = 0; column < 7; column++) {
            CCButton* button;
            
            if (column == 0 || column == 6) {
                CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"levelEmpty_normal"];
                CCSpriteFrame* selectedFrame = [CCSpriteFrame frameWithImageNamed:@"levelEmpty_selected"];
                CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"levelEmpty_disabled"];
                button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:selectedFrame disabledSpriteFrame:disabledFrame];
                button.enabled = NO;
            }
            else {
                NSString* levelID = [NSString stringWithFormat:@"level%d", level];
                CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"btnLevelUI_normal"];
                CCSpriteFrame* selectedFrame = [CCSpriteFrame frameWithImageNamed:@"btnLevelUI_selected"];
                CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"btnLevelUI_disabled"];
                button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:selectedFrame disabledSpriteFrame:disabledFrame];
                button.userObject = levelID;
                [button setTarget:self selector:@selector(onLevelSelected:)];
                button.enabled = (level <= metaData.count);
                
                NSString* labelString = [NSString stringWithFormat:@"%d", level];
                CCLabelBMFont* label = [CCLabelBMFont labelWithString:labelString fntFile:@"fontDinCondensed60_white.fnt" width:button.boundingBox.size.width alignment:CCTextAlignmentCenter];
                label.anchorPoint = ccp(0.5, 0);
                label.position = ccp(button.boundingBox.size.width / 2, 4);
                [button addChild:label];
                
                #ifndef DEBUG
                if (level > [self getHighestLevel] + 1) {
                    [button setEnabled:NO];
                }
                #endif
                
                for (int j = 0; j < completedLevels.count; j++) {
                    if ([levelID isEqualToString:completedLevels[j]]) {
                        CCSprite* check = [CCSprite spriteWithImageNamed:@"levelComplete.png"];
                        check.position = ccp(button.contentSize.width / 2, button.contentSize.height / 2);
                        [button addChild:check];
                        break;
                    }
                }
                
                level++;
            }
            
            [buttonLayout addChild:button];
        }
        
        [buttonLayouts addObject:buttonLayout];
    }
    
    CCLayoutBox* layout = [CCLayoutBox new];
    layout.direction = CCLayoutBoxDirectionVertical;
    layout.spacing = 2;
    
    for (int i = (int)buttonLayouts.count - 1; i >= 0; i--) {
        [layout addChild:buttonLayouts[i]];
    }
    
    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:layout];
    scrollView.contentSizeType = CCSizeTypePoints;
    scrollView.contentSize = CGSizeMake(viewSize.width, viewSize.height - 50);
    scrollView.positionType = CCPositionTypePoints;
    scrollView.position = ccp(viewSize.width / 2 - 218, 5);
    scrollView.horizontalScrollEnabled = NO;
    scrollView.pagingEnabled = NO;
    scrollView.bounces = NO;
    [self addChild:scrollView];
}

- (void)onLevelSelected:(CCButton*)sender
{
    [SoundManager playEffect:BUTTONPRESS];
    WeaponSelectionScene* scene = [[WeaponSelectionScene alloc] initWithLevelID:sender.userObject];
    
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void)onReturnButtonClicked
{
    [SoundManager playEffect:BUTTONPRESS];
    [[CCDirector sharedDirector] replaceScene:[MainScene new]];
}

- (float)getHighestLevel
{
    float xmax = 0;

    for (NSString *level in [SaveSettings getSavedLevels]) {
        NSNumber *num = (NSNumber *)[level stringByReplacingOccurrencesOfString:@"level" withString:@""];
        float x = num.floatValue;
        if (x > xmax) xmax = x;
    }
    
    return xmax;
}

@end
