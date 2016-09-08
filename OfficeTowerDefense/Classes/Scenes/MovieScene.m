//
//  MovieScene.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-05-11.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MovieScene.h"

#import "AppDelegate.h"
#import "MainScene.h"
#import "MoviePlayerViewController.h"

@interface MovieScene()<MoviePlayerDelegate>

@end

@implementation MovieScene

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)onEnter
{
    CGRect viewFrame = [[CCDirector sharedDirector].view frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"comic_1" ofType:@"mp4"];
    
    MoviePlayerViewController *viewController = [[MoviePlayerViewController alloc] initWithPath:path];
    viewController.delegate = self;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.navController pushViewController:viewController animated:NO];
    
    [viewController.playerViewController.view setFrame:viewFrame];
    [viewController.playerViewController play];
    [[CCDirector sharedDirector] pause];
    
    [super onEnter];
}

- (void)onPlaybackComplete
{
    [[CCDirector sharedDirector] resume];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.navController popViewControllerAnimated:YES];
    
    CCScene* scene = [MainScene new];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end
