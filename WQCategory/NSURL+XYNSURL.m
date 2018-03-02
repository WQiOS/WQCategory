//
//  NSURL+XYNSURL.m
//  xinhuammPlatform
//
//  Created by tanghaiyang on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "NSURL+XYNSURL.h"
#import <Photos/Photos.h>

@implementation NSURL (XYNSURL)

- (NSString *)xy_valueForComponentKey:(NSString *)key {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
    NSArray *queryItems = urlComponents.queryItems;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name=%@", key];
    NSURLQueryItem *queryItem = [[queryItems filteredArrayUsingPredicate:predicate] firstObject];
    return queryItem.value;
}

- (void)xy_imageFromAssetURL:(void(^)(UIImage *image))block {
    PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[self] options:0];
    if (result.firstObject) {
        [[PHImageManager defaultManager] requestImageForAsset:result.firstObject targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                UIImage *newImg = nil;
                if (result.size.width > 750) {
                    CGSize newSize = CGSizeMake(750, result.size.height*(750/result.size.width));
                    @autoreleasepool {
                        UIGraphicsBeginImageContext(newSize);
                        [result drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
                        newImg = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                    }
                }
                else {
                    newImg = result;
                }
                NSData *data = UIImageJPEGRepresentation(newImg,0.8);
                //  超过300kb再压缩
                if (data.length >= 300000) {
                    data = UIImageJPEGRepresentation(newImg,0.7);
                }
                UIImage *photoImage = [UIImage imageWithData:data];
                block(photoImage);
            }
        }];
    }
}

@end
