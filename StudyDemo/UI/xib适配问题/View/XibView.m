//
//  XibView.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/2.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "XibView.h"

@interface XibView()
@property (nonatomic ,assign)CGRect myFrame;
@end

@implementation XibView
//为什么要这样加载，如果不重置frame，当view添加到self.view时不能很好适配
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"XibView" owner:self options:nil] lastObject];
        self.myFrame = frame;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.frame = self.myFrame;
}

@end
