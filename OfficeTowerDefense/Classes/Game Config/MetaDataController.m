//
//  MetaDataController.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-09.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MetaDataController.h"

@implementation MetaDataController
+ (MetaDataController *)instance
{
    static MetaDataController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MetaDataController alloc] init];
    });
    
    return _sharedInstance;
}

- (void)loadMetaData
{
    NSString* path = [NSString stringWithFormat:@"CharacterMetaData"];
    self.characterMetaData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"plist"]];
    
    path = [NSString stringWithFormat:@"LevelMetaData"];
    self.levelMetaData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"plist"]];

    path = [NSString stringWithFormat:@"WeaponMetaData"];
    self.weaponMetaData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"plist"]];
}

@end
