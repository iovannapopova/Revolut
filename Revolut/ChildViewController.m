//
//  ChildViewController.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "ChildViewController.h"
#import "Controller.h"

@interface ChildViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) id<UITextFieldDelegate> textFieldDelegate;

@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UILabel *accountBalanceLabel;
@property (nonatomic, strong) UITextField *amountTextField;
@property (nonatomic, strong) UILabel *exchangeRateDescriptionLabel;

@end

@implementation ChildViewController

- (instancetype)initWithTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate {
    self = [super init];
    if (self) {
        _textFieldDelegate = textFieldDelegate;
    }
    return self;
}

- (void)setViewModel:(ChildControllersViewModel *)viewModel {
    if (_viewModel != viewModel) {
        _viewModel = viewModel;
        [self updateUI];
    }
}

- (UILabel *)currencyLabel {
    if (_currencyLabel == nil) {
        _currencyLabel = [UILabel new];
        _currencyLabel.textAlignment = NSTextAlignmentLeft;
        _currencyLabel.textColor = [UIColor whiteColor];
        _currencyLabel.font = [UIFont systemFontOfSize:24.0];
    }
    return _currencyLabel;
}

- (UILabel *)accountBalanceLabel {
    if (_accountBalanceLabel == nil) {
        _accountBalanceLabel = [UILabel new];
        _accountBalanceLabel.textAlignment = NSTextAlignmentLeft;
        _accountBalanceLabel.textColor = [UIColor whiteColor];
    }
    return _accountBalanceLabel;
}

- (UITextField *)amountTextField {
    if (_amountTextField == nil) {
        _amountTextField = [UITextField new];
        _amountTextField.textAlignment = NSTextAlignmentRight;
        _amountTextField.textColor = [UIColor whiteColor];
        _amountTextField.font = [UIFont systemFontOfSize:24.0];
        _amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _amountTextField.tintColor = [UIColor whiteColor];
        _amountTextField.delegate = self.textFieldDelegate;
    }
    return _amountTextField;
}

- (UILabel *)exchangeRateDescriptionLabel {
    if (_exchangeRateDescriptionLabel == nil) {
        _exchangeRateDescriptionLabel = [UILabel new];
        _exchangeRateDescriptionLabel.textAlignment = NSTextAlignmentRight;
        _exchangeRateDescriptionLabel.textColor = [UIColor whiteColor];
    }
    return _exchangeRateDescriptionLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.currencyLabel];
    [self.view addSubview:self.accountBalanceLabel];
    [self.view addSubview:self.exchangeRateDescriptionLabel];
    [self.view addSubview:self.amountTextField];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.currencyLabel.frame = CGRectMake(40,
                                          0,
                                          CGRectGetWidth(self.view.bounds)/2 - 40.0,
                                          CGRectGetHeight(self.view.bounds)/2);
    self.accountBalanceLabel.frame = CGRectMake(40,
                                                CGRectGetMaxY(self.currencyLabel.frame),
                                                CGRectGetWidth(self.view.bounds)/2 - 40.0,
                                                CGRectGetHeight(self.view.bounds)/2);
    self.amountTextField.frame =
    CGRectMake(CGRectGetMaxX(self.currencyLabel.frame),
               0,
               CGRectGetWidth(self.view.bounds)/2 - 40,
               CGRectGetHeight(self.view.bounds)/2);
    self.exchangeRateDescriptionLabel.frame =
    CGRectMake(CGRectGetMinX(self.amountTextField.frame),
               CGRectGetMaxY(self.amountTextField.frame),
               CGRectGetWidth(self.view.bounds)/2 - 40,
               CGRectGetHeight(self.view.bounds)/2);
}

- (void)updateUI {
    self.currencyLabel.text = self.viewModel.currency;
    self.accountBalanceLabel.attributedText = self.viewModel.accountBalance;
    self.amountTextField.text = self.viewModel.amount;
    self.amountTextField.enabled = self.viewModel.amountIsEditable;
    self.exchangeRateDescriptionLabel.text = self.viewModel.exchangeRateDescription;
}

- (NSString *)stringValueForCurrency:(CurrencyType)currency {
    switch (currency) {
        case EUR:
            return @"EUR";
            
        case USD:
            return @"USD";
            
        case GBP:
            return @"GBP";

        default:
            return @"";
    }
}

@end
