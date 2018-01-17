//
//  WaterFlowTestCell.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "WaterFlowTestCell.h"

@implementation WaterFlowTestCell

- (void)setModel:(WaterFlowModel *)model {
    _model = model;
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.priceLB.text = model.price;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
