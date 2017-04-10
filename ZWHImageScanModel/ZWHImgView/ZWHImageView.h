//
//  ZWHImageView.h
//  ZWHHLTT
//
//  Created by wenhang on 2017/4/6.
//  Copyright © 2017年 wenhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWHImageView : UIImageView
/** 
 是否查看大图,默认是不查看
 */
@property (nonatomic, assign)BOOL ifCheckBigImage;
/** 
image:frame | imageName:图片名称 | contentMode:图片填充模式 | ifCheckBigImage:是否查看大图 || 自定义imageView 实现识别手势点击查看,缩放,保存本地
 */
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString*)imageName contentMode:(UIViewContentMode)contentMode ifCheckBigImage:(BOOL)ifCheckBigImage;
@end
