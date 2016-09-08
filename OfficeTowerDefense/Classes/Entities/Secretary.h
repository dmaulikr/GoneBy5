//
//  Secretary.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-14.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Enemy.h"

#import "OverlayFX.h"

@class Actor;

@interface Secretary : Enemy

- (instancetype)initWithID:(NSString*)ID coins:(int)coins hitPoints:(float)hitPoints speed:(float)speed_per_sec filePosition:(CGPoint)filePosition;

- (void)givesFilesTo:(Actor*)actor;
- (unsigned long)fileCount;

@property (nonatomic, strong) NSMutableArray* files;

@end
