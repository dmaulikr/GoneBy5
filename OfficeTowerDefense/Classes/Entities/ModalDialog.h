//
//  ModalDialog.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "ccTypes.h"

@class UIEntity;

@interface ModalDialog : CCSprite

- (instancetype)initWithUI:(UIEntity*)ui removeOnScreenTouch:(BOOL)removeOnScreenTouch;

- (void)tick:(CCTime)delta;

@end
