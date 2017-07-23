//
//  ChildControllersViewModel.h
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildControllersViewModel : NSObject

- (instancetype)initWithCurrency:(NSString *)currency
                  accountBalance:(NSAttributedString *)accountBalance
                          amount:(NSString *)amount
                       isEditing:(BOOL)amountIsEditable
         exchangeRateDescription:(NSString *)exchangeRateDescription;

@property (nonatomic, copy, readonly) NSString *currency;
@property (nonatomic, copy, readonly) NSAttributedString *accountBalance;
@property (nonatomic, copy, readonly) NSString *amount;
@property (nonatomic, assign, readonly) BOOL amountIsEditable;
@property (nonatomic, copy, readonly) NSString *exchangeRateDescription;

@end
