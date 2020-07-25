//
//  MZCollectionImageCell.h
//  StudyDemo
//
//  Created by 曾龙 on 2020/7/25.
//  Copyright © 2020 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MZCollectionImageCell : UICollectionViewCell
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, weak, readonly) UIImageView *iconView;
@end

NS_ASSUME_NONNULL_END
