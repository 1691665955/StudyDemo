//
//  ScanBarCodeVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "ScanBarCodeVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

#define SCANVIEW_EdgeTop 100
#define SCANVIEW_EdgeLeft 50.0

#define TINTCOLOR_ALPHA 0.4  //浅色透明度
#define DARKCOLOR_ALPHA 0.5  //深色透明度

@interface ScanBarCodeVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong,nonatomic)AVAudioPlayer *beep;
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property(nonatomic,strong) UIButton *openButton;
@property(nonatomic,strong) UIImageView *QrCodeline;
@end

@implementation ScanBarCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"二维码扫描";
    [self setupView];
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    [_output setRectOfInterest:CGRectMake(SCANVIEW_EdgeTop/SCREEN_HEIGHT, SCANVIEW_EdgeLeft/SCREEN_WIDTH, (SCREEN_WIDTH-2*SCANVIEW_EdgeLeft)/SCREEN_HEIGHT , (SCREEN_WIDTH-2*SCANVIEW_EdgeLeft)/SCREEN_WIDTH)];
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height);
    [self.view.layer insertSublayer:_preview atIndex:0];
}

- (void)setupView {
    //最上部view
    
    UIView* upView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCANVIEW_EdgeTop)];
    upView.alpha =TINTCOLOR_ALPHA;
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    
    //左侧的view
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0,SCANVIEW_EdgeTop,SCANVIEW_EdgeLeft,SCREEN_WIDTH-2*SCANVIEW_EdgeLeft)];
    leftView.alpha =TINTCOLOR_ALPHA;
    leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:leftView];
    
    /******************中间扫描区域****************************/
    UIImageView *scanCropView=[[UIImageView alloc]initWithFrame:CGRectMake(SCANVIEW_EdgeLeft,SCANVIEW_EdgeTop,SCREEN_WIDTH-2*SCANVIEW_EdgeLeft,SCREEN_WIDTH-2*SCANVIEW_EdgeLeft)];
    
    scanCropView.backgroundColor=[UIColor clearColor];
    scanCropView.image = [UIImage imageNamed:@"scan1"];
    [self.view addSubview:scanCropView];
    
    
    /**********************************************************************/
    
    //右侧的view
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCANVIEW_EdgeLeft,SCANVIEW_EdgeTop,SCANVIEW_EdgeLeft,SCREEN_WIDTH-2*SCANVIEW_EdgeLeft)];
    rightView.alpha =TINTCOLOR_ALPHA;
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
    
    //底部view
    UIView *downView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_WIDTH-2*SCANVIEW_EdgeLeft+SCANVIEW_EdgeTop,SCREEN_WIDTH,SCREEN_HEIGHT-(SCREEN_WIDTH-2*SCANVIEW_EdgeLeft+SCANVIEW_EdgeTop))];
    downView.alpha = TINTCOLOR_ALPHA;
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    
    //用于说明的label
    UILabel *labIntroudction= [[UILabel alloc]init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(0,5,SCREEN_WIDTH,20);
    labIntroudction.numberOfLines=1;
    labIntroudction.font=[UIFont systemFontOfSize:15.0];
    labIntroudction.textAlignment=NSTextAlignmentCenter;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码对准方框，即可自动扫描";
    [downView addSubview:labIntroudction];
    
    UIView *darkView = [[UIView alloc]initWithFrame:CGRectMake(0, downView.frame.size.height-100.0,SCREEN_WIDTH,100.0)];
    darkView.backgroundColor = [UIColor clearColor];
    [downView addSubview:darkView];
    
    //用于开关灯操作的button
    
    _openButton=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2,SCREEN_HEIGHT-100,40, 40)];
    [_openButton setImage:[UIImage imageNamed:@"scan_light_up"] forState:UIControlStateNormal];
    [_openButton setImage:[UIImage imageNamed:@"scan_light_down"] forState:UIControlStateSelected];
    [_openButton addTarget:self action:@selector(openLight)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_openButton];
    
    //画中间的基准线
    _QrCodeline = [[UIImageView alloc]initWithFrame:CGRectMake(SCANVIEW_EdgeLeft,SCANVIEW_EdgeTop,SCREEN_WIDTH-2*SCANVIEW_EdgeLeft,2)];
    _QrCodeline.image = [UIImage imageNamed:@"scan3"];
    [self.view addSubview:_QrCodeline];
}

- (void)openLight {
    _openButton.selected = !_openButton.selected;
    if (_openButton.isSelected == YES) { //打开闪光灯
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
    }else{//关闭闪光灯
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            [device lockForConfiguration:nil];
            [device setTorchMode: AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
    }
}

//二维码的横线移动
- (void)moveUpAndDownLine
{
    CGFloat Y=_QrCodeline.frame.origin.y;
    if (SCANVIEW_EdgeTop==Y){
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        _QrCodeline.frame=CGRectMake(SCANVIEW_EdgeLeft, SCREEN_WIDTH-2*SCANVIEW_EdgeLeft+SCANVIEW_EdgeTop-2, SCREEN_WIDTH-2*SCANVIEW_EdgeLeft,2);
        [UIView commitAnimations];
    }else {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        _QrCodeline.frame=CGRectMake(SCANVIEW_EdgeLeft, SCANVIEW_EdgeTop, SCREEN_WIDTH-2*SCANVIEW_EdgeLeft,2);
        [UIView commitAnimations];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveUpAndDownLine) object:nil];
    [self performSelector:@selector(moveUpAndDownLine) withObject:nil afterDelay:2.0f];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [_session stopRunning];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveUpAndDownLine) object:nil];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        [self playBeep];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描成功" message:[NSString stringWithFormat:@"扫描结果为:%@",stringValue] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:cancelAction];
        UIAlertAction *againAction = [UIAlertAction actionWithTitle:@"重新扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_session startRunning];
            [self performSelector:@selector(moveUpAndDownLine) withObject:nil afterDelay:2.0f];
        }];
        [alert addAction:againAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)initAudio
{
    if(self.beep)
        return;
    NSError *error = nil;
    self.beep = [[AVAudioPlayer alloc]
            initWithContentsOfURL:
            [[NSBundle mainBundle]
             URLForResource: @"scan"
             withExtension: @"wav"]
            error: &error];
    if(!self.beep)
        NSLog(@"ERROR loading sound: %@: %@",
              [error localizedDescription],
              [error localizedFailureReason]);
    else {
        self.beep.volume = .5f;
        [self.beep prepareToPlay];
    }
}

- (void) playBeep
{
    if(!self.beep)
        [self initAudio];
    [self.beep play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_session stopRunning];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(moveUpAndDownLine) object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_session startRunning];
    [self performSelector:@selector(moveUpAndDownLine) withObject:nil afterDelay:2.0f];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
