//
//  UIViewController+XYPrintClassName.m
//  xinhuammPlatform
//
//  Created by tanghaiyang on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "UIViewController+XYPrintClassName.h"
#import <objc/runtime.h>

@implementation UIViewController (XYPrintClassName)

#ifdef DEBUG
+ (void)load {
    
    NSString*className=NSStringFromClass(self.class);
    NSLog(@"classname----->%@",className);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class=[self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xy_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class,originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class,swizzledSelector);
        
        BOOL didAddMethod=
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod,swizzledMethod);
        }
    });
}

- (void)xy_viewWillAppear:(BOOL)animated {
    NSLog(@"\n跳到了控制器----->%@\n",self);
    [self xy_viewWillAppear:animated];
}
#endif
@end

