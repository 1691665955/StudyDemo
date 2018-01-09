//
//  CreateBarCodeVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "CreateBarCodeVC.h"

@interface CreateBarCodeVC ()<UITextFieldDelegate>
@property (nonatomic ,strong)UITextField *textField;
@property (nonatomic ,strong)UIImageView *imageView;
@end

@implementation CreateBarCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生成二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)initUI {
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 64+20, SCREEN_WIDTH, 20)];
    tipLB.text = @"请输入字符串生成二维码";
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLB];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 64+50, SCREEN_WIDTH-60, 40)];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.delegate = self;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = CGRectMake(50, CGRectGetMaxY(textField.frame)+20, SCREEN_WIDTH-100, 40);
    createBtn.backgroundColor = [UIColor colorWithRed:90/255.0 green:160/255.0 blue:245/255.0 alpha:1];
    [createBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createBarCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
    
    UILabel *imageTipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(createBtn.frame)+40, SCREEN_WIDTH, 20)];
    imageTipLB.text = @"生成二维码如下";
    imageTipLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:imageTipLB];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(imageTipLB.frame)+10, SCREEN_WIDTH-100, SCREEN_WIDTH-100)];
    imageView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

- (void)createBarCode {
    if (self.textField.text.length > 0) {
        [self.textField resignFirstResponder];
        self.imageView.image = [self createScanCodeImageWithScanCodeString:self.textField.text];
    } else {
        [self.textField becomeFirstResponder];
        [MBProgressHUD showError:@"请输入字符串"];
    }
}

- (UIImage *)createScanCodeImageWithScanCodeString:(NSString *)string {
    //创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复默认设置
    [filter setDefaults];
    //设置数据
    NSData *infoData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKey:@"inputMessage"];
    //生成二维码
    CIImage *outputImage = [filter outputImage];
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:SCREEN_WIDTH-100];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
