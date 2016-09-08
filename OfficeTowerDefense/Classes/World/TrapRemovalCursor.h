//
//  TrapRemovalCursor.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ButtonControl.h"

@class GameWorld;

@interface TrapRemovalCursor : NSObject <ButtonControlDelegate>

- (instancetype)initWithGameWorld:(GameWorld*)gameWorld;

@end
