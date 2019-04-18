//
//  MZActionSheetController.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/11.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "MZActionSheetController.h"
#import "MZActionSheetDelegate.h"
@interface MZActionSheetController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) MZActionSheetDelegate *mzDelegate;
@end

@implementation MZActionSheetController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mzDelegate = [[MZActionSheetDelegate alloc] init];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.mzDelegate;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.mzDelegate = [[MZActionSheetDelegate alloc] init];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.mzDelegate;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mzDelegate = [[MZActionSheetDelegate alloc] init];
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.mzDelegate;
    }
    return self;
}
@end
