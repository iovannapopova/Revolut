//
//  AppDelegate.m
//  Revolut
//
//  Created by Iovanna Popova on 19/07/2017.
//  Copyright © 2017 IP. All rights reserved.
//

#import "AppDelegate.h"
#import "Router.h"

@interface AppDelegate ()

@property (nonatomic, strong) Router *router;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.router = [[Router alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.router.rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
