//
//  MZOtherImageCell.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/11/26.
//  Copyright © 2019 曾龙. All rights reserved.
//

#import "MZOtherImageCell.h"

@interface MZOtherImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation MZOtherImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
