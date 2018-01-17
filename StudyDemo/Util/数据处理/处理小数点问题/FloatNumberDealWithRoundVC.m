//
//  FloatNumberDealWithRoundVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "FloatNumberDealWithRoundVC.h"

@interface FloatNumberDealWithRoundVC ()<UITextFieldDelegate>
@property (nonatomic ,strong)UITextField *textField;
@end

@implementation FloatNumberDealWithRoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"处理小数点问题";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *tipLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
    tipLB.text = @"请输入小数";
    tipLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLB];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH-60, 40)];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.delegate = self;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.view addSubview:textField];
    self.textField = textField;
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    createBtn.frame = CGRectMake(50, CGRectGetMaxY(textField.frame)+20, SCREEN_WIDTH-100, 40);
    createBtn.backgroundColor = [UIColor colorWithRed:90/255.0 green:160/255.0 blue:245/255.0 alpha:1];
    [createBtn setTitle:@"进行小数点处理" forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(dealWithNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createBtn];
    
    for (int i=0; i<4; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(createBtn.frame)+30+50*i, SCREEN_WIDTH-20, 40)];
        lb.tag = 100+i;
        lb.adjustsFontSizeToFitWidth = YES;
        lb.numberOfLines = 0;
        [self.view addSubview:lb];
    }
}

- (void)dealWithNumber {
    if (self.textField.text.length == 0) {
        [MBProgressHUD showError:@"请输入小数"];
        return;
    }
    [self.view endEditing:YES];
    
    //保留两位小数，四舍五入
    CGFloat round1 = round(self.textField.text.floatValue*100)/100;
    UILabel *lb1 = [self.view viewWithTag:100];
    lb1.text = [NSString stringWithFormat:@"保留两位小数，四舍五入:\n%.2lf",round1];
    
    //保留两位小数，直接进1
    CGFloat round2 = ceilf(self.textField.text.floatValue*100)/100;
    UILabel *lb2 = [self.view viewWithTag:101];
    lb2.text = [NSString stringWithFormat:@"保留两位小数，直接进一:\n%.2lf",round2];
    
    //保留两位小数，舍弃后面的尾数
    CGFloat round3 = floor(self.textField.text.floatValue*100)/100;
    UILabel *lb3 = [self.view viewWithTag:102];
    lb3.text = [NSString stringWithFormat:@"保留两位小数，舍弃后面的尾数:\n%.2lf",round3];
    
    //四舍五入后处理小数点后无效的0
    UILabel *lb4 = [self.view viewWithTag:103];
    lb4.text = [NSString stringWithFormat:@"四舍五入后处理小数点后无效的零:\n%@",[self deleteTheUnuseZero:[NSString stringWithFormat:@"%.2lf",round1]]];
}


- (NSString *)deleteTheUnuseZero:(NSString *)string {
    if ([string hasSuffix:@".00"]) {
        return [string substringToIndex:string.length-3];
    } else if ([string hasSuffix:@"0"]) {
        return [string substringToIndex:string.length-1];
    }
    return string;
}


#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
