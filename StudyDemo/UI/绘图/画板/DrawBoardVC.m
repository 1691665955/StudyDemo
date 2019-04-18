//
//  DrawBoardVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/18.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "DrawBoardVC.h"
#import "MZDrawBoardView.h"

@interface DrawBoardVC ()
@property (nonatomic, strong) MZDrawBoardView *boardView;
@property (nonatomic, strong) UIImageView *saveView;
@end

@implementation DrawBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"画板";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStyleDone target:self action:@selector(clear)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem2];
    
    MZDrawBoardView *view = [[MZDrawBoardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.layer.borderColor = RGB(223, 223, 223).CGColor;
    view.layer.borderWidth = 0.5;
    view.lineWidth = 2;
    view.fillColor = RGB(90, 160, 245);
    [self.view addSubview:view];
    self.boardView = view;
    
    UIImageView *saveView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 200)];
    saveView.layer.borderColor = RGB(223, 223, 223).CGColor;
    saveView.layer.borderWidth = 0.5;
    [self.view addSubview:saveView];
    self.saveView = saveView;
}

- (void)clear {
    [self.boardView clear];
}

- (void)save {
    self.saveView.image = [self.boardView getImage];
}

@end
