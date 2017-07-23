//
//  ViewController.h
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageVCDelegate.h"
#import "ViewControllerViewModel.h"
#import "UI.h"
#import "Controller.h"

@interface ViewController : UIViewController<UI>

- (instancetype)initWithTopPageVC:(UIPageViewController *)topPageVC
                     bottomPageVC:(UIPageViewController *)bottomPageVC;

@property (nonatomic, strong) id<BalanceDelegate> balanceDelegate;

@end

