//
//  TestFitCell.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "TestFitCell.h"

@interface TestFitCell()
@property (nonatomic ,strong)UILabel *descLB;
@property (nonatomic ,strong)UIImageView *iconView;
@property (nonatomic ,strong)UILabel *titleLB;
@end

@implementation TestFitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconView.clipsToBounds = YES;
        [self addSubview:self.iconView];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, SCREEN_WIDTH-110, 20)];
        self.titleLB.font = [UIFont systemFontOfSize:16];
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        
        self.descLB = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, SCREEN_WIDTH-110, 20)];
        self.descLB.font = [UIFont systemFontOfSize:12];
        self.descLB.numberOfLines = 0;
        [self addSubview:self.descLB];
    }
    return self;
}

- (void)setModel:(TestFitModel *)model {
    _model = model;
    self.Height = 100;
    self.iconView.image = model.image;
    self.titleLB.text = model.title;
    CGSize maxSize = CGSizeMake(SCREEN_WIDTH-110, CGFLOAT_MAX);
    CGSize size1 = [self.titleLB sizeThatFits:maxSize];
    if (size1.height > 20) {
        self.titleLB.frame = CGRectMake(100, 10, SCREEN_WIDTH-110, size1.height);
    } else {
        self.titleLB.frame = CGRectMake(100, 10, SCREEN_WIDTH-110, 20);
    }
    
    self.descLB.text = model.desc;
    CGSize size2 = [self.descLB sizeThatFits:maxSize];
    if (size2.height > 20) {
        self.descLB.frame = CGRectMake(100, CGRectGetMaxY(self.titleLB.frame)+10, SCREEN_WIDTH-110, size2.height);
    } else {
        self.descLB.frame = CGRectMake(100, CGRectGetMaxY(self.titleLB.frame)+10, SCREEN_WIDTH-110, 20);
    }
    
    CGFloat height = CGRectGetMaxY(self.descLB.frame)+10;
    if (height > 100) {
        self.Height = height;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
