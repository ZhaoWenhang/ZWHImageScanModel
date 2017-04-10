//
//  ZWHImageView.m
//  ZWHHLTT
//
//  Created by wenhang on 2017/4/6.
//  Copyright © 2017年 wenhang. All rights reserved.
//

#import "ZWHImageView.h"
#import "ZWHScanImage.h"
@interface ZWHImageView()


@end

@implementation ZWHImageView


- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString*)imageName contentMode:(UIViewContentMode)contentMode ifCheckBigImage:(BOOL)ifCheckBigImage {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.image = [UIImage imageNamed:imageName];
        self.contentMode = contentMode;
        self.userInteractionEnabled = ifCheckBigImage;
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scanBigImgClick:)];
    [self addGestureRecognizer:tap];
    
    
}

- (void) scanBigImgClick:(UITapGestureRecognizer *)tap {
    NSLog(@"点击了图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [ZWHScanImage scanBigImageWithImageView:clickedImageView];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
