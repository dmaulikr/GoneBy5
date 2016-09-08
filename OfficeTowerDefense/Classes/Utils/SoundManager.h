//
//  SoundManager.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-03-01.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const BOSS_ANGRY;
extern NSString *const BOSS_FEMALE_ANGRY;
extern NSString *const BOSS_TRANSFORM;
extern NSString *const BUTTONPRESS;
extern NSString *const COIN;
extern NSString *const COLLECT;
extern NSString *const ELECTRICIAN_ATTACK;
extern NSString *const FILES;
extern NSString *const JANITOR_ATTACK;
extern NSString *const LOSE_HMM;
extern NSString *const PAGEFLIP;
extern NSString *const ROBOT_EXPLODE;
extern NSString *const WIN_LAUGH;

extern NSString *const MUSIC_BACKGROUND;

@interface SoundManager : NSObject

+ (void)preloadAllAudio;
+ (void)preloadAudio:(NSString*)fileName;
+ (void)playEffect:(NSString *)fileName;
+ (void)playEffect:(NSString *)fileName loop:(BOOL)loop;
+ (void)playMusic:(NSString *)fileName;
+ (void)pauseMusic;
+ (void)stopMusic;
+ (bool)isMusicPlaying;
+ (void)setVolume:(float)volume; //value from 0-1;
+ (float)getVolume;
+ (void)setMusicVolume:(float)volume; //value from 0-1;
+ (float)getMusicVolume;

@end
