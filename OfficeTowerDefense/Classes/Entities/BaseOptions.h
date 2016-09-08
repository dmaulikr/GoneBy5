//
//  BaseOptions.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface BaseOptions : CCNode

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

@property (nonatomic, readonly) CCNode* content;

- (void)tick:(CCTime) delta;
@end
