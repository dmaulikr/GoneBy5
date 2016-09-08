//
//  IAPManager.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-02-23.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "IAPManager.h"

#import "AlertManager.h"
#import <StoreKit/StoreKit.h>

@interface IAPManager()<SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) SKProductsRequest *productRequest;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) SKProduct *productPurchase;

@end

@implementation IAPManager

+ (IAPManager *)instance
{
    static IAPManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[IAPManager alloc] init];
    });
    
    return _sharedInstance;
}

- (void)validateProductIdentifiers:(NSArray *)productIdentifiers
{
    if ([SKPaymentQueue canMakePayments]) {
        if (!self.productRequest) {
            self.productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
        }
        
        self.productPurchase = nil;
        
        if (!self.products) {
            self.productRequest.delegate = self;
            [self.productRequest start];
        } else {
            [self.delegate onProductsValidated:self.products];
        }
        
    } else {
        NSLog(@"Not allowed to make purchase");
    }
}

- (void)makePurchase:(SKProduct *)product
{
    self.productPurchase = product;
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions {
    for(SKPaymentTransaction *transaction in transactions) {
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                
                if (self.delegate) {
                    [self.delegate onPurchaseSuccess:self.productPurchase];
                    self.productPurchase = nil;
                }
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finish
                if(transaction.error.code != SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"Transaction state -> Deferred");
                break;
        }
    }
}

- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    self.products = response.products;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
    NSArray *sortedProducts = [self.products sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.products = sortedProducts;
    
    if (self.delegate) {
        [self.delegate onProductsValidated:self.products];
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    [AlertManager presentAlertWithTitle:@"Error" message:error.localizedDescription];
}

@end
