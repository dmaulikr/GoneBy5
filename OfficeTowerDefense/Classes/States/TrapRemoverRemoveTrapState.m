//
//  TrapRemoverRemoveTrapState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-28.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TrapRemoverRemoveTrapState.h"

#import "Animation.h"
#import "TrapRemover.h"

@interface TrapRemoverRemoveTrapState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation TrapRemoverRemoveTrapState

- (void)onEnter
{
    TrapRemover* trapRemover = (TrapRemover*)self.owner;
    
    self.animation = [trapRemover getAnimationWithName:trapRemover.ANIMATION_REMOVE_TRAP];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}


@end
