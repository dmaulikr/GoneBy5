//
//  FileFallState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "FileFallState.h"

#import "Animation.h"
#import "FilesFall.h"

@interface FileFallState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation FileFallState

- (void)onEnter
{
    FilesFall* files = (FilesFall*)self.owner;

    self.animation = [files getAnimationWithName:files.ANIMATION_FALL];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    if (self.animation.completed) {
        [self.owner removeFromParent];
    }
    else {
        [self.animation tick:delta];
    }
}

@end
