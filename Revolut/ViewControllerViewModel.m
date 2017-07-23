//
//  ViewControllerViewModel.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "ViewControllerViewModel.h"

@interface ViewControllerViewModel ()

@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSArray<ChildControllersViewModel *> *topViewModels;
@property (nonatomic, copy) NSArray<ChildControllersViewModel *> *bottomViewModels;
@property (nonatomic, assign) BOOL exchangeIsAvailable;

@end

@implementation ViewControllerViewModel

- (instancetype)initWithHeader:(NSString *)header
                 topViewModels:(NSArray<ChildControllersViewModel *> *)topViewModels
              bottomViewModels:(NSArray<ChildControllersViewModel *> *)bottomViewModels exchangeIsAvailable:(BOOL)exchangeIsAvailable {
    self = [super init];
    if (self) {
        _header = [header copy];
        _topViewModels = [topViewModels copy];
        _bottomViewModels = [bottomViewModels copy];
        _exchangeIsAvailable = exchangeIsAvailable;
    }
    return self;
}

@end
