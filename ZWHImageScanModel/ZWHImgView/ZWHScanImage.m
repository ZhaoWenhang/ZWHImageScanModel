//
//  ZWHScanImage.m
//  ZWHHLTT
//
//  Created by wenhang on 2017/4/6.
//  Copyright © 2017年 wenhang. All rights reserved.
//

#import "ZWHScanImage.h"
@interface ZWHScanImage()

@end
@implementation ZWHScanImage

//原始尺寸
static CGRect oldframe; //图片原有尺寸
static CGRect bigImgFrame; //图片最大程度



/**
 *  浏览大图
 *
 *  @param currentImageview 图片所在的imageView
 */
+(void)scanBigImageWithImageView:(UIImageView *)currentImageview{
    //当前imageview的图片
    UIImage *image = currentImageview.image;
    
    //当前视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    //当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
    oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];
    [backgroundView setBackgroundColor:[UIColor blackColor]];//colorWithRed:107/255.0 green:107/255.0 blue:99/255.0 alpha:0.6
    //此时视图不会显示
    [backgroundView setAlpha:0];

    //将所展示的imageView重新绘制在Window中
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    [imageView setImage:image];
    [imageView setTag:0];
    imageView.backgroundColor = [UIColor blackColor];
    //[backgroundView addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setUserInteractionEnabled:YES];
    [imageView setMultipleTouchEnabled:YES];
    
    //将原始视图添加到背景视图中
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];
    
    //动画放大所展示的ImageView
    
    [UIView animateWithDuration:0.15 animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
        //宽度为屏幕宽度
        width = [UIScreen mainScreen].bounds.size.width;
        //高度 根据图片宽高比设置
        height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        [imageView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
        
        NSLog(@"y ===== %lf\nwidth ====== %lf\nheight ====== %lf",y,width,height);
    } completion:^(BOOL finished) {
        
    }];

    
    
    
  #pragma - mark 添加手势
    //添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    //添加捏合事件
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGestureRecognizer:)];
    [imageView addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [imageView addGestureRecognizer:panGestureRecognizer];
    
    
    
}

+ (void)downloadImgClick: (UIButton *)btn {
    NSLog(@"点击了下载按钮");

}


/** 捏合手势 */
+(void)pinchGestureRecognizer:(UIPinchGestureRecognizer *)pin{
    //NSLog(@"捏合数据:%@",pin);
    UIView *imageView = pin.view;
    if (pin.state == UIGestureRecognizerStateBegan || pin.state == UIGestureRecognizerStateChanged) {
        imageView.transform = CGAffineTransformScale(imageView.transform, pin.scale, pin.scale);
        
        CGFloat y,width,height;
        
        y = ([UIScreen mainScreen].bounds.size.height - imageView.frame.size.height * [UIScreen mainScreen].bounds.size.width / imageView.frame.size.width) * 0.5;
        //宽度为屏幕宽度
        width = [UIScreen mainScreen].bounds.size.width;
        //高度 根据图片宽高比设置
        height = imageView.frame.size.height * [UIScreen mainScreen].bounds.size.width / imageView.frame.size.width;
        
        bigImgFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        
        
        
        if (imageView.frame.size.width < bigImgFrame.size.width) {
                    [imageView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
                        //让图片无法缩得比原图小
            
                    }
        
        if (imageView.frame.size.width > 3 * bigImgFrame.size.width) {
            NSLog(@"大于三倍了");
            imageView.frame = CGRectMake(0, 0, 3 * bigImgFrame.size.width, 3 * bigImgFrame.size.height);
            CGPoint point = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
            imageView.center = point;
            if (imageView.frame.origin.x < -2 * bigImgFrame.size.width) { //左
                imageView.frame = CGRectMake(-2 * bigImgFrame.size.width, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
            }
            if (imageView.frame.origin.y < -2 * bigImgFrame.size.height){ //上
                imageView.frame = CGRectMake(imageView.frame.origin.x,-2 * bigImgFrame.size.height, imageView.frame.size.width, imageView.frame.size.height);
            }
            if (imageView.frame.origin.x + 2 * bigImgFrame.size.width > 2 * [UIScreen mainScreen].bounds.size.width){ //右
                imageView.frame = CGRectMake(0, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
            }
            if (imageView.frame.origin.y + 2 * bigImgFrame.size.height > 2 * [UIScreen mainScreen].bounds.size.height){ //下
                imageView.frame = CGRectMake(imageView.frame.origin.x,0, imageView.frame.size.width, imageView.frame.size.height);
            }
            }
/**
    捏合手势的上下左右约束
 */
        if (imageView.frame.origin.x > 0) { //左
            imageView.frame = CGRectMake(0, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
        }
        if (imageView.frame.origin.y > 0){ //上
                        imageView.frame = CGRectMake(imageView.frame.origin.x,0, imageView.frame.size.width, imageView.frame.size.height);
        }
        if (imageView.frame.origin.x + imageView.frame.size.width < [UIScreen mainScreen].bounds.size.width){ //右
                    imageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - imageView.frame.size.width, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
        }
        if (imageView.frame.origin.y + imageView.frame.size.height < [UIScreen mainScreen].bounds.size.height){ //下
                    imageView.frame = CGRectMake(imageView.frame.origin.x,[UIScreen mainScreen].bounds.size.height - imageView.frame.size.height, imageView.frame.size.width, imageView.frame.size.height);
        }

        pin.scale = 1;
    }
}



/**
 *  恢复imageView原始尺寸
 *
 *  @param tap 点击事件
 */
+(void)hideImageView:(UITapGestureRecognizer *)tap{

    UIView *backgroundView = tap.view;
    //原始imageview
    UIImageView *imageView = [tap.view viewWithTag:0];
    //恢复
    [UIView animateWithDuration:0.1 animations:^{
        [imageView setFrame:oldframe];
        [backgroundView setAlpha:0];
    } completion:^(BOOL finished) {
        //完成后操作->将背景视图删掉
        [backgroundView removeFromSuperview];
    }];

    
}

//拖拽手势
+(void) panView:(UIPanGestureRecognizer *)pan {
    UIView *view = pan.view;
   
    //判断拖拽到边界的判断
    if (view.frame.size.width == [UIScreen mainScreen].bounds.size.width) {
        
    }
    if (view.frame.origin.x > 0){  //左
        view.frame = CGRectMake(0,view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    }
    if (view.frame.origin.y > 0){ //上
        view.frame = CGRectMake(view.frame.origin.x,0, view.frame.size.width, view.frame.size.height);
    }
    if (view.frame.origin.x + view.frame.size.width < [UIScreen mainScreen].bounds.size.width){ //右
        view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - view.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    }
    if (view.frame.origin.y + view.frame.size.height < [UIScreen mainScreen].bounds.size.height){ //下
        view.frame = CGRectMake(view.frame.origin.x,[UIScreen mainScreen].bounds.size.height - view.frame.size.height, view.frame.size.width, view.frame.size.height);
    }
    
    
        if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
            CGPoint translation = [pan translationInView:view.superview];
            [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
            [pan setTranslation:CGPointZero inView:view.superview];
        
    }
    
    

}
@end
