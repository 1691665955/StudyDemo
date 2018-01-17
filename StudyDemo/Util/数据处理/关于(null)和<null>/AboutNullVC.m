//
//  AboutNullVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "AboutNullVC.h"

@interface AboutNullVC ()

@end

@implementation AboutNullVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于(null)和<null>";
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 100)];
    lb.text = @"在开发过程中，后台传过来的数据打印时，数据为空可能打印显示\"(null)\"和\"<null>\"，但是这两种情况作判断为空时所用方法是不同的";
    lb.numberOfLines = 0;
    [self.view addSubview:lb];
    
    UILabel *descLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 130, SCREEN_WIDTH-30, 300)];
    NSMutableAttributedString *desc = [[NSMutableAttributedString alloc] initWithString:@"1.打印显示为(null)时，用nil去判断\n\nNSObject *object1 = nil;\nNSLog(@\"%@\",object1);\n结果为:(null)\n\n2.打印显示为<null>时，用[NSNull null]去判断\n\nNSObject *object2 = [NSNull null];\nNSLog(@\"%@\",object2);\n结果为:<null>"];
    [desc setAttributes:@{NSForegroundColorAttributeName:TipsColor} range:NSMakeRange(0, 22)];
    [desc setAttributes:@{NSForegroundColorAttributeName:TipsColor} range:NSMakeRange(81, 34)];
    descLB.attributedText = desc;
    descLB.numberOfLines = 0;
    [self.view addSubview:descLB];
    
    //1.打印显示为(null)时，用nil去判断
    NSObject *object1 = nil;
    NSLog(@"%@",object1);
    
    //2.打印显示为<null>时，用[NSNull null]去判断
    NSObject *object2 = [NSNull null];
    NSLog(@"%@",object2);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
