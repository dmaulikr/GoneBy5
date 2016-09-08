//
//  OptionsUI.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-03-04.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

typedef enum {
    SCREEN_TYPE_NONE,
    SCREEN_TYPE_SETTINGS,
    SCREEN_TYPE_STORE
} ScreenType;

@interface OptionsUI : UIEntity

- (instancetype)initWithScreen:(ScreenType)screen;

@end
