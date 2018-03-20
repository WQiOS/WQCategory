//
//  NSURL+XYNSURL.h
//  xinhuammPlatform
//
//  Created by tanghaiyang on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 NSURL的类别添加方法
 */
@interface NSURL (XYNSURL)

/**
 获取url拼接符中的字段
 
 @param key 等号左边的key值
 @return 等号右边的value值
 */
- (NSString *)xy_valueForComponentKey:(NSString *)key;

/**
 通过AssetUrl获取image
 
 @param block 返回Image
 */
- (void)xy_imageFromAssetURL:(void(^)(UIImage *image))block;


@end
