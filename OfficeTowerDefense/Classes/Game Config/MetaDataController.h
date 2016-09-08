//
//  MetaDataController.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-09.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetaDataController : NSObject

+ (MetaDataController* )instance;

- (void)loadMetaData;

@property (nonatomic, strong) NSDictionary *characterMetaData;
@property (nonatomic, strong) NSDictionary *levelMetaData;
@property (nonatomic, strong) NSDictionary *weaponMetaData;

@end
