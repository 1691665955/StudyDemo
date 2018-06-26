//
//  MZNavigationController.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/11.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZNavigationController.h"

@interface MZNavigationController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UIViewController *viewController;

@end

@implementation MZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor whiteColor];
    [bar setBackgroundImage:[UIImage getImageWithColor:RGB(26, 126, 248)] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (navigationController.viewControllers.count > 1 || navigationController.parentViewController) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        [btn setImage:[UIImage imageNamed:@"btn_返回_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"btn_返回_p"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(leftBarItemClicked) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        if (navigationController.viewControllers.count > 1) {
            self.viewController = viewController;
        }
    }
}

- (void)leftBarItemClicked {
    [self.view endEditing:YES];
    if (self.viewControllers.count>1) {
        if ([self.viewControllers objectAtIndex:self.viewControllers.count-1] == self.viewController) {
            //如果是push过来的
            [self popViewControllerAnimated:YES];
        }
    } else {
        //如果是present过来的
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
