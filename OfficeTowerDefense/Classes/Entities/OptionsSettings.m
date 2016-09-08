//
//  OptionsSettings.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OptionsSettings.h"

#import "CCButton.h"
#import "CCLayoutBox.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "SoundManager.h"

@interface OptionsSettings()

@property (nonatomic) CCButton *soundBtn;
@property (nonatomic) CCButton *musicBtn;

@end

@implementation OptionsSettings

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame withTitle:title];
    
    CCLayoutBox *soundLayoutBox = [CCLayoutBox new];
    [soundLayoutBox setAnchorPoint:CGPointMake(0, 0)];
    soundLayoutBox.direction = CCLayoutBoxDirectionHorizontal;
    soundLayoutBox.spacing = 10;
    soundLayoutBox.position = ccp(10, frame.size.height - 80);
    
    CCSprite* sound = [CCSprite spriteWithImageNamed:@"soundUI.png"];
    [soundLayoutBox addChild:sound];

    CCSpriteFrame* normalFrame = [CCSpriteFrame frameWithImageNamed:@"settingSound_On.png"];
    CCSpriteFrame* disabledFrame = [CCSpriteFrame frameWithImageNamed:@"settingSound_Off.png"];

    self.soundBtn = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:disabledFrame disabledSpriteFrame:disabledFrame];
    [self.soundBtn setTarget:self selector:@selector(updateVolume)];
    [soundLayoutBox addChild:self.soundBtn];
    
    CCLayoutBox *musicLayoutBox = [CCLayoutBox new];
    [musicLayoutBox setAnchorPoint:CGPointMake(0, 0)];
    musicLayoutBox.direction = CCLayoutBoxDirectionHorizontal;
    musicLayoutBox.spacing = 10;
    musicLayoutBox.position = ccp(10, frame.size.height - 120);
    
    sound = [CCSprite spriteWithImageNamed:@"musicUI.png"];
    [musicLayoutBox addChild:sound];

    self.musicBtn = [CCButton buttonWithTitle:nil spriteFrame:normalFrame highlightedSpriteFrame:disabledFrame disabledSpriteFrame:disabledFrame];
    [self.musicBtn setTarget:self selector:@selector(updateMusic)];
    [musicLayoutBox addChild:self.musicBtn];

    [self updateSoundState];
    [self.content addChild:soundLayoutBox];
    [self.content addChild:musicLayoutBox];
    return self;
}

- (void)updateVolume
{
    float vol = ([SoundManager getVolume] > 0) ? 0.0f : 1.0f;
    
    [SoundManager setVolume:vol];
    [self updateSoundState];
}

- (void)updateMusic
{
    float vol = ([SoundManager getMusicVolume] > 0) ? 0.0f : 1.0f;
    
    [SoundManager setMusicVolume:vol];
    [self updateSoundState];
}

- (void)updateSoundState
{
    NSString* fileName = ([SoundManager getVolume] > 0) ? @"settingSound_On.png" : @"settingSound_Off.png";
    CCSpriteFrame* frame = [CCSpriteFrame frameWithImageNamed:fileName];
    
    NSString* musicName = ([SoundManager getMusicVolume] > 0) ? @"settingSound_On.png" : @"settingSound_Off.png";
    CCSpriteFrame* musicFrame = [CCSpriteFrame frameWithImageNamed:musicName];
    
    [self.soundBtn setBackgroundSpriteFrame:frame forState:CCControlStateNormal];
    [self.musicBtn setBackgroundSpriteFrame:musicFrame forState:CCControlStateNormal];
}

@end
