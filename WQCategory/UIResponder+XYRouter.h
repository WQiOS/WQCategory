//
//  UIResponder+XYRouter.h
//  XYUIResponder
//
//  Created by xinhuamm on 2017/12/12.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (XYRouter)

- (void)routerEventWithSelector:(SEL)selector argumengts:(NSArray *)argumengts;

- (void)routerEventWithSelector:(SEL)selector argumengts:(NSArray *)argumengts completionBlock:(void(^)(BOOL isSuccess)) block;

@end
