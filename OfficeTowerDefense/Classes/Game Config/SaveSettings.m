//
//  SaveSettings.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "SaveSettings.h"

static NSString *const appLaunchedComic = @"AppLaunchedComic";
static NSString *const completedLevels = @"CompletedLevels";
static NSString *const playerDiamonds = @"PlayerDiamonds";
static NSString *const playerTraps = @"PlayerTraps";
static NSString *const soundEnabled = @"SoundEnabled";
static NSString *const songEnabled = @"SongEnabled";

@implementation SaveSettings

#pragma mark - App Comic Properties
+ (void)setLaunchedComic
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:appLaunchedComic];
    [defaults synchronize];
}

+ (BOOL)getLaunchedComic
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:appLaunchedComic];
}

+ (void)setLevelCompleted:(NSString *)level
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *levels = [NSMutableArray arrayWithArray:[defaults objectForKey:completedLevels]];
    
    [levels addObject:level];
    [defaults setObject:levels forKey:completedLevels];
}

+ (NSArray *)getSavedLevels
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults arrayForKey:completedLevels];
}

+ (void)setPlayerDiamonds:(int)amount
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:amount] forKey:playerDiamonds];
}

+ (int)getPlayerDiamonds
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (int)[defaults integerForKey:playerDiamonds];
}

+ (void)setPlayerTraps:(NSString *)weaponId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *traps = [NSMutableArray arrayWithArray:[defaults objectForKey:playerTraps]];
    if (![traps containsObject:weaponId]) {
        [traps addObject:weaponId];
        [defaults setObject:traps forKey:playerTraps];
    }
}

+ (NSArray *)getPlayerTraps
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults arrayForKey:playerTraps];
}

+ (void)setSoundEnabled:(BOOL)enabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:enabled forKey:soundEnabled];
    [defaults synchronize];
}

+ (BOOL)getSoundEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:soundEnabled];
}

+ (void)setSongEnabled:(BOOL)enabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:enabled forKey:songEnabled];
    [defaults synchronize];
}

+ (BOOL)getSongEnabled
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:songEnabled];
}

@end
