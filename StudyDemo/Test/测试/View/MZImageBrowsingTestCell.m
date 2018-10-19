//
//  MZImageBrowsingTestCell.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/10/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZImageBrowsingTestCell.h"

@interface MZImageBrowsingTestCell()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;

@end

@implementation MZImageBrowsingTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = self.imageArray[i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImageView:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)loadImageViews {
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = self.imageArray[i];
        NSInteger random = arc4random()%4;
        switch (random) {
            case 0:
                imageView.image = [UIImage imageNamed:@"111"];
                break;
            case 1:
                imageView.image = [UIImage imageNamed:@"222"];
                break;
            case 2:
                imageView.image = [UIImage imageNamed:@"333"];
                break;
            case 3:
                imageView.image = [UIImage imageNamed:@"444"];
                break;
            default:
                break;
        }
    }
}

- (void)selectImageView:(UITapGestureRecognizer *)sender {
    if (self.previewImage) {
        self.previewImage(self.imageArray, sender.view.tag-100);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
