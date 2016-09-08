//
//  FilesFall.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-13.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameEntity.h"

@interface FilesFall : GameEntity

- (instancetype)initWithPosition:(CGPoint)position;

@property (nonatomic, copy, readonly) NSString* ANIMATION_FALL;

@end
