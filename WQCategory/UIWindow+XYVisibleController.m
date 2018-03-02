//
//  UIWindow+XYVisibleController.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "UIWindow+XYVisibleController.h"

@implementation UIWindow (XYVisibleController)

/**
 获取当前窗口可见ViewController
 */
- (UIViewController *)xy_currentVisibleController {
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController && ![vc.presentedViewController isKindOfClass:[UIAlertController class]]) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

@end
