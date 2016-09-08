//
//  PowerUpSelectionItemUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUpSelectionItemUI.h"

#import "CCButton.h"
#import "CCLabelBMFont.h"
#import "CCSprite.h"
#import "CCSpriteFrameCache.h"
#import "MetaDataController.h"
#import "WeaponSelectionScene.h"

@implementation PowerUpSelectionItemUI

- (instancetype)initWithID:(NSString*)powerUpID target:(WeaponSelectionScene*)target selector:(SEL)selector
{
    self = [super init];
    
    NSString* filePath = [NSString stringWithFormat:@"%@.plist", powerUpID];
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[powerUpID];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:filePath];
    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_normal", powerUpID]];
    CCSpriteFrame* selectedFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_selected", powerUpID]];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%@_disabled", powerUpID]];
    CCButton* button = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:selectedFrame disabledSpriteFrame:disabledFrame];
    button.anchorPoint = ccp(0, 1);
    button.position = ccp(150, 0);
    [button setUserObject:powerUpID];
    [button setTarget:target selector:selector];
    [self.sprite addChild:button];
    
    CCSprite* diamond = [[CCSprite alloc] initWithImageNamed:@"diamondBkgnd.png"];
    diamond.anchorPoint = ccp(0.5, 0);
    diamond.position = ccp(button.boundingBox.size.width * 3/4 + 5, 0);
    [button addChild:diamond];

    NSString* labelString = [NSString stringWithFormat:@"%@", metaData[@"cost"]];
    CCLabelBMFont* label = [CCLabelBMFont labelWithString:labelString fntFile:@"fontDinCondensed30_white.fnt" width:diamond.boundingBox.size.width alignment:CCTextAlignmentCenter];
    label.anchorPoint = ccp(0.5, 0);
    label.position = ccp(diamond.boundingBox.size.width / 2, -1);
    [diamond addChild:label];

    CCSprite* infoBox = [CCSprite spriteWithImageNamed:@"trapInfoBox.png"];
    infoBox.anchorPoint = ccp(0, 1);
    [self.sprite addChild:infoBox];

    CCLabelBMFont* name = [CCLabelBMFont labelWithString:metaData[@"name"] fntFile:@"fontDinCondensed26_black.fnt"];
    name.anchorPoint = ccp(0, 1);
    name.position = ccp(2, 38);
    [infoBox addChild:name];
    
    CCLabelBMFont* description = [CCLabelBMFont labelWithString:metaData[@"description"] fntFile:@"fontDinCondensed22_black.fnt" width:infoBox.boundingBox.size.width alignment:CCTextAlignmentLeft];
    description.anchorPoint = ccp(0, 1);
    description.position = ccp(2, 24);
    [infoBox addChild:description];
    
    return  self;
}


@end
