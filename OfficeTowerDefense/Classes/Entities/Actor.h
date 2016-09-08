//
//  Actor.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-12-16.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Character.h"

@class File;

typedef enum {
    HALFWAY,
    ALMOST_DONE
} BubbleTime;


@interface Actor : Character

- (void)addDamage:(float)damage;
- (void)removeDamage:(float)damage;
- (void)addBubble:(BubbleTime) bubbleTime;

@property (nonatomic, copy, readonly) NSString* ANIMATION_PANIC;
@property (nonatomic, copy, readonly) NSString* ANIMATION_SUCCESS;
@property (nonatomic, copy, readonly) NSString* ANIMATION_TYPING;

@property (nonatomic, readonly) float damage;

@end
