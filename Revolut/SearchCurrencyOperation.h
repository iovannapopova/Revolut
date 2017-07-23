//
//  SearchCurrencyOperation.h
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncOperation.h"

typedef void (^SearchCompletionHandler)(NSDictionary *, NSError *);

@interface SearchCurrencyOperation : AsyncOperation

- (instancetype)initWithSession:(NSURLSession *)session
                            URL:(NSURL *)url
                     completion:(SearchCompletionHandler)completion;

@end
