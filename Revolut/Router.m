//
//  Router.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "Router.h"
#import "ViewController.h"

#import "Controller.h"

#import "ViewControllerViewModel.h"
#import "ChildControllersViewModel.h"
#import "PageViewControllerGraph.h"

@interface Router()

@property (nonatomic, strong) ViewController *viewController;

@property (nonatomic, strong) Controller* controller;

@property (nonatomic, strong) PageViewControllerGraph *pageVCGraph;
@property (nonatomic, strong) PageViewControllerGraph *bottomPageVCGraph;

@end

@implementation Router

- (instancetype)init {
    self = [super init];
    if (self) {
        _pageVCGraph = [[PageViewControllerGraph alloc] initWithIndexType:IndexTypeTop];
        _bottomPageVCGraph = [[PageViewControllerGraph alloc] initWithIndexType:IndexTypeBottom];
        _viewController = [[ViewController alloc] initWithTopPageVC:_pageVCGraph.pageVC
                                                       bottomPageVC:_bottomPageVCGraph.pageVC];
        _controller = [[Controller alloc] initWithBalance:[self startBalanceDictionary]
                                                       UI:_viewController];
        _pageVCGraph.delegate.selectionDelegate = _controller;
        _bottomPageVCGraph.delegate.selectionDelegate = _controller;
        _pageVCGraph.textFieldDelegate.amountDelegate = _controller;
        _viewController.balanceDelegate = _controller;
        [_controller startUpdatingExchangeRateWithTimeInterval:30.0];
    }
    return self;
}

- (UIViewController *)rootViewController {
    return self.viewController;
}

- (NSMutableDictionary *)startBalanceDictionary {
    return [@{
              @(GBP) : @(100),
              @(EUR) : @(100),
              @(USD) : @(100)
              } mutableCopy];
}

@end
