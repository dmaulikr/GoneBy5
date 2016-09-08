//
//  PowerUpSelectionItemUI.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-06.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

@class WeaponSelectionScene;

@interface PowerUpSelectionItemUI : UIEntity

- (instancetype)initWithID:(NSString*)trapID target:(WeaponSelectionScene*)target selector:(SEL)selector;

@end
