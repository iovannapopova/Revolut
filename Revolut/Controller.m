//
//  Controller.m
//  Revolut
//
//  Created by Iovanna Popova on 20/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "Controller.h"
#import "SearchCurrencyOperation.h"
#import "ViewControllerViewModel.h"
#import <UIKit/UIKit.h>

@interface Controller ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *balance;
@property (nonatomic, strong) id<UI> UI;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSDictionary<NSString *, NSNumber *> *exchangeRateDictionary;

@property (nonatomic, assign) NSInteger topIndex;
@property (nonatomic, assign) NSInteger bottomIndex;

@property (nonatomic, strong) NSString* userEnteredAmount;
@property (nonatomic, assign) BOOL exchangeIsAvailable;

@end

static NSString *url = @"https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

@implementation Controller

- (instancetype)initWithBalance:(NSMutableDictionary<NSNumber *, NSNumber *> *)balance
                             UI:(id<UI>)UI {
    self = [super init];
    if (self) {
        _balance = balance;
        _UI = UI;
        _queue = [NSOperationQueue new];
        _topIndex = 0;
        _bottomIndex = 0;
        [self updateUI];
    }
    return self;
}

#pragma mark - Updatimg exchange rate

- (void)updateExchangeRate {
    SearchCurrencyOperation *search = [[SearchCurrencyOperation alloc]
                                       initWithSession:[NSURLSession sharedSession]
                                       URL:[NSURL URLWithString:url]
                                       completion:^(NSDictionary *dictionary, NSError *error) {
                                           if (!error) {
                                               self.exchangeRateDictionary = dictionary;
                                               [self updateUI];
                                           }
                                       }];
    [self.queue addOperation:search];
}

- (void)startUpdatingExchangeRateWithTimeInterval:(NSTimeInterval)ti {
    [self updateExchangeRate];
    [NSTimer scheduledTimerWithTimeInterval:ti
                                     target:self
                                   selector:@selector(updateExchangeRate)
                                   userInfo:nil
                                    repeats:YES];
}

#pragma mark - CurrencySelectionDelegate

- (void)selectedCurrencyIndexOfType:(IndexType)type changedTo:(NSUInteger)index {
    switch (type) {
        case IndexTypeTop:
            self.topIndex = index;
            break;
        case IndexTypeBottom:
            self.bottomIndex = index;
        default:
            break;
    }
    [self updateUI];
}

#pragma mark - AmountDelegate

- (void)amountChangedTo:(NSString*)amount {
    self.userEnteredAmount = [amount hasPrefix:@"-"] ? [amount substringFromIndex:1] : amount;
    [self updateUI];
}

#pragma mark - BalanceDelegate

- (void)exchange {
    
    CurrencyType topCurrency = currencyForIndex(self.topIndex);
    CurrencyType bottomCurrency = currencyForIndex(self.bottomIndex);
    
    NSString *topCurrencyName = [self currencyNames][@(topCurrency)];
    NSString *bottomCurrencyName = [self currencyNames][@(bottomCurrency)];
    
    NSNumber *topCurrencyRate = self.exchangeRateDictionary[topCurrencyName];
    NSNumber *bottomCurrencyRate = self.exchangeRateDictionary[bottomCurrencyName];
    
    NSNumber *rate = @(bottomCurrencyRate.floatValue / topCurrencyRate.floatValue);
    NSNumber *bottomAmount = @(self.amount.floatValue * rate.floatValue);
    
    NSNumber *from = self.balance[@(topCurrency)];
    self.balance[@(topCurrency)] = @(from.floatValue - self.amount.floatValue);
    NSNumber *to = self.balance[@(bottomCurrency)];
    self.balance[@(bottomCurrency)] = @(to.floatValue + bottomAmount.floatValue);
    [self updateUI];
}

#pragma mark - Update UI

- (void)updateUI {
    NSArray<ChildControllersViewModel *> *top = @[[self childTopControllerForCurrency:GBP],
                                                  [self childTopControllerForCurrency:EUR],
                                                  [self childTopControllerForCurrency:USD]];
    NSArray<ChildControllersViewModel *> *bottom = @[[self childBottomControllerForCurrency:GBP],
                                                     [self childBottomControllerForCurrency:EUR],
                                                     [self childBottomControllerForCurrency:USD]];
    
    CurrencyType topCurrency = currencyForIndex(self.topIndex);
    CurrencyType bottomCurrency = currencyForIndex(self.bottomIndex);
    ViewControllerViewModel *vm =
    [[ViewControllerViewModel alloc] initWithHeader:[self headerFromCurrency:topCurrency
                                                                  toCurrency:bottomCurrency]
                                      topViewModels:top
                                   bottomViewModels:bottom
                                exchangeIsAvailable:self.exchangeIsAvailable];
    self.UI.viewModel = vm;
}

#pragma mark  - Creating ChildControllersViewModels

- (ChildControllersViewModel *)childTopControllerForCurrency:(CurrencyType)currency {
    return [[ChildControllersViewModel alloc]
            initWithCurrency:[self currencyNames][@(currency)]
            accountBalance:[self accountBalanceTextForCurrency:currency indexType:IndexTypeTop]
            amount:[self topAmount]
            isEditing:YES
            exchangeRateDescription:nil];
}

- (NSString*)topAmount {
    return self.userEnteredAmount.length > 0 ? [@"-" stringByAppendingString:self.userEnteredAmount] : @"";
}

- (ChildControllersViewModel *)childBottomControllerForCurrency:(CurrencyType)currency {
    CurrencyType topCurrency = currencyForIndex(self.topIndex);
    
    NSString *bottomAmountStr;
    if (self.userEnteredAmount.length > 0) {
        NSString *topCurrencyName = [self currencyNames][@(topCurrency)];
        NSString *bottomCurrencyName = [self currencyNames][@(currency)];
        
        NSNumber *topCurrencyRate = self.exchangeRateDictionary[topCurrencyName];
        NSNumber *bottomCurrencyRate = self.exchangeRateDictionary[bottomCurrencyName];
        
        NSNumber *rate = @(bottomCurrencyRate.floatValue / topCurrencyRate.floatValue);
        NSNumber *bottomAmount = @(self.amount.floatValue * rate.floatValue);
        
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.positivePrefix = @"+";
        bottomAmountStr = [formatter stringFromNumber:bottomAmount];
    } else {
        bottomAmountStr = @"";
    }
    
    NSString *exchangeRateDescription = [self headerFromCurrency:topCurrency
                                                      toCurrency:currency];
    
    return [[ChildControllersViewModel alloc]
            initWithCurrency:[self currencyNames][@(currency)]
            accountBalance:[self accountBalanceTextForCurrency:currency indexType:IndexTypeBottom]
            amount:bottomAmountStr
            isEditing:NO
            exchangeRateDescription:exchangeRateDescription];
}

#pragma mark  - Helper

- (NSDecimalNumber *)amount {
    return [NSDecimalNumber decimalNumberWithString:self.userEnteredAmount];
}

- (NSString *)headerFromCurrency:(CurrencyType)fromCurrency toCurrency:(CurrencyType)toCurrency {

    NSString *topCurrencySign = [self currencySymbols][@(fromCurrency)];
    NSString *bottomCurrencySign = [self currencySymbols][@(toCurrency)];
    
    NSString *topCurrencyName = [self currencyNames][@(fromCurrency)];
    NSString *bottomCurrencyName = [self currencyNames][@(toCurrency)];
    
    NSNumber *topCurrencyRate = self.exchangeRateDictionary[topCurrencyName];
    NSNumber *bottomCurrencyRate = self.exchangeRateDictionary[bottomCurrencyName];
    
    NSNumber *rate = @(bottomCurrencyRate.floatValue / topCurrencyRate.floatValue);
    NSMutableString *string =
    [NSMutableString stringWithFormat:@"%@1 = %@%@",
                                      topCurrencySign,
                                      bottomCurrencySign,
                                      rate];
    return string;
}

- (NSAttributedString *)accountBalanceTextForCurrency:(CurrencyType)currency indexType:(IndexType)indexType{
    NSNumber *balance = self.balance[@(currency)];
    NSString *sign = self.currencySymbols[@(currency)];
    NSString *string = [NSString stringWithFormat:@"You have %@%@", sign, balance];
    UIColor *color = (self.exchangeIsAvailable || self.userEnteredAmount.length == 0 || indexType == IndexTypeBottom) ? [UIColor whiteColor] : [UIColor redColor];
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color };
    return [[NSAttributedString alloc] initWithString:string attributes:attrs];
}

- (BOOL)exchangeIsAvailable {
    if (self.userEnteredAmount.length == 0) {
        return NO;
    }
    CurrencyType topCurrency = currencyForIndex(self.topIndex);
    NSNumber *from = self.balance[@(topCurrency)];
    return [from compare:self.amount] == NSOrderedDescending;
}

#pragma mark - Mappers

- (NSDictionary<NSNumber *, NSString *> *)currencyNames {
    return @{
             @(GBP) : @"GBP",
             @(EUR) : @"EUR",
             @(USD) : @"USD"
             };
}

- (NSDictionary<NSNumber *, NSString *> *)currencySymbols {
    return @{
             @(GBP) : @"£",
             @(EUR) : @"€",
             @(USD) : @"$"
             };
}

static CurrencyType currencyForIndex(NSInteger index) {
    if (index == 0) {
        return GBP;
    } else if (index == 1) {
        return EUR;
    } else if (index == 2) {
        return USD;
    }
    NSCAssert(NO, @"Unknown index");
    return -1;
}

#pragma mark - Formatters

- (NSNumber *)numberFromString:(NSString *)string {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.usesSignificantDigits = YES;
    return [numberFormatter numberFromString:string];
}

- (NSString *)stringFromNumber:(NSNumber *)number {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.usesSignificantDigits = YES;
    return [numberFormatter stringFromNumber:number];
}

@end
