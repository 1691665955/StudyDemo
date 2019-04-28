//
//  CustomFontVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/18.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "CustomFontVC.h"

@interface CustomFontVC ()

@end

@implementation CustomFontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"导入自定义字体";
    
    for (NSString *fontFamilyName in [UIFont familyNames]) {
        NSLog(@"family:'%@'\n",fontFamilyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
            NSLog(@"\tfont:'%@'\n",fontName);
        }
        NSLog(@"-------------\n");
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 50)];
    label.text = @"asdff443434";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"LetsgoDigital-Regular" size:40];
    //PartyLetPlain  AcademyEngravedLetPlain  SavoyeLetPlain
    [self.view addSubview:label];
}

@end
