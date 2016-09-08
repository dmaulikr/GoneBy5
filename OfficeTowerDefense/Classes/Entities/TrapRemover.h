//
//  TrapRemover.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-27.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface TrapRemover : GameEntity

@property (nonatomic, copy, readonly) NSString* ANIMATION_IDLE;
@property (nonatomic, copy, readonly) NSString* ANIMATION_REMOVE_TRAP;

@end
