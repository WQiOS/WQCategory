//
//  UIResponder+XYRouter.m
//  XYUIResponder
//
//  Created by xinhuamm on 2017/12/12.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "UIResponder+XYRouter.h"

@implementation UIResponder (XYRouter)

- (void)routerEventWithSelector:(SEL)selector argumengts:(NSArray *)argumengts {
    [[self nextResponder] routerEventWithSelector:selector argumengts:argumengts];
}

- (void)routerEventWithSelector:(SEL)selector argumengts:(NSArray *)argumengts completionBlock:(void (^)(BOOL))block{
    
    [[self nextResponder] routerEventWithSelector:selector argumengts:argumengts completionBlock:block];
}


@end
