//
//  MoviePlayerViewController.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-05-13.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>

@protocol MoviePlayerDelegate <NSObject>

- (void)onPlaybackComplete;

@end

@interface MoviePlayerViewController : UIViewController

@property (nonatomic, readonly) MPMoviePlayerController *playerViewController;
@property (nonatomic, weak) id <MoviePlayerDelegate> delegate;

- (id)initWithPath:(NSString *)path;


@end
