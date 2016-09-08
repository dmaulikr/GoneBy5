//
//  FileIdleState.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-18.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "FileIdleState.h"

#import "Animation.h"
#import "File.h"

@interface FileIdleState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation FileIdleState

- (void)onEnter
{
    File* file = (File*)self.owner;
    
    self.animation = [file getAnimationWithName:file.ANIMATION_IDLE];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    File* file = (File*)self.owner;

    if (file.hitPoints / file.maxHitPoints <= 0.5) {
        self.animation.currentFrame = 1;
    }
}

@end
