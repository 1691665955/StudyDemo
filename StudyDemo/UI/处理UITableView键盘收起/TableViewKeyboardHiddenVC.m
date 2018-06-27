//
//  TableViewKeyboardHiddenVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "TableViewKeyboardHiddenVC.h"

@interface TableViewKeyboardHiddenVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewKeyboardHiddenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"处理UITableView键盘收起";
    /*方式一*/
//    UITapGestureRecognizer *tableViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
//    tableViewTap.cancelsTouchesInView = NO;
//    [self.tableView addGestureRecognizer:tableViewTap];
    
    /*方式二*/
    /*
     UIScrollViewKeyboardDismissModeOnDrag,//键盘会当tableView上下滚动的时候自动收起
     UIScrollViewKeyboardDismissModeInteractive, //tableView向下滑并当手指触碰到键盘时，键盘会收起
     */
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)endEdit {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor grayColor];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH-80, 30)];
    textField.backgroundColor = [UIColor whiteColor];
    [textField becomeFirstResponder];
    [cell addSubview:textField];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


@end
