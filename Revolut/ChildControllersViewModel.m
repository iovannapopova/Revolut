//
//  ChildControllersViewModel.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "ChildControllersViewModel.h"

@interface ChildControllersViewModel ()

@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSAttributedString *accountBalance;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, assign) BOOL amountIsEditable;
@property (nonatomic, copy) NSString *exchangeRateDescription;

@end

@implementation ChildControllersViewModel

- (instancetype)initWithCurrency:(NSString *)currency
                  accountBalance:(NSAttributedString *)accountBalance
                          amount:(NSString *)amount
                       isEditing:(BOOL)amountIsEditable
         exchangeRateDescription:(NSString *)exchangeRateDescription {
    self = [super init];
    if (self) {
        _currency = [currency copy];
        _accountBalance = [accountBalance copy];
        _amount = [amount copy];
        _amountIsEditable = amountIsEditable;
        _exchangeRateDescription = [exchangeRateDescription copy];
    }
    return self;
}

@end
