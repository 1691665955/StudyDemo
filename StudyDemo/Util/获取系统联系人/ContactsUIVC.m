//
//  ContactsUIVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "ContactsUIVC.h"
#import <ContactsUI/ContactsUI.h>
@interface ContactsUIVC ()<CNContactPickerDelegate>
@property (nonatomic, strong)CNContactPickerViewController *picker;
@property (nonatomic, strong)UILabel *nameLB;
@property (nonatomic, strong)UILabel *phoneNumberLB;
@end

@implementation ContactsUIVC

//该方式只有在iOS9之后才能使用
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择联系人";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)initUI {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"通讯录" style:UIBarButtonItemStylePlain target:self action:@selector(selectContact)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UILabel *nameTipLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 60, 30)];
    nameTipLB.text = @"姓名";
    nameTipLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameTipLB];
    
    UILabel *nameLB = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, SCREEN_WIDTH-100, 30)];
    nameLB.layer.borderColor = [UIColor grayColor].CGColor;
    nameLB.layer.borderWidth = 1;
    nameLB.layer.cornerRadius = 5;
    nameLB.layer.masksToBounds = YES;
    [self.view addSubview:nameLB];
    self.nameLB = nameLB;
    
    UILabel *phoneNumberTipLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 140, 60, 30)];
    phoneNumberTipLB.text = @"电话 ";
    phoneNumberTipLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneNumberTipLB];
    
    UILabel *phoneNumberLB = [[UILabel alloc] initWithFrame:CGRectMake(80, 140, SCREEN_WIDTH-100, 30)];
    phoneNumberLB.layer.borderColor = [UIColor grayColor].CGColor;
    phoneNumberLB.layer.borderWidth = 1;
    phoneNumberLB.layer.cornerRadius = 5;
    phoneNumberLB.layer.masksToBounds = YES;
    [self.view addSubview:phoneNumberLB];
    self.phoneNumberLB = phoneNumberLB;
}

- (void)selectContact {
    if (!self.picker) {
        self.picker = [[CNContactPickerViewController alloc] init];
        self.picker.delegate = self;
    }
    if (self.picker) {
        [self presentViewController:self.picker animated:YES completion:nil];
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(nonnull CNContact *)contact {
    //联系人姓名
    NSString *lastName = contact.familyName;
    NSString *firstName = contact.givenName;
    self.nameLB.text = [NSString stringWithFormat:@"  %@%@",lastName,firstName];
    
    //联系人电话
    NSArray *phoneNums = contact.phoneNumbers;
    if (phoneNums.count > 0) {
        //联系人可能有多个电话，我们这里指显示一个作为演示
        CNLabeledValue *labeledValue = phoneNums[0];
        CNPhoneNumber *phoneNumber = labeledValue.value;
        NSString *phoneStr = phoneNumber.stringValue;
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
        self.phoneNumberLB.text = [NSString stringWithFormat:@"  %@",[[phoneStr componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
