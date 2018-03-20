//
//  UIView+XYUIView.h
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYUIView)


/**
 @param cornerRadius 圆角大小
 @param corner 圆角位置
 */
- (void)xy_clipsViewWithCornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)corner;

/**
 添加边框
 */
- (CALayer *)xy_addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (CALayer *)xy_addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (CALayer *)xy_addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;
- (CALayer *)xy_addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

/**
 四周添加边框
 
 @param color 边框的颜色
 @param borderWidth 边框的宽度
 */
- (void)xy_addUIRectCornerAllCornersWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth;

@end
