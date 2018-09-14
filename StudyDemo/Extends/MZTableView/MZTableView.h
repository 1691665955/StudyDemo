//
//  MZTableView.h
//  customTable
//
//  Created by 曾龙 on 2018/7/26.
//  Copyright © 2018年 mz. All rights reserved.
//

//横向tableView

#import <UIKit/UIKit.h>
@class MZTableView;
@protocol MZTableViewDelegate<NSObject>
@required
//tableView列数
- (NSInteger)numberOfColumnsInTableView:(MZTableView *)tableView;
//column列对应的cell
- (UIView *)tableView:(MZTableView *)tableView cellForColumn:(NSInteger)column;
//column列的宽度
- (CGFloat)tableView:(MZTableView *)tableView widthForColumn:(NSInteger)column;

@optional
//column列被点击了
- (void)tableView:(MZTableView *)tableView didSelectedColumn:(NSInteger)column;
@end

@interface MZTableView : UIView
@property (nonatomic, weak) id<MZTableViewDelegate> delegate;
//注册nib,实现cell复用功能
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;
//注册class,实现cell复用功能
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
//通过已组册的identifier来获取cell
- (UIView *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
//刷新数据，本控件必须得刷新控件才会有数据
- (void)reloadData;
@end
