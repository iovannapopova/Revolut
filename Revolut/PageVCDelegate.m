//
//  PageVCDelegate.m
//  Revolut
//
//  Created by Iovanna Popova on 20/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "PageVCDelegate.h"
#import "PageVCDataSource.h"

@implementation PageVCDelegate {
    IndexType _indexType;
}

- (instancetype)initWithIndexType:(IndexType)type {
    self = [super init];
    if (self) {
        _indexType = type;
    }
    return self;
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSUInteger index = [[(PageVCDataSource *)pageViewController.dataSource controllers] indexOfObject:pageViewController.viewControllers.firstObject];
        [self.selectionDelegate selectedCurrencyIndexOfType:_indexType changedTo:index];
    }
}

@end
