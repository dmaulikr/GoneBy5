//
//  InputBlockerUI.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-20.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "InputBlockerUI.h"

@implementation InputBlockerUI

- (instancetype)initWithImageNamed:(NSString *)imageName
{
    self = [super initWithImageNamed:imageName];
    
    self.userInteractionEnabled = YES;
    
    return self;
}

- (void)touchBegan:(CCTouch*)touch withEvent:(CCTouchEvent*)event
{
}

@end
