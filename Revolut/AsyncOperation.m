//
//  AsyncOperation.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "AsyncOperation.h"

@interface AsyncOperation ()

@property (nonatomic, assign, getter=isExecuting) BOOL executing;
@property (nonatomic, assign, getter=isFinished) BOOL finished;

@end

@implementation AsyncOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)init {
    self = [super init];
    if (self) {
        _executing = _finished = NO;
    }
    return self;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)start {
    if (self.isCancelled) {
        [self complete];
        return;
    }
    self.executing = YES;
    [self doStart];
}

- (void)doStart {
    NSAssert(NO, @"You have to override %@ in a subclass", NSStringFromSelector(_cmd));
}

- (void)complete {
    self.executing = NO;
    self.finished = YES;
}

- (void)setExecuting:(BOOL)executing {
    if (executing != _executing) {
        [self willChangeValueForKey:@"isExecuting"];
        _executing = executing;
        [self didChangeValueForKey:@"isExecuting"];
    }
}

- (void)setFinished:(BOOL)finished {
    if (finished != _finished) {
        [self willChangeValueForKey:@"isFinished"];
        _finished = finished;
        [self didChangeValueForKey:@"isFinished"];
    }
}

@end

