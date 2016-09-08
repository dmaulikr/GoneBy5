//
//  LevelStartUI.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-23.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

@class GameWorld;

@interface LevelStartUI : UIEntity

- (instancetype)initWithLevelID:(NSString *)levelID tip:(NSString *)tip;

@property (nonatomic, copy, readonly) NSString* ANIMATION;

@end
