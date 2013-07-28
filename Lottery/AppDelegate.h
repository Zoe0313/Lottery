//
//  AppDelegate.h
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuVC.h"

@class MenuVC;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *naviC;
@property (strong, nonatomic) MenuVC *menuVC;

@end
