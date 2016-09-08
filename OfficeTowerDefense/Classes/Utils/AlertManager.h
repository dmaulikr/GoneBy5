//
//  AlertManager.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-04-13.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)msg;

@end
