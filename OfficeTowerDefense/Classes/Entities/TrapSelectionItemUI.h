//
//  TrapSelectionItemUI.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-05.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

@class WeaponSelectionScene;

@interface TrapSelectionItemUI : UIEntity

- (instancetype)initWithID:(NSString*)trapID isLocked:(BOOL)isLocked target:(WeaponSelectionScene*)target selector:(SEL)selector;

@end
