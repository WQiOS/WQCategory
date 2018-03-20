//
//  UIView+XYUIView.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "UIView+XYUIView.h"

@implementation UIView (XYUIView)

/**
 @param cornerRadius 圆角大小
 @param corner 圆角位置
 */
- (void)xy_clipsViewWithCornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)corner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadius, self.bounds.size.height)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (CALayer *)xy_addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    return border;
}

- (CALayer *)xy_addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    return border;
}

- (CALayer *)xy_addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    return border;
}

- (CALayer *)xy_addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    return border;
}

/**
 四周添加边框
 
 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)xy_addUIRectCornerAllCornersWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth{
    [self xy_addRightBorderWithColor:color andWidth:borderWidth];
    [self xy_addLeftBorderWithColor:color andWidth:borderWidth];
    [self xy_addBottomBorderWithColor:color andWidth:borderWidth];
    [self xy_addTopBorderWithColor:color andWidth:borderWidth];
}


@end
