//
//  SaveSettings.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-16.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveSettings : NSObject

+ (void)setLaunchedComic;
+ (BOOL)getLaunchedComic;
+ (void)setLevelCompleted:(NSString *)level;
+ (NSArray *)getSavedLevels;
+ (void)setPlayerDiamonds:(int)amount;
+ (int)getPlayerDiamonds;
+ (void)setPlayerTraps:(NSString *)weaponId;
+ (NSArray *)getPlayerTraps;

+ (void)setSoundEnabled:(BOOL)enabled;
+ (BOOL)getSoundEnabled;
+ (void)setSongEnabled:(BOOL)enabled;
+ (BOOL)getSongEnabled;
@end
