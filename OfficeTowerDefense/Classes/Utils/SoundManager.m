//
//  SoundManager.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-03-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SoundManager.h"

#import "OALSimpleAudio.h"
#import "SaveSettings.h"

NSString *const BOSS_ANGRY = @"bossAngry.aiff";
NSString *const BOSS_FEMALE_ANGRY = @"bossFemaleAngry.aiff";
NSString *const BOSS_TRANSFORM = @"transform.aiff";
NSString *const BUTTONPRESS = @"buttonPress.aiff";
NSString *const COIN = @"coin.aiff";
NSString *const COLLECT = @"collect.aiff";
NSString *const ELECTRICIAN_ATTACK = @"electrician.aiff";
NSString *const FILES = @"files.mp3";
NSString *const JANITOR_ATTACK = @"janitor.aiff";
NSString *const LOSE_HMM = @"hmm.aiff";
NSString *const PAGEFLIP = @"pageFlip.aiff";
NSString *const ROBOT_EXPLODE = @"robotExplode.aiff";
NSString *const WIN_LAUGH = @"laugh.aiff";

NSString *const MUSIC_BACKGROUND = @"background.mp3";

@implementation SoundManager

+ (void)preloadAllAudio
{
}

+ (void)preloadAudio:(NSString *)fileName
{
    NSString *file = [NSString stringWithFormat:@"%@", fileName];
    [[OALSimpleAudio sharedInstance] preloadEffect:file];
}

+ (void)playEffect:(NSString *)fileName
{
    [self playEffect:fileName loop:NO];
}

+ (void)playEffect:(NSString *)fileName loop:(BOOL)loop
{
    NSString *file = [NSString stringWithFormat:@"%@", fileName];
    
    [SoundManager setVolume:([SaveSettings getSoundEnabled]) ? 1.0f : 0.0f];
    [[OALSimpleAudio sharedInstance] playEffect:file loop:loop];
}

+ (void)playMusic:(NSString *)fileName
{
    [SoundManager setMusicVolume:([SaveSettings getSongEnabled]) ? 1.0f : 0.0f];
    if ([[OALSimpleAudio sharedInstance] bgPaused]) {
        [[OALSimpleAudio sharedInstance] setBgPaused:NO];
    } else {
        NSString *file = [NSString stringWithFormat:@"%@", fileName];
        [[OALSimpleAudio sharedInstance] playBg:file loop:YES];
    }
}

+ (void)pauseMusic
{
    [[OALSimpleAudio sharedInstance] setBgPaused:YES];
}

+ (void)stopMusic
{
    [[OALSimpleAudio sharedInstance] stopBg];
}

+ (bool)isMusicPlaying
{
    return [[OALSimpleAudio sharedInstance] bgPlaying];
}

+ (void)setVolume:(float)volume
{
    volume = (volume > 1.0f) ? 1.0f : volume;
    [SaveSettings setSoundEnabled:(volume > 0.0f)];
    [[OALSimpleAudio sharedInstance] setEffectsVolume: volume];
}

+ (float)getVolume
{
    return [OALSimpleAudio sharedInstance].effectsVolume;
}

+ (void)setMusicVolume:(float)volume
{
    volume = (volume > 1.0f) ? 1.0f : volume;
    [SaveSettings setSongEnabled:(volume > 0.0f)];
    [[OALSimpleAudio sharedInstance] setBgVolume: volume];
}

+ (float)getMusicVolume
{
    return [OALSimpleAudio sharedInstance].bgVolume;
}

@end
