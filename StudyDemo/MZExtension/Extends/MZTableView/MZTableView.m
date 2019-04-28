//
//  MZTableView.m
//  customTable
//
//  Created by 曾龙 on 2018/7/26.
//  Copyright © 2018年 mz. All rights reserved.
//

#import "MZTableView.h"

@interface MZTableView()<UIScrollViewDelegate>
{
    NSInteger _extraVisibleCount;
}
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) NSMutableArray<UIView *> *visibleCellArray;
@property (nonatomic, strong) NSMutableArray<UIView *> *unVisibleCellArray;
@property (nonatomic, strong) NSMutableDictionary *registerDictionary;
@property (nonatomic, strong) NSMutableDictionary *nibForClassDictionary;
@end

@implementation MZTableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.contentView.bounces = NO;
    self.contentView.delegate = self;
    [self addSubview:self.contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    for (UIView *cell in self.contentView.subviews) {
        CGRect frame = cell.frame;
        frame.size.height = self.bounds.size.height;
        cell.frame = frame;
    }
}

- (NSMutableDictionary *)registerDictionary {
    if (!_registerDictionary) {
        _registerDictionary = [NSMutableDictionary dictionary];
    }
    return _registerDictionary;
}

- (NSMutableDictionary *)nibForClassDictionary {
    if (!_nibForClassDictionary) {
        _nibForClassDictionary = [NSMutableDictionary dictionary];
    }
    return _nibForClassDictionary;
}

//可见cell数组，已添加到scrollview中的cell
- (NSMutableArray<UIView *> *)visibleCellArray {
    if (!_visibleCellArray) {
        _visibleCellArray = [NSMutableArray array];
    }
    return _visibleCellArray;
}

//不可见cell数组，类似复用池的功能
- (NSMutableArray<UIView *> *)unVisibleCellArray {
    if (!_unVisibleCellArray) {
        _unVisibleCellArray = [NSMutableArray array];
    }
    return _unVisibleCellArray;
}

//额外可见cell个数，用来适配scrollview滚动时cell显示的连续性
- (NSInteger)extraVisibleCount {
    _extraVisibleCount = (NSInteger)(self.frame.size.width/2/[self getMinWithFormCells]+1);
    if (_extraVisibleCount < 2) {
        _extraVisibleCount = 2;
    }
    return _extraVisibleCount;
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [self.registerDictionary setObject:nib forKey:identifier];
    Class class = [[[nib instantiateWithOwner:nib options:nil] firstObject] class];
    [self.nibForClassDictionary setObject:class forKey:identifier];
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.registerDictionary setObject:cellClass forKey:identifier];
}

//从已注册的的class或xib中获取cell，如果identifier为空或是未注册的，则返回一个新新定义view
- (UIView *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    if (!identifier) {
        return [[UIView alloc] init];
    }
    NSObject *object = [self.registerDictionary objectForKey:identifier];
    if (object == nil) {
        return [[UIView alloc] init];
    }
    if ([object isKindOfClass:[UINib class]]) {
        UIView *cell;
        for (int i = 0; i < self.unVisibleCellArray.count; i++) {
            UIView *unVisibleCell = self.unVisibleCellArray[i];
            if ([unVisibleCell isKindOfClass:[self.nibForClassDictionary objectForKey:identifier]]) {
                cell = unVisibleCell;
                [self.unVisibleCellArray removeObject:unVisibleCell];
                break;
            }
        }
        if (!cell) {
            UINib *nib = (UINib *)object;
            cell = [[nib instantiateWithOwner:nib options:nil] firstObject];
        }
        return cell;
    } else {
        UIView *cell;
        for (int i = 0; i < self.unVisibleCellArray.count; i++) {
            UIView *unVisibleCell = self.unVisibleCellArray[i];
            if ([unVisibleCell isKindOfClass:[self.registerDictionary objectForKey:identifier]]) {
                cell = unVisibleCell;
                [self.unVisibleCellArray removeObject:unVisibleCell];
                break;
            }
        }
        if (!cell) {
            Class class = (Class)object;
            cell = [[class alloc] init];
        }
        return cell;
    }
}

//重新加载数据
- (void)reloadData {
    [self.contentView setContentOffset:CGPointMake(0, 0)];
    
    CGFloat width = 0;
    for (NSInteger i = 0; i < [self.delegate numberOfColumnsInTableView:self]; i++) {
        width += [self.delegate tableView:self widthForColumn:i];
        if (width <= self.frame.size.width) {
            UIView *cell = [self.delegate tableView:self cellForColumn:i];
            [self setupTapGesture:cell];
            cell.frame = CGRectMake(width-[self.delegate tableView:self widthForColumn:i], 0, [self.delegate tableView:self widthForColumn:i], self.frame.size.height);
            [self.contentView addSubview:cell];
            [self.visibleCellArray addObject:cell];
            if (i < [self.delegate numberOfColumnsInTableView:self]-1) {
                if (width+[self.delegate tableView:self widthForColumn:i+1] > self.frame.size.width) {
                    UIView *cell = [self.delegate tableView:self cellForColumn:i+1];
                    [self setupTapGesture:cell];
                    cell.frame = CGRectMake(width, 0, [self.delegate tableView:self widthForColumn:i+1], self.frame.size.height);
                    [self.contentView addSubview:cell];
                    [self.visibleCellArray insertObject:cell atIndex:i+1];
                }
            }
        }
    }
    self.contentView.contentSize = CGSizeMake(width, 0);
    NSLog(@"cell对象个数:%ld",self.visibleCellArray.count+self.unVisibleCellArray.count);
}

- (void)setupTapGesture:(UIView *)cell {
    //如果cell未添加过点击事件，则给cell添加点击事件
    if (cell.gestureRecognizers.count == 0) {
        cell.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
        [cell addGestureRecognizer:tap];
    }
}

//cell点击事件
- (void)tapClicked:(UITapGestureRecognizer *)tap {
    UIView *cell = tap.view;
    NSInteger column = [self getColumnFromCell:cell];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectedColumn:)]) {
        [self.delegate tableView:self didSelectedColumn:column];
    }
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    [self updateUIWithContentOffset:offset];
}

//根据scrollview的偏移量来更新UI
- (void)updateUIWithContentOffset:(CGPoint)offset {
    if (self.visibleCellArray.count > 0) {
        //如果左边被覆盖的cell个数小于额外可见数，则添加不足的cell到scrollview中，并添加到visibleCellArray中，如果cell是从unVisibleCellArray中取出，则把cell从unVisibleCellArray中移除
        UIView *firstCell = self.visibleCellArray.firstObject;
        NSInteger first = [self getFirstColumnFromContentOffsetX:offset.x];
        if (first >= 0 && first <= [self getColumnFromCell:firstCell]) {
            for (NSInteger i = [self getColumnFromCell:firstCell]-1; i>=(first-[self extraVisibleCount] >=0?first-[self extraVisibleCount]:0); i--) {
                UIView *cell = [self.delegate tableView:self cellForColumn:i];
                [self setupTapGesture:cell];
                cell.frame = CGRectMake([self getOriginXFormCellColumn:i], 0, [self.delegate tableView:self widthForColumn:i], self.frame.size.height);
                [self.contentView addSubview:cell];
                [self.visibleCellArray insertObject:cell atIndex:0];
                [self.unVisibleCellArray removeObject:cell];
            }
        }
        
        //如果右边被覆盖的cell个数小于额外可见数，则添加不足的cell到scrollview中，并添加到visibleCellArray中，如果cell是从unVisibleCellArray中取出，则把cell从unVisibleCellArray中移除
        UIView *lastCell = self.visibleCellArray.lastObject;
        NSInteger last = [self getLastColumnFromContentOffsetX:offset.x];
        if (last <= [self.delegate numberOfColumnsInTableView:self]-1 && last >= [self getColumnFromCell:lastCell]) {
            for (NSInteger i = [self getColumnFromCell:lastCell]+1; i <= (last+[self extraVisibleCount] < [self.delegate numberOfColumnsInTableView:self]?last+[self extraVisibleCount]:[self.delegate numberOfColumnsInTableView:self]-1); i++) {
                UIView *cell = [self.delegate tableView:self cellForColumn:i];
                [self setupTapGesture:cell];
                cell.frame = CGRectMake([self getOriginXFormCellColumn:i], 0, [self.delegate tableView:self widthForColumn:i], self.frame.size.height);
                [self.contentView addSubview:cell];
                [self.visibleCellArray addObject:cell];
                [self.unVisibleCellArray removeObject:cell];
            }
        }
    }
    
    if (self.visibleCellArray.count >= [self extraVisibleCount]) {
        //如果左边被覆盖的cell个数超过额外可见数，则从scrollview中移除超过的cell，从visibleCellArray中移除该对象，并将该对象添加到unVisibleCellArray
        for (NSInteger i = [self extraVisibleCount]-1; i < self.visibleCellArray.count; i++) {
            UIView *cell = self.visibleCellArray[i];
            if (CGRectGetMinX(cell.frame)<offset.x) {
                UIView *unVisibleCell = self.visibleCellArray[i-([self extraVisibleCount]-1)];
                [unVisibleCell removeFromSuperview];
                [self.unVisibleCellArray addObject:unVisibleCell];
                [self.visibleCellArray removeObjectAtIndex:i-([self extraVisibleCount]-1)];
                i--;
            }
        }
    }
    
    if (self.visibleCellArray.count > [self extraVisibleCount]) {
        //如果右边被覆盖的cell个数超过额外可见数，则从scrollview中移除超过的cell，从visibleCellArray中移除该对象，并将该对象添加到unVisibleCellArray
        for (NSInteger i = self.visibleCellArray.count-[self extraVisibleCount]; i >= 0; i--) {
            UIView *cell = self.visibleCellArray[i];
            if (CGRectGetMaxX(cell.frame) > offset.x+CGRectGetWidth(self.frame)) {
                UIView *unVisibleCell = self.visibleCellArray[i+([self extraVisibleCount]-1)];
                [unVisibleCell removeFromSuperview];
                [self.unVisibleCellArray addObject:unVisibleCell];
                [self.visibleCellArray removeObjectAtIndex:i+([self extraVisibleCount]-1)];
            }
        }
    }
    NSLog(@"cell对象个数:%ld",self.visibleCellArray.count+self.unVisibleCellArray.count);
}

//根据scrollview的偏移量来获取屏幕最左边显示的是第几列
- (NSInteger)getFirstColumnFromContentOffsetX:(CGFloat)x {
    CGFloat totalWidth = 0;
    for (int i = 0; i < [self.delegate numberOfColumnsInTableView:self]; i++) {
        CGFloat width = [self.delegate tableView:self widthForColumn:i];
        if (totalWidth <= x && totalWidth+width > x) {
            return i;
        } else {
            totalWidth += width;
        }
    }
    return 0;
}

//根据scrollview的偏移量来获取屏幕最右边显示的是第几列
- (NSInteger)getLastColumnFromContentOffsetX:(CGFloat)x {
    CGFloat totalWidth = 0;
    for (int i = 0; i < [self.delegate numberOfColumnsInTableView:self]; i++) {
        CGFloat width = [self.delegate tableView:self widthForColumn:i];
        if (totalWidth <= x+CGRectGetWidth(self.frame) && totalWidth+width > x+CGRectGetWidth(self.frame)) {
            return i;
        } else {
            totalWidth += width;
        }
    }
    return 0;
}

//根据cell对象来获取改cell是第几列
- (NSInteger)getColumnFromCell:(UIView *)cell {
    CGFloat totalWidth = 0;
    for (int i = 0; i < [self.delegate numberOfColumnsInTableView:self]; i++) {
        totalWidth += [self.delegate tableView:self widthForColumn:i];
        if (CGRectGetMaxX(cell.frame) == totalWidth) {
            return i;
        }
    }
    return 0;
}

//获取所有Cell的最小宽度
- (CGFloat)getMinWithFormCells {
    NSInteger count = [self.delegate numberOfColumnsInTableView:self];
    if (count == 0) {
        return self.frame.size.width;
    } else {
        CGFloat width = [self.delegate tableView:self widthForColumn:0];
        for (int i = 1; i < count; i++) {
            if ([self.delegate tableView:self widthForColumn:i] < width) {
                width = [self.delegate tableView:self widthForColumn:i];
            }
        }
        return width;
    }
}

//根据cell列数获取到cell的x
- (CGFloat)getOriginXFormCellColumn:(NSInteger)column {
    CGFloat x = 0;
    for (int i = 0; i < column; i++) {
        x += [self.delegate tableView:self widthForColumn:i];
    }
    return x;
}

@end
