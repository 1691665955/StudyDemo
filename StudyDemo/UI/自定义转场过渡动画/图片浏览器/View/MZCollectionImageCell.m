//
//  MZCollectionImageCell.m
//  StudyDemo
//
//  Created by 曾龙 on 2020/7/25.
//  Copyright © 2020 曾龙. All rights reserved.
//

#import "MZCollectionImageCell.h"

@interface MZCollectionImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation MZCollectionImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

@end
