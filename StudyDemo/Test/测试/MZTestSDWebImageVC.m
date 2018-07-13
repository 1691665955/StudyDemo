//
//  MZTestSDWebImageVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/12.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTestSDWebImageVC.h"
#import "MZTextField.h"
@interface MZTestSDWebImageVC ()

@end

@implementation MZTestSDWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    
    MZTextField *textField = [[MZTextField alloc] initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH-60, 50)];
    textField.backgroundColor = RGB(223, 223, 223);
    textField.maxTextLength = 15;
    textField.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:textField];
}

- (void)btnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
