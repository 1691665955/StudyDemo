//
//  MZPresentAnimationTransitioning.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/10/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,MZPresentAnimationTransitioningType) {
    MZPresentAnimationTransitioningTypePresent,
    MZPresentAnimationTransitioningTypeDismiss
};

@interface MZPresentAnimationTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)transitionWithTransitionType:(MZPresentAnimationTransitioningType)type;
- (instancetype)initWithTransitionType:(MZPresentAnimationTransitioningType)type;
@end
