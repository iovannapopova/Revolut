//
//  AsyncOperation.h
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncOperation : NSOperation

- (void)doStart;
- (void)complete;

@end
