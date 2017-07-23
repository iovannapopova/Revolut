//
//  ChildViewController.h
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildControllersViewModel.h"

@interface ChildViewController : UIViewController

- (instancetype)initWithTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate;

@property (nonatomic, strong) ChildControllersViewModel *viewModel;

@end
