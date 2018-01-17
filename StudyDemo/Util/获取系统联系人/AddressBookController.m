//
//  AddressBookController.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "AddressBookController.h"
#import <AddressBook/AddressBook.h>
#import "MZContactModel.h"
@interface AddressBookController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *contacts;
@end

@implementation AddressBookController

- (NSMutableArray *)contacts {
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"通讯录";
    [self setupTableView];
    [self getContacts];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(self.tableView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

//获取联系人信息
- (void)getContacts {
    int __block tip = 0;
    CFErrorRef error = NULL;
    ABAddressBookRef adressBook = ABAddressBookCreateWithOptions(NULL, &error);
    //创建一个初始信号量为0的信号
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //申请访问权限
    ABAddressBookRequestAccessWithCompletion(adressBook, ^(bool granted, CFErrorRef error){
        if (!granted) {
            tip = 1;
        }
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (tip) {
        [MBProgressHUD showError:@"请您设置允许APP访问您的通讯录"];
        return;
    }
    
    //获取所有联系人的数组
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(adressBook);
    //遍历所有的联系人
    CFIndex peopleCount = CFArrayGetCount(allPeople);
    //如果没有联系人
    if (!peopleCount) {
        NSLog(@"没有任何联系人");
        [self.tableView reloadData];
        return;
    }
    
    for (NSInteger index=0; index < peopleCount; index++) {
        //联系人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, index);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName !=nil) {
            nameString = (__bridge NSString *)abFullName;
        }else{
            if ((__bridge id)abLastName != nil) {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        
        //        ABRecordID  recordIDs = ABRecordGetRecordID(person);
        //获取联系人电话(一个联系人可能存在多个电话)
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSArray *phoneNumbers =  ((__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(phones));
        for (NSInteger index = 0; index < phoneNumbers.count; index++) {
            NSString *phoneNumber = phoneNumbers[index];
            if ([phoneNumber hasPrefix:@"+86 "]) {
                phoneNumber = [phoneNumber substringFromIndex:4];
            }
            if ([phoneNumber hasPrefix:@"+86"]) {
                phoneNumber = [phoneNumber substringFromIndex:3];
            }
            phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
            MZContactModel *model = [[MZContactModel alloc] init];
            model.name = nameString;
            model.phoneNumber = phoneNumber;
            [self.contacts addObject:model];
        }
        
        CFRelease(phones);
    }
    CFRelease(adressBook);
    CFRelease(allPeople);
    //C语言部分需要手动释放内存
    [self.tableView reloadData];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MZContactModel *model = self.contacts[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.phoneNumber;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
