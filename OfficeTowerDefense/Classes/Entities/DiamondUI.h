//
//  DiamondUI.h
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-02-10.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UIEntity.h"

@class CCButton;

@interface DiamondUI : UIEntity

- (void)setAmount:(int)amount;
- (void)onAddClicked:(CCButton*)sender;

@property (nonatomic, copy) NSString* ANIMATION;

@end
