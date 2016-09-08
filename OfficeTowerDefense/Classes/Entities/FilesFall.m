//
//  FilesFall.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-13.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "FilesFall.h"

#import "FileFallState.h"

@interface FilesFall()

@property (nonatomic, copy) NSString* ANIMATION_FALL;

@end

@implementation FilesFall

- (instancetype)initWithPosition:(CGPoint)position;
{
    self = [super initWithID:@"filesFall0"];
    
    self.position = position;
    
    [self setState:[FileFallState new]];
    
    return self;
}

- (void)createAnimations
{
    self.ANIMATION_FALL = @"fall";
    
    [self createAnimationWithName:self.ANIMATION_FALL anchorPoint:ccp(0.5, 0) duration:0.5 loopCount:1 startFrame:0 endFrame:15];
}

@end
