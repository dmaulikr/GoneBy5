//
//  TrapSelectionItemUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TrapSelectionItemUI.h"

#import "CCButton.h"
#import "CCLabelBMFont.h"
#import "CCSprite.h"
#import "CCSpriteFrameCache.h"
#import "MetaDataController.h"
#import "WeaponSelectionScene.h"

@implementation TrapSelectionItemUI

- (instancetype)initWithID:(NSString*)trapID isLocked:(BOOL)isLocked target:(WeaponSelectionScene*)target selector:(SEL)selector
{
    self = [super init];
    
    #ifdef DEBUG
    isLocked = NO;
    #endif
    
    NSString* filePath = [NSString stringWithFormat:@"%@.plist", trapID];
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[trapID];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_normal", trapID]];
    CCSpriteFrame* selectedFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_selected", trapID]];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_disabled", trapID]];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:selectedFrame disabledSpriteFrame:disabledFrame];
    button.anchorPoint = ccp(0, 1);
    [button setUserObject:trapID];
    [button setTarget:target selector:selector];
    
    CCSprite* addOn;
    
    if (isLocked) {
        addOn = [[CCSprite alloc] initWithImageNamed:@"trapLock.png"];
        [button setEnabled:NO];
    }
    else {
        addOn = [[CCSprite alloc] initWithImageNamed:@"coinBkgnd.png"];
        
        NSString* labelString = [NSString stringWithFormat:@"%@", metaData[@"cost"]];
        CCLabelBMFont* label = [CCLabelBMFont labelWithString:labelString fntFile:@"fontDinCondensed30_white.fnt" width:addOn.boundingBox.size.width alignment:CCTextAlignmentCenter];
        label.anchorPoint = ccp(0.5, 0.5);
        label.position = ccp(addOn.boundingBox.size.width / 2, 7);
        
        [addOn addChild:label];
    }
    
    addOn.anchorPoint = ccp(0.5, 0);
    addOn.position = ccp(button.boundingBox.size.width * 0.75 + 5, 0);
    [button addChild:addOn];
    
    [self.sprite addChild:button];
    
    CCSprite* infoBox = [CCSprite spriteWithImageNamed:@"trapInfoBox.png"];
    infoBox.anchorPoint = ccp(0, 1);
    infoBox.position = ccp(43, 0);
    [self.sprite addChild:infoBox];
    
    CCLabelBMFont* name = [CCLabelBMFont labelWithString:metaData[@"name"] fntFile:@"fontDinCondensed26_black.fnt"];
    name.anchorPoint = ccp(0, 1);
    name.position = ccp(2, 38);
    [infoBox addChild:name];
    
    NSString* description = (isLocked) ? @"Keep playing to unlock." : metaData[@"description"];
    CCLabelBMFont* descriptionLabel = [CCLabelBMFont labelWithString:description fntFile:@"fontDinCondensed22_black.fnt" width:infoBox.boundingBox.size.width alignment:CCTextAlignmentLeft];
    descriptionLabel.anchorPoint = ccp(0, 1);
    descriptionLabel.position = ccp(2, 24);
    [infoBox addChild:descriptionLabel];
    
    return  self;
}

@end
