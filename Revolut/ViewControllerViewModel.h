//
//  ViewControllerViewModel.h
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChildControllersViewModel.h"

@interface ViewControllerViewModel : NSObject

- (instancetype)initWithHeader:(NSString *)header
                 topViewModels:(NSArray<ChildControllersViewModel *> *)topViewModels
              bottomViewModels:(NSArray<ChildControllersViewModel *> *)bottomViewModels
           exchangeIsAvailable:(BOOL)exchangeIsAvailable;

@property (nonatomic, copy, readonly) NSString *header;
@property (nonatomic, copy, readonly) NSArray<ChildControllersViewModel *> *topViewModels;
@property (nonatomic, copy, readonly) NSArray<ChildControllersViewModel *> *bottomViewModels;
@property (nonatomic, assign, readonly) BOOL exchangeIsAvailable;

@end
