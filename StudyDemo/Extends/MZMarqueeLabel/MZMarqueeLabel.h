//
//  MZMarqueeLabel.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/9/14.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,MZMarqueeDirection) {
    MZMarqueeDirectionDefault,
    MZMarqueeDirectionRightToLeft,
    MZMarqueeDirectionLeftToRight
};
@interface MZMarqueeLabel : UIView
- (void)setupText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment direction:(MZMarqueeDirection)direction whiteSpace:(NSString *)whiteSpace;
@end
