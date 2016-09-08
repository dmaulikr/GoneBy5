//
//  BaseOptions.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "BaseOptions.h"

#import "CCLabelBMFont.h"

@interface BaseOptions()

@property (nonatomic) CCNode* content;

@end

@implementation BaseOptions

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString*)title
{
    self = [super init];
    
    self.content = [CCNode new];
    self.content.contentSize = frame.size;
    
    CCLabelBMFont* label = [CCLabelBMFont labelWithString:title fntFile:@"fontDinCondensed60_white.fnt"];
    label.anchorPoint = ccp(0, 0.5);
    label.alignment = CCTextAlignmentLeft;
    label.position = ccp(10, frame.size.height - 30);

    [self.content addChild:label];
    [self addChild:self.content];
    
    return self;
}

- (void)tick:(CCTime)delta
{
}

@end
