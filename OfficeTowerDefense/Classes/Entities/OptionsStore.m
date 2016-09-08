//
//  OptionsStore.m
//  OfficeTowerDefense
//
//  Created by Josh Lai on 2015-03-30.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "OptionsStore.h"

#import "CCButton.h"
#import "CCLabelBMFont.h"
#import "CCLayoutBox.h"
#import "CCScrollView.h"
#import "CCSpriteFrame.h"
#import "IAPManager.h"
#import "Loading.h"
#import "NotificationNames.h"
#import "SaveSettings.h"
#import <StoreKit/StoreKit.h>

@interface OptionsStore()<IAPDelegate>

@property (nonatomic, strong) NSArray *storeData;
@property (nonatomic, strong) Loading *loading;

@end

@implementation OptionsStore

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame withTitle:title];
    
    NSString *filePath = @"StoreMetaData";
    NSDictionary *metaData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filePath ofType:@"plist"]];
    self.storeData = (NSArray*)metaData[@"Diamonds"];

    NSMutableArray *list = [NSMutableArray array];
    for (int i = 0; i < self.storeData.count; i++) {
        [list addObject:self.storeData[i][@"productId"]];
    }
    
    self.loading = [Loading new];
    self.loading.anchorPoint = ccp(0.5, 1);
    self.loading.position = ccp(frame.size.width / 2, frame.size.height / 2);
    [self addChild:self.loading];
    
    [IAPManager instance].delegate = self;
    [[IAPManager instance] validateProductIdentifiers:list];
    
    return self;
}

- (void)tick:(CCTime)delta
{
    [self.loading tick:delta];
}

- (CCButton*)getCell:(SKProduct *)product
{
    CCButton *button;
    button.anchorPoint = ccp(0, 1);
    button.contentSizeType = CCSizeTypePoints;
    
    NSString* diamond = product.localizedTitle;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:product.priceLocale];
    NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
    
    int cost = [[diamond componentsSeparatedByString:@" x "][1] intValue];
    
    if (cost >= 180) {
        button = [[CCButton alloc] initWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shopDiamond6.png"]];
    }
    else if (cost >= 130) {
        button = [[CCButton alloc] initWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shopDiamond5.png"]];
    }
    else if (cost >= 80) {
        button = [[CCButton alloc] initWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shopDiamond4.png"]];
    }
    else if (cost >= 50) {
        button = [[CCButton alloc] initWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shopDiamond3.png"]];
    }
    else if (cost >= 25) {
        button = [[CCButton alloc] initWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shopDiamond2.png"]];
    }
    else {
        button = [[CCButton alloc] initWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shopDiamond1.png"]];
    }
    
    CCLabelBMFont* diamondLabel = [CCLabelBMFont labelWithString:diamond fntFile:@"fontDinCondensed32_white.fnt"];
    diamondLabel.alignment = CCTextAlignmentLeft;
    diamondLabel.position = ccp(85, button.boundingBox.size.height / 2);
    [button addChild:diamondLabel];
    
    CCLabelBMFont* costLabel = [CCLabelBMFont labelWithString:formattedPrice fntFile:@"fontDinCondensed32_white.fnt"];
    costLabel.alignment = CCTextAlignmentRight;
    costLabel.position = ccp(button.boundingBox.size.width - costLabel.boundingBox.size.width, button.boundingBox.size.height / 2);
    [button addChild:costLabel];
    
    button.userObject = @{@"product":product};
    [button setTarget:self selector:@selector(onCellSelected:)];
    
    return button;
}

- (void)onCellSelected:(CCButton*)cell
{
    NSDictionary* product = (NSDictionary *)cell.userObject;
    [[IAPManager instance] makePurchase:[product objectForKey:@"product"]];
}

- (void)onProductsValidated:(NSArray *)products
{
    [self.loading removeFromParent];

    CCLayoutBox* itemsLayout = [CCLayoutBox new];
    itemsLayout.direction = CCLayoutBoxDirectionVertical;
    itemsLayout.spacing = 1;
    
    for (int i = (int)products.count - 1; i >= 0; i--) {
        SKProduct *prod = products[i];;
        CCButton* cell = [self getCell:prod];
        
        [itemsLayout addChild:cell];
    }
    
    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:itemsLayout];
    scrollView.contentSizeType = CCSizeTypePoints;
    scrollView.contentSize = CGSizeMake(200, 200);
    scrollView.position = CGPointMake(10, 20);
    scrollView.horizontalScrollEnabled = NO;
    scrollView.pagingEnabled = NO;
    scrollView.bounces = NO;
    
    [self addChild:scrollView];
}

- (void)onPurchaseSuccess:(SKProduct *)productPurchase
{
    NSDictionary *data = [self getDataWithProductIdentifier:productPurchase.productIdentifier];    
    NSNumber *reward = data[@"reward"];
    NSDictionary* info = @{@"amount":reward};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DIAMONDS_COLLECTED object:nil userInfo:info];
}

- (NSDictionary *)getDataWithProductIdentifier:(NSString *)productIdentifier
{
    NSDictionary *data = [NSDictionary dictionary];
    for (int i = 0; i < self.storeData.count; i++) {
        if ([self.storeData[i][@"productId"] isEqualToString:productIdentifier]) {
            data = self.storeData[i];
        }
    }
    
    return data;
}

@end
