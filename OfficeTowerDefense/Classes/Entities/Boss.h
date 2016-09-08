//
//  Boss.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-01-14.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Secretary.h"

@interface Boss : Secretary

- (void)showFiles;

@property (nonatomic, strong, readonly) NSString* ANIMATION_LOSE;
@property (nonatomic, strong, readonly) NSString* ANIMATION_POINTING;
@property (nonatomic, strong, readonly) NSString* ANIMATION_SIT;
@property (nonatomic, strong, readonly) NSString* ANIMATION_TRANSFORM;

@property (nonatomic, readonly) BOOL isPointing;

@end
