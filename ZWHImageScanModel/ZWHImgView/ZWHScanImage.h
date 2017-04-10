//
//  ZWHScanImage.h
//  ZWHHLTT
//
//  Created by wenhang on 2017/4/6.
//  Copyright © 2017年 wenhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZWHScanImage : NSObject
/**
 *  浏览大图
 *
 *  @param currentImageview 图片所在的imageView
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview;
@end
