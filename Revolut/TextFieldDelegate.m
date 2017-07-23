//
//  TextFieldDelegate.m
//  Revolut
//
//  Created by Iovanna Popova on 20/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "TextFieldDelegate.h"

@implementation TextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *amount = [NSMutableString stringWithString:textField.text];
    [amount replaceCharactersInRange:range withString:string];
    [self.amountDelegate amountChangedTo:amount];
    return NO;
}

@end
