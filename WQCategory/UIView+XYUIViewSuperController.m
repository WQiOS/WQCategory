//
//  UIView+XYUIViewSuperController.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/19.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "UIView+XYUIViewSuperController.h"

@implementation UIView (XYUIViewSuperController)

/**
获取当前view所在的Controller
*/
- (UIViewController *)xy_superViewController {
    
    for (UIView *vw = [self superview]; vw; vw = vw.superview) {
        UIResponder *nextResponder = [vw nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
