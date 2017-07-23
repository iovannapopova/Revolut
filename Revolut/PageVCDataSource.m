//
//  PageVCDataSource.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "PageVCDataSource.h"

@interface PageVCDataSource()<UIPageViewControllerDataSource>

@property (nonatomic, assign) NSInteger presentationPageIndex;

@end

@implementation PageVCDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.controllers indexOfObject:(ChildViewController *)viewController];
    self.presentationPageIndex = index;
    if (index == NSNotFound) {
        return nil;
    }
    if (index == self.controllers.count - 1) {
        index = -1;
    }
    index++;
    return self.controllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.controllers indexOfObject:(ChildViewController *)viewController];
    self.presentationPageIndex = index;
    if (index == NSNotFound) {
        return nil;
    }
    if (index == 0) {
        index = self.controllers.count;
    }
    index--;
    return self.controllers[index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.controllers.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController{
    return self.presentationPageIndex;
}

@end
