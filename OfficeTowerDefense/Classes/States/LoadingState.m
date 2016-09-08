//
//  LoadingState.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-05-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LoadingState.h"

#import "Animation.h"
#import "Loading.h"

@interface LoadingState()

@property (nonatomic, weak) Animation* animation;

@end

@implementation LoadingState

- (void)onEnter
{
    Loading* loading = (Loading*)self.owner;
    
    self.animation = [loading getAnimationWithName:loading.ANIMATION];
    [self.animation restart];
}

- (void)tick:(CCTime)delta
{
    [self.animation tick:delta];
}


@end
