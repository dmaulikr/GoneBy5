//
//  IAPManager.h
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-23.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKProduct;
@protocol IAPDelegate <NSObject>

- (void)onProductsValidated:(NSArray *)products;
- (void)onPurchaseSuccess:(SKProduct *)productPurchase;

@end

@interface IAPManager : NSObject

@property (nonatomic, strong) id<IAPDelegate> delegate;

+ (IAPManager* )instance;

- (void)validateProductIdentifiers:(NSArray *)identifiers;
- (void)makePurchase:(SKProduct *)product;
@end
