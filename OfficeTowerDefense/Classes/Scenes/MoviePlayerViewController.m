//
//  MoviePlayerViewController.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-05-13.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MoviePlayerViewController.h"

@interface MoviePlayerViewController ()

@property (nonatomic, strong) MPMoviePlayerController *playerViewController;

@end

@implementation MoviePlayerViewController

- (id)initWithPath:(NSString *)path
{
    self = [super init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGRect frame = CGRectMake(0.0f, 0.0f, screenWidth, screenHeight);
    self.playerViewController = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL fileURLWithPath:path]];
    [self.playerViewController setControlStyle:MPMovieControlStyleNone];

    self.view = [[UIView alloc] initWithFrame:frame];
    [self.playerViewController.view setFrame:frame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.playerViewController];

    [self.view addSubview:self.playerViewController.view];
    
    return self;
}

- (void)playbackFinished:(MPMoviePlayerViewController *)moviePlayerViewController
{
    self.playerViewController = nil;
    [self.delegate onPlaybackComplete];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.playerViewController stop];
}

@end
