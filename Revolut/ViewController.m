//
//  ViewController.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "ViewController.h"
#import "PageVCDataSource.h"
#import "ChildControllersViewModel.h"
#import "ChildViewController.h"
#import "PageVCDataSource.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *currentRateLabel;
@property (nonatomic, strong) UIButton *exchangeButton;
@property (nonatomic, strong) UIPageViewController *topPageVC;
@property (nonatomic, strong) UIPageViewController *bottomPageVC;

@end

@implementation ViewController

- (instancetype)initWithTopPageVC:(UIPageViewController *)topPageVC
                     bottomPageVC:(UIPageViewController *)bottomPageVC {
    self = [super initWithNibName:nil
                           bundle:nil];
    if (self) {
        _topPageVC = topPageVC;
        _bottomPageVC = bottomPageVC;
    }
    return self;
}

- (UILabel *)currentRateLabel {
    if (_currentRateLabel == nil) {
        _currentRateLabel = [UILabel new];
        _currentRateLabel.text = @"Load...";
        _currentRateLabel.textColor = [UIColor whiteColor];
        _currentRateLabel.textAlignment = NSTextAlignmentCenter;
        _currentRateLabel.layer.cornerRadius = 4.0;
        _currentRateLabel.layer.borderWidth = 1.0;
        _currentRateLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _currentRateLabel;
}

- (UIButton *)exchangeButton {
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton addTarget:self
                            action:@selector(exchangeButtonDidTouchUpInside)
                  forControlEvents:UIControlEventTouchUpInside];
        [_exchangeButton setTitle:@"Exchange" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor whiteColor]
                              forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:[UIColor lightGrayColor]
                              forState:UIControlStateDisabled];
        _exchangeButton.layer.cornerRadius = 4.0;
        _exchangeButton.layer.borderWidth = 1.0;
        _exchangeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _exchangeButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  [UIColor colorWithRed:0.0/255.0
                                                 green:123.0/255.0
                                                  blue:227.0/255.0
                                                 alpha:1.0];
    
    [self.view addSubview:self.currentRateLabel];
    [self.view addSubview:self.exchangeButton];
    
    [self.topPageVC willMoveToParentViewController:self];
    [self addChildViewController:self.topPageVC];
    [self.view addSubview:self.topPageVC.view];
    [self.topPageVC didMoveToParentViewController:self];
    
    [self.bottomPageVC willMoveToParentViewController:self];
    [self addChildViewController:self.bottomPageVC];
    [self.view addSubview:self.bottomPageVC.view];
    [self.bottomPageVC didMoveToParentViewController:self];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.currentRateLabel.frame = CGRectMake(0, 40, 150, 30);
    self.currentRateLabel.center = CGPointMake(self.view.center.x, self.currentRateLabel.center.y);
    self.exchangeButton.frame = CGRectMake(CGRectGetMaxX(self.currentRateLabel.frame) + 10,
                                           40,
                                           CGRectGetWidth(self.view.bounds)/2 -
                                           CGRectGetWidth(self.currentRateLabel.frame)/2 - 20,
                                           30);
    self.topPageVC.view.frame = CGRectMake(0,
                                      CGRectGetMaxY(self.currentRateLabel.frame),
                                      CGRectGetWidth(self.view.bounds),
                                           190.0);
    self.bottomPageVC.view.frame = CGRectMake(0,
                                           CGRectGetMaxY(self.topPageVC.view.frame),
                                           CGRectGetWidth(self.view.bounds),
                                           190.0);
}

- (void)setViewModel:(ViewControllerViewModel *)viewModel {
    self.currentRateLabel.text = viewModel.header;
    NSArray<ChildViewController *> *topChildVCs = [(PageVCDataSource *)self.topPageVC.dataSource controllers];
    for (NSUInteger index = 0; index < topChildVCs.count; index++) {
        topChildVCs[index].viewModel = viewModel.topViewModels[index];
    }
    NSArray<ChildViewController *> *bottomChildVCs = [(PageVCDataSource *)self.bottomPageVC.dataSource controllers];;
    for (NSUInteger index = 0; index < bottomChildVCs.count; index++) {
        bottomChildVCs[index].viewModel = viewModel.bottomViewModels[index];
    }
    self.exchangeButton.enabled = viewModel.exchangeIsAvailable;
}

- (void)exchangeButtonDidTouchUpInside {
    [self.balanceDelegate exchange];
}

@end
