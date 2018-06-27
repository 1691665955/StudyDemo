//
//  MZTabBar.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTabBar.h"

@interface MZTabBar()
@property (nonatomic, strong)UIButton *middleBtn;
@property (nonatomic, strong)UILabel *middleLB;
@end

@implementation MZTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Tabbar_Height)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        
        UIButton *middleBtn = [[UIButton alloc] init];
        [middleBtn addTarget:self action:@selector(middleBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [middleBtn setBackgroundImage:[UIImage imageNamed:@"menu3"] forState:UIControlStateNormal];
        [self addSubview:middleBtn];
        self.middleBtn = middleBtn;
        
        UILabel *middleLB = [[UILabel alloc] init];
        middleLB.textColor = RGB(102, 102, 102);
        middleLB.text = @"中间按钮";
        middleLB.textAlignment = NSTextAlignmentCenter;
        middleLB.font = [UIFont systemFontOfSize:11];
        self.middleLB = middleLB;
        [self addSubview:middleLB];
    }
    return self;
}

- (void)middleBtnDidClick {
    if (self.mzTabBarDelegate && [self.mzTabBarDelegate respondsToSelector:@selector(tabbarMiddleBtnDidClicked:)]) {
        [self.mzTabBarDelegate tabbarMiddleBtnDidClicked:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //这里的布局要根据实际情况，这里我加上中间按钮只有三个按钮
    self.middleBtn.frame = CGRectMake((SCREEN_WIDTH-50)/2, -20, 50, 50);
    self.middleLB.frame = CGRectMake((SCREEN_WIDTH-50)/2, 33, 50, 15);
    
    int btnIndex = 0;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            CGRect rect = btn.frame;
            rect.size.width = 80;
            if (btnIndex == 0) {
                rect.origin.x = 5;//tabbaritem位置偏左，原因未知，暂时处理是向右移5个单位
            } else {
                rect.origin.x = SCREEN_WIDTH-80;
            }
            btn.frame = rect;
            btn.tag = btnIndex;
            btnIndex++;
        }
    }
    [self bringSubviewToFront:self.middleBtn];
    [self bringSubviewToFront:self.middleLB];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newA = [self convertPoint:point toView:self.middleBtn];
        if ( [self.middleBtn pointInside:newA withEvent:event]) {
            return self.middleBtn;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
}

@end
