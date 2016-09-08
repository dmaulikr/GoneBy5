//
//  PowerUp5Portal.m
//  OfficeTowerDefense
//
//  Created by Steven Srun on 2015-04-21.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "PowerUp5Portal.h"

#import "GameWorld.h"
#import "MetaDataController.h"
#import "PowerUp5PortalAppearState.h"

@interface PowerUp5Portal()

@property (nonatomic, copy) NSString* ANIMATION_PORTAL_APPEAR;
@property (nonatomic, copy) NSString* ANIMATION_PORTAL_IDLE;
@property (nonatomic, copy) NSString* ANIMATION_PORTAL_DISAPPEAR;

@end

@implementation PowerUp5Portal

- (instancetype)init
{
    self = [super initWithID:@"powerUp5"];
    self.scaleX = -1;
    
    return self;
}

- (void)createAnimations
{
    [super createAnimations];
    
    self.ANIMATION_PORTAL_APPEAR = @"portalAppear";
    self.ANIMATION_PORTAL_IDLE = @"portalIdle";
    self.ANIMATION_PORTAL_DISAPPEAR = @"portalDisappear";
    
    NSArray* animationNames = @[self.ANIMATION_PORTAL_APPEAR, self.ANIMATION_PORTAL_IDLE, self.ANIMATION_PORTAL_DISAPPEAR];
    NSDictionary* metaData = [MetaDataController instance].weaponMetaData[self.ID];
    NSDictionary* animations = metaData[@"animations"];
    
    for (NSString* name in animationNames) {
        int startFrame = [animations[name][@"startFrame"] intValue];
        int endFrame = [animations[name][@"endFrame"] intValue];
        float duration = [animations[name][@"duration_sec"] floatValue];
        int loopCount = [animations[name][@"loop"] intValue];
        CGPoint anchor = ccp([animations[name][@"anchorX"] floatValue], [animations[name][@"anchorY"] floatValue]);
        
        [self createAnimationWithName:name anchorPoint:anchor duration:duration loopCount:loopCount startFrame:startFrame endFrame:endFrame];
    }
}

- (void)place
{
    [super place];
    
    [self setState:[PowerUp5PortalAppearState new]];
}

@end
