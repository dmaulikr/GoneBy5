//
//  ModalDialog.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ModalDialog.h"

#import "CCDirector.h"
#import "NotificationNames.h"
#import "UIEntity.h"

@interface ModalDialog()

@property (nonatomic) UIEntity* ui;
@property (nonatomic) BOOL removeOnScreenTouch;

@end

@implementation ModalDialog

- (instancetype)initWithUI:(UIEntity*)ui removeOnScreenTouch:(BOOL)removeOnScreenTouch
{
    self = [super initWithImageNamed:@"bgGame.png"];
    
    self.userInteractionEnabled = YES;
    
    self.ui = ui;
    self.removeOnScreenTouch = removeOnScreenTouch;
    self.color = [CCColor blackColor];
    self.opacity = 0.7;
    
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    
    self.anchorPoint = ccp(0.5, 0.5);
    self.position = ccp(viewSize.width / 2, viewSize.height / 2);
    
    ui.position = ccp(self.boundingBox.size.width / 2, self.boundingBox.size.height / 2);
    [self addChild:ui];
    
    return self;
}

- (void)tick:(CCTime)delta
{
    if (self.ui) {
        [self.ui tick:delta];
    }
}

- (void)onExit
{
    [super onExit];
    
    if (self.ui) {
        [self removeChild:self.ui];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MODAL_DIALOG_REMOVED object:nil];
}

- (void)removeChild:(CCNode*)child cleanup:(BOOL)cleanup
{
    [super removeChild:child cleanup:cleanup];
    self.ui = nil;
    [self removeFromParent];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (self.removeOnScreenTouch) {
        [self removeFromParent];
    }
}

@end
