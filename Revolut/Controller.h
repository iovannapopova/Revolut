//
//  Controller.h
//  Revolut
//
//  Created by Iovanna Popova on 20/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UI.h"

typedef NS_ENUM(NSInteger, CurrencyType) {
    GBP,
    EUR,
    USD
};

typedef NS_ENUM(NSInteger, IndexType) {
    IndexTypeTop,
    IndexTypeBottom
};

@protocol CurrencySelectionDelegate <NSObject>

- (void)selectedCurrencyIndexOfType:(IndexType)type changedTo:(NSUInteger)index;

@end

@protocol AmountDelegate <NSObject>

- (void)amountChangedTo:(NSString*)amount;

@end

@protocol BalanceDelegate <NSObject>

- (void)exchange;

@end

@interface Controller : NSObject<CurrencySelectionDelegate, AmountDelegate, BalanceDelegate>

- (instancetype)initWithBalance:(NSMutableDictionary<NSNumber *, NSNumber *> *)balance
                             UI:(id<UI>)UI;

- (void)startUpdatingExchangeRateWithTimeInterval:(NSTimeInterval)ti;

@end
