//
//  UIView+XYUIView.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "UIView+XYUIView.h"

@implementation UIView (XYUIView)

-(void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return  self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return  self.center.y;
}
- (CGFloat) top {
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left {
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (UIImage *)xy_captureView {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO,scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)xy_captureViewWithRect:(CGRect)rect andLayer:(CALayer *)layer {
    //    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO,0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    CGImageRef imageRefRect =CGImageCreateWithImageInRect(img.CGImage, rect);
    //    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    return img;
}

+ (UIView *)xy_line {
    UIView *splitLine = UIView.new;
    splitLine.backgroundColor = [UIColor lightGrayColor];
    splitLine.alpha = 0.5;
    return splitLine;
}


+ (UIView *)xy_contentViewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [view xy_addTopSplitLine];
    [view xy_addBottomSplitLine];
    return view;
}

- (void)xy_addTopSplitLine {
    [self xy_addSplitLineWithFrame:CGRectMake(0, 0, self.width, 0.5)];
}

- (void)xy_addBottomSplitLine {
    [self xy_addSplitLineWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
}

- (void)xy_addSplitLineAtBottomWith:(UIView *)view {
    [self xy_addSplitLineWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame) - 0.5, self.width, 0.5)];
}

- (void)xy_addSplitLineWithFrame:(CGRect)frame {
    UIView *splitLine = [UIView xy_line];
    [self addSubview:splitLine];
    
    splitLine.frame = frame;
}


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

- (void)xy_addShadowWithCornerRadius:(NSUInteger)radius shadowColor:(UIColor*)shadowColor{
    self.layer.masksToBounds = YES;
    self.clipsToBounds = NO;
    self.layer.cornerRadius = radius;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowRadius = 3;//阴影半径，默认3
    self.layer.shadowOpacity = 0.4;//阴影透明度，默认0
}

@end
