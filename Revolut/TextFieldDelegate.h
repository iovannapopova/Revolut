//
//  TextFieldDelegate.h
//  Revolut
//
//  Created by Iovanna Popova on 20/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Controller.h"

@interface TextFieldDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) id<AmountDelegate> amountDelegate;

@end
