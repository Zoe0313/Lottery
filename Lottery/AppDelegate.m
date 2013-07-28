//
//  AppDelegate.m
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    self.menuVC = [[MenuVC alloc] initWithNibName:@"MenuVC" bundle:nil];
    self.naviC = [[UINavigationController alloc] initWithRootViewController:self.menuVC];
    [self.window addSubview:self.naviC.view];
    self.window.rootViewController = self.naviC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

@end
