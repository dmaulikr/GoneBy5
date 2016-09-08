//
//  StoryScene
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2014-11-03.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "StoryScene.h"

#import "CCDirector.h"
#import "CCSprite.h"
#import "CCTexture.h"
#import "CCTransition.h"
#import "SoundManager.h"

@interface StoryScene()

@property (nonatomic, copy) NSArray* files;
@property (nonatomic) CCSprite *background;
@property (nonatomic) CCScene* nextScene;
@property (nonatomic) int currentIndex;

@end

@implementation StoryScene

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (id)initWithFiles:(NSArray *)files nextScene:(CCScene*)scene
{
    self = [super init];
    
    self.files = files;
    self.background = nil;
    self.nextScene = scene;
    self.currentIndex = 0;
    
    return self;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [SoundManager playEffect:PAGEFLIP];
    
    CCTransition* transition = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionLeft duration:0.25f];
    self.currentIndex++;
    
    if (self.currentIndex >= self.files.count) {
        [[CCDirector sharedDirector] replaceScene:self.nextScene withTransition:transition];
    }
    else {
        [self addChild:[self buildBackground]];
    }
}

- (void)onEnter
{
    [super onEnter];
    [self addChild:[self buildBackground]];
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    self.userInteractionEnabled = YES;
}

- (CCSprite *)buildBackground
{
    NSString *file = [NSString stringWithFormat:@"%@", self.files[self.currentIndex]];
    self.background = [CCSprite spriteWithImageNamed:file];
    self.background.position = ccp(self.boundingBox.size.width / 2, self.boundingBox.size.height / 2);
    
    return self.background;
}

@end