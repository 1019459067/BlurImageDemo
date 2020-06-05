//
//  ViewController.m
//  BlurImageDemo
//
//  Created by XWH on 2020/6/5.
//  Copyright © 2020 XWH. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Blur.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *blurView;
@property (weak, nonatomic) IBOutlet UIImageView *textImage;

@property (weak, nonatomic) IBOutlet UISlider *tintSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *blurSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.blurView.backgroundColor = UIColor.whiteColor;
    self.tintSlider.value = 0;
    self.saturationSlider.value = 2.5;
    self.blurSlider.value = 8;
    
    [self setBackGroundColor:nil];
}

- (IBAction)setBackGroundColor:(UISlider *)sender {
    UIImage *image = [UIImage imageNamed:@"bg_image"];
    
    UIImage *scaleImg = [self scaleWithImage:image toHeight:self.blurView.frame.size.height];
    [scaleImg blurImageWithColor:UIColor.blackColor
                    colorOpacity:self.tintSlider.value
           saturationDeltaFactor:self.saturationSlider.value
                      blurRadius:self.blurSlider.value
                      completion:^(UIImage *blurImage) {
        self.blurView.image = blurImage;
    }];
    
}
- (UIImage *)scaleWithImage:(UIImage *)image toHeight:(CGFloat)maxHeight
{
    CGFloat scale = image.size.width/image.size.height;
    CGFloat maxWidth = maxHeight * scale;
    return [self scaleWithWithImage:image width:maxWidth height:maxHeight];
    
}

- (UIImage *)scaleWithWithImage:(UIImage *)image
                          width:(CGFloat)width
                         height:(CGFloat)height
{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, UIScreen.mainScreen.scale);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, width, height)];
    //3.从上下文中获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

@end
