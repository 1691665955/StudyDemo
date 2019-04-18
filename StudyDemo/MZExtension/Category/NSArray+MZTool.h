//
//  NSArray+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2019/1/15.
//  Copyright © 2019年 曾龙. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSArray (MZTool)

/**
 获取数组中的最大值数组

 @param callback maxArray:最大数组 startIndex:最大数组起始下标 endIndex:最大数组结束下标
 */
- (void)caculateMaxArray:(void(^)(NSArray *maxArray,NSInteger startIndex,NSInteger endIndex))callback;
@end

NS_ASSUME_NONNULL_END
