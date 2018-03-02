//
//  UIView+XYUIView.h
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYUIView)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

- (UIImage *)xy_captureView;
- (UIImage *)xy_captureViewWithRect:(CGRect)rect andLayer:(CALayer *)layer;

+ (UIView *)xy_line;

+ (UIView *)xy_contentViewWithFrame:(CGRect)frame;

- (void)xy_addTopSplitLine;
- (void)xy_addBottomSplitLine;
- (void)xy_addSplitLineWithFrame:(CGRect)frame;
- (void)xy_addSplitLineAtBottomWith:(UIView *)view;

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

/**
 四周添加圆角和阴影
 
 @param radius 圆角大小
 @param shadowColor 阴影颜色
 */
- (void)xy_addShadowWithCornerRadius:(NSUInteger)radius shadowColor:(UIColor*)shadowColor;

@end
