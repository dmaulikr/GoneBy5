//
//  GameOverUI.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

@interface GameOverUI : UIEntity

- (instancetype)initWithWin:(NSString *)level firstTime:(BOOL)isFirstTime;
- (instancetype)initWithLose:(NSString *)level;

@property (nonatomic, copy, readonly) NSString *ANIMATION_LOSE;
@property (nonatomic, copy, readonly) NSString *ANIMATION_WIN;

@end
