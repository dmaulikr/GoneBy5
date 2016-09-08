//
//  AlertManager.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-04-13.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "AlertManager.h"

#import "CCDirector.h"

@implementation AlertManager

+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)msg;
{
    if([UIAlertController class])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:msg
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        [alertController addAction:cancelAction];
        
        [[CCDirector sharedDirector] presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}
@end
