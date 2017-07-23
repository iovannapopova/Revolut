//
//  PageViewControllerGraph.h
//  Revolut
//
//  Created by Iovanna Popova on 20/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PageVCDataSource.h"
#import "PageVCDelegate.h"
#import "TextFieldDelegate.h"

@interface PageViewControllerGraph : NSObject

@property (nonatomic, strong, readonly) UIPageViewController *pageVC;
@property (nonatomic, strong, readonly) NSArray<ChildViewController *> *controllers;
@property (nonatomic, strong, readonly) PageVCDelegate *delegate;
@property (nonatomic, strong, readonly) PageVCDataSource *dataSource;
@property (nonatomic, strong, readonly) TextFieldDelegate *textFieldDelegate;

- (instancetype)initWithIndexType:(IndexType)type;

@end
