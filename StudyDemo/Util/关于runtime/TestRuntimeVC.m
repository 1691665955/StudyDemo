//
//  TestRuntimeVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/17.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "TestRuntimeVC.h"
#import "TestRuntimeModel.h"
@interface TestRuntimeVC ()

@end

@implementation TestRuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于runtime";
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-40, 30)];
    lb.textColor = TipsColor;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:25];
    lb.text = @"具体用法请调试代码";
    [self.view addSubview:lb];
    
    //初始化模型，使用runtime字典转模型
    TestRuntimeModel *model = [[TestRuntimeModel alloc] initWithDictionary:@{@"name":@"张三",@"age":@"17",@"sex":@"男"}];
    
    NSLog(@"-----------打印属性列表------------");
    [model propertyList];
    
    NSLog(@"-----------打印方法列表------------");
    [model methodList];
    
    NSLog(@"-----------打印成员变量列表----------");
    [model ivarList];
    
    NSLog(@"-----------打印协议列表-----------");
    [model protocolList];
    
    NSLog(@"-------------访问私有属性----------");
    Ivar ivar = class_getInstanceVariable([model class], "_innerText");
    NSString *ivarValue = object_getIvar(model, ivar);
    NSLog(@"%@",ivarValue);
    
    NSLog(@"-------------本地化存储----------");
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:model] forKey:@"model"];
    TestRuntimeModel *mm = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"model"]];
    NSLog(@"%@",mm.name);
    
    NSLog(@"-------------动态添加属性----------");
    [model setExtraPropertyWithPropertyName:@"extraProperty1" perportyValue:@"我是变量一"];
    [model setExtraPropertyWithPropertyName:@"extraProperty2" perportyValue:@"我是变量二"];
    
    NSLog(@"%@",[model getExtraPropertyWithPropertyName:@"extraProperty1"]);
    NSLog(@"%@",[model getExtraPropertyWithPropertyName:@"extraProperty2"]);
    
    NSLog(@"-------------交换实例方法----------");
    NSLog(@"-------------交换前----------");
    [model goHome];
    [model gotoSchool];
    NSLog(@"-------------交换后----------");
    [model swapInstanceMethod:@selector(goHome) currentMethod:@selector(gotoSchool)];
    [model goHome];
    [model gotoSchool];
    
    NSLog(@"-------------交换类方法----------");
    NSLog(@"-------------交换前----------");
    [TestRuntimeModel swimming];
    [TestRuntimeModel sleep];
    NSLog(@"-------------交换后----------");
    [TestRuntimeModel swapClassMethod:@selector(swimming) currentMethod:@selector(sleep)];
    [TestRuntimeModel swimming];
    [TestRuntimeModel sleep];
}


@end
