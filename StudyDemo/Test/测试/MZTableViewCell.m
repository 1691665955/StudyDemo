//
//  MZTableViewCell.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/22.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "MZTableViewCell.h"

@interface MZTableViewCell ()
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation MZTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.iconView = [[UIImageView alloc] init];
        [self addSubview:self.iconView];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.iconView.image = [UIImage imageNamed:imageName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = self.bounds;
}

@end
