//
//  MZImageBrowsingVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/10/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZImageBrowsingVC.h"
#import "MZPresentAnimationTransitioning.h"

#define SCREEN_WIDTH_1     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_1    [UIScreen mainScreen].bounds.size.height

@interface MZImageBrowsingVC ()<UIViewControllerTransitioningDelegate,UIScrollViewDelegate>
@property (copy, nonatomic) NSArray *imageViewArray;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIScrollView *imageScrollView;
@property (strong, nonatomic) UIImageView *showImageView;
@property (strong, nonatomic) UIImageView *currentImageView;
@end

@implementation MZImageBrowsingVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (instancetype)initWithImageViewArray:(NSArray *)imageViewArray currentIndex:(NSInteger)currentIndex {
    self = [self init];
    if (self) {
        self.imageViewArray = imageViewArray;
        self.currentIndex = currentIndex;
        self.currentImageView = self.imageViewArray[self.currentIndex];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.imageScrollView];
    
    if (@available(iOS 11.0, *)) {
        self.imageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    for (int i = 0; i < self.imageViewArray.count; i++) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH_1+20)*i, 0, SCREEN_WIDTH_1, SCREEN_HEIGHT_1)];
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH_1, SCREEN_HEIGHT_1);
        [self.imageScrollView addSubview:scrollView];
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_1, SCREEN_HEIGHT_1)];
        containerView.userInteractionEnabled = YES;
        [scrollView addSubview:containerView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
        [containerView addGestureRecognizer:tap];
        
        UIImageView *tempImageView = self.imageViewArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_1, SCREEN_WIDTH_1*tempImageView.image.size.height/tempImageView.image.size.width)];
        if (CGRectGetHeight(imageView.frame) <= SCREEN_HEIGHT_1) {
            imageView.center = CGPointMake(SCREEN_WIDTH_1/2, SCREEN_HEIGHT_1/2);
            scrollView.contentSize = CGSizeMake(SCREEN_WIDTH_1, SCREEN_HEIGHT_1);
        } else {
            CGRect frame = containerView.frame;
            frame.size.height = CGRectGetHeight(imageView.frame);
            containerView.frame = frame;
             scrollView.contentSize = CGSizeMake(SCREEN_WIDTH_1, CGRectGetHeight(imageView.frame));
        }
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = tempImageView.image;
        [containerView addSubview:imageView];
        
        if (i == self.currentIndex) {
            self.showImageView.image = tempImageView.image;
            [self.showImageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH_1, SCREEN_WIDTH_1*tempImageView.image.size.height/tempImageView.image.size.width)];
            self.showImageView.center = self.view.center;
        }
    }
    
    [self.imageScrollView setContentOffset:CGPointMake((20+SCREEN_WIDTH_1)*self.currentIndex, 0)];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIScrollView *)imageScrollView {
    if (_imageScrollView) {
        return _imageScrollView;
    }
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_1+20, SCREEN_HEIGHT_1)];
    _imageScrollView.delegate = self;
    _imageScrollView.delaysContentTouches = YES;
    _imageScrollView.canCancelContentTouches = NO;
    _imageScrollView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    _imageScrollView.contentSize = CGSizeMake((20 + SCREEN_WIDTH_1) * self.imageViewArray.count, SCREEN_HEIGHT_1);
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.directionalLockEnabled = YES;
    return _imageScrollView;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [MZPresentAnimationTransitioning transitionWithTransitionType:MZPresentAnimationTransitioningTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [MZPresentAnimationTransitioning transitionWithTransitionType:MZPresentAnimationTransitioningTypeDismiss];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x/(SCREEN_WIDTH_1 + 20);
    UIImageView *tempImageView = self.imageViewArray[self.currentIndex];
    self.currentImageView = tempImageView;
    self.showImageView.image = tempImageView.image;
    [self.showImageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH_1, SCREEN_WIDTH_1 * tempImageView.image.size.height / tempImageView.image.size.width)];
    self.showImageView.center = self.view.center;
}

- (UIImageView *)showImageView {
    if (_showImageView) {
        return _showImageView;
    }
    _showImageView = [UIImageView new];
    _showImageView.clipsToBounds = YES;
    _showImageView.contentMode = UIViewContentModeScaleAspectFill;
    return _showImageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    statusBar.alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    statusBar.alpha = 1;
}
@end
