//
//  PageViewControllerGraph.m
//  Revolut
//
//  Created by Iovanna Popova on 20/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "PageViewControllerGraph.h"

@interface PageViewControllerGraph ()

@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) NSArray<ChildViewController *> *controllers;
@property (nonatomic, strong) PageVCDelegate *delegate;
@property (nonatomic, strong) PageVCDataSource *dataSource;
@property (nonatomic, strong) TextFieldDelegate *textFieldDelegate;

@end

@implementation PageViewControllerGraph {
    IndexType _indexType;
}

- (instancetype)initWithIndexType:(IndexType)type {
    self = [super init];
    if (self) {
        _indexType = type;
    }
    return self;
}

- (UIPageViewController *)pageVC {
    if (_pageVC == nil) {
        _pageVC = [[UIPageViewController alloc]
                      initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                      navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                      options:nil];
        _pageVC.delegate = self.delegate;
        _pageVC.dataSource = self.dataSource;
        [_pageVC setViewControllers:@[self.controllers.firstObject]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];

    }
    return _pageVC;
}

- (id<UIPageViewControllerDelegate>)delegate {
    if (_delegate == nil) {
        _delegate = [[PageVCDelegate alloc] initWithIndexType:_indexType];
    }
    return _delegate;
}

- (NSArray<UIViewController *> *)controllers {
    if (_controllers == nil) {
        ChildViewController* vc1 = [[ChildViewController alloc] initWithTextFieldDelegate:self.textFieldDelegate];
        ChildViewController* vc2 = [[ChildViewController alloc] initWithTextFieldDelegate:self.textFieldDelegate];
        ChildViewController* vc3 = [[ChildViewController alloc] initWithTextFieldDelegate:self.textFieldDelegate];
        _controllers = @[vc1, vc2, vc3];
    }
    return _controllers;
}

- (PageVCDataSource *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [PageVCDataSource new];
        _dataSource.controllers = self.controllers;
    }
    return _dataSource;
}

- (TextFieldDelegate *)textFieldDelegate {
    if (_textFieldDelegate == nil) {
        _textFieldDelegate = [TextFieldDelegate new];
    }
    return _textFieldDelegate;
}


@end
