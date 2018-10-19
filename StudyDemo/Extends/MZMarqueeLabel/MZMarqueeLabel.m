//
//  MZMarqueeLabel.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/9/14.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZMarqueeLabel.h"

@interface MZMarqueeLabel()
@property (nonatomic, strong) UILabel *firstLB;
@property (nonatomic, strong) UILabel *lastLB;
@end

@implementation MZMarqueeLabel
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.clipsToBounds = YES;
}

- (void)setupText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment direction:(MZMarqueeDirection)direction whiteSpace:(NSString *)whiteSpace speed:(MZMarqueeSpeed)speed {
    if (self.firstLB) {
        [self.firstLB removeFromSuperview];
        [self.lastLB removeFromSuperview];
    }
    
    self.firstLB = [[UILabel alloc] init];
    self.firstLB.backgroundColor = [UIColor clearColor];
    self.firstLB.text = [NSString stringWithFormat:@"%@%@",text,whiteSpace?whiteSpace:@"    "];
    self.firstLB.font = font;
    self.firstLB.textColor = textColor;
    self.firstLB.textAlignment = textAlignment;
    [self addSubview:self.firstLB];
    
    self.lastLB = [[UILabel alloc] init];
    self.lastLB.backgroundColor = [UIColor clearColor];
    self.lastLB.text = [NSString stringWithFormat:@"%@%@",text,whiteSpace?whiteSpace:@"    "];
    self.lastLB.font = font;
    self.lastLB.textColor = textColor;
    self.lastLB.textAlignment = textAlignment;
    [self addSubview:self.lastLB];
    
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, self.frame.size.height);
    CGSize size1 = [self.firstLB sizeThatFits:maxSize];
    CGSize size2 = [self.lastLB sizeThatFits:maxSize];
    if (size1.width > self.frame.size.width) {
        if (direction == MZMarqueeDirectionLeftToRight) {
            self.firstLB.frame = CGRectMake(self.frame.size.width-size1.width, 0, size1.width, self.frame.size.height);
            self.lastLB.frame = CGRectMake(self.frame.size.width-size1.width-size2.width, 0, size2.width, self.frame.size.height);
        } else {
            self.firstLB.frame = CGRectMake(0, 0, size1.width, self.frame.size.height);
            self.lastLB.frame = CGRectMake(size1.width, 0, size2.width, self.frame.size.height);
        }
        [self updateLabelFrameWithDirection:direction duration:text.length/speed];
    } else {
        self.firstLB.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.lastLB.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    }
}

- (void)updateLabelFrameWithDirection:(MZMarqueeDirection)direction duration:(NSTimeInterval)duration{
    [UIView transitionWithView:self duration:duration options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame1 = self.firstLB.frame;
        CGRect frame2 = self.lastLB.frame;
        if (direction == MZMarqueeDirectionLeftToRight) {
            frame1.origin.x = frame1.origin.x+(frame1.size.width+frame2.size.width)*0.5;
            self.firstLB.frame = frame1;
            frame2.origin.x = frame2.origin.x+(frame1.size.width+frame2.size.width)*0.5;
            self.lastLB.frame = frame2;
        } else {
            frame1.origin.x = frame1.origin.x-(frame1.size.width+frame2.size.width)*0.5;
            self.firstLB.frame = frame1;
            frame2.origin.x = frame2.origin.x-(frame1.size.width+frame2.size.width)*0.5;
            self.lastLB.frame = frame2;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            if (direction == MZMarqueeDirectionLeftToRight) {
                if (CGRectGetMinX(self.firstLB.frame) >= self.frame.size.width) {
                    self.firstLB.frame = CGRectMake(CGRectGetMinX(self.lastLB.frame)-self.firstLB.frame.size.width, 0, self.firstLB.frame.size.width, self.firstLB.frame.size.height);
                } else if (CGRectGetMinX(self.lastLB.frame) >= self.frame.size.width) {
                    self.lastLB.frame = CGRectMake(CGRectGetMinX(self.firstLB.frame)-self.lastLB.frame.size.width, 0, self.lastLB.frame.size.width, self.lastLB.frame.size.height);
                }
                [self updateLabelFrameWithDirection:direction duration:duration];
            } else {
                if (CGRectGetMaxX(self.firstLB.frame) <= 0) {
                    self.firstLB.frame = CGRectMake(CGRectGetMaxX(self.lastLB.frame), 0, self.firstLB.frame.size.width, self.firstLB.frame.size.height);
                } else if (CGRectGetMaxX(self.lastLB.frame) <= 0) {
                    self.lastLB.frame = CGRectMake(CGRectGetMaxX(self.firstLB.frame), 0, self.lastLB.frame.size.width, self.lastLB.frame.size.height);
                }
                [self updateLabelFrameWithDirection:direction duration:duration];
            }
        }
    }];
}

@end
