//
//  PageVCDataSource.h
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildViewController.h"

@interface PageVCDataSource : NSObject<UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray<ChildViewController *> *controllers;

@end
