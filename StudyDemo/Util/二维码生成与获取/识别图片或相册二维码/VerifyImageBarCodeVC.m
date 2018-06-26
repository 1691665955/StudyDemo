//
//  VerifyImageBarCodeVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "VerifyImageBarCodeVC.h"
#import <Photos/Photos.h>
@interface VerifyImageBarCodeVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong)UIImageView *imageView;
@property (nonatomic ,strong)UILabel *resultLB;
@end

@implementation VerifyImageBarCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"识别图片二维码";
    [self initUI];
}

- (void)initUI {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(gotoPhotoAlbum)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, SCREEN_WIDTH-100, SCREEN_WIDTH-100)];
    imageView.image = [UIImage imageNamed:@"barcode"];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, CGRectGetMaxY(imageView.frame)+20, SCREEN_WIDTH-100, 40);
    btn.backgroundColor = [UIColor colorWithRed:90/255.0 green:160/255.0 blue:245/255.0 alpha:1];
    [btn setTitle:@"识别二维码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(verifyBarCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+50, SCREEN_WIDTH, 20)];
    tipLB.textAlignment = NSTextAlignmentCenter;
    tipLB.text = @"二维码识别结果为";
    [self.view addSubview:tipLB];
    
    UILabel *resultLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tipLB.frame)+10, SCREEN_WIDTH, 80)];
    resultLB.numberOfLines = 0;
    resultLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:resultLB];
    self.resultLB = resultLB;
}

- (void)verifyBarCode {
    [self verifyWithImage:self.imageView.image];
}

- (void)verifyWithImage:(UIImage *)image {
    //1. 初始化扫描仪，设置设别类型和识别质量
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    //2. 扫描获取的特征组
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    //3. 获取扫描结果
    if (features.count > 0) {
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedResult = feature.messageString;
        self.resultLB.text = scannedResult;
    } else {
        [self showErrorResult];
    }
}

- (void)showErrorResult {
    [MBProgressHUD showError:@"该图片不存在二维码"];
}

- (void)gotoPhotoAlbum {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_main_queue(), ^{
       [self verifyWithImage:image];
    });
    [picker dismissViewControllerAnimated:YES completion:nil];
}





@end
