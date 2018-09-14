//
//  MZBannerView.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/8/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZBannerView.h"

#define DefaultTimeInterval 4

@interface MZBannerView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation MZBannerView
{
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoScroll = YES;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((frame.size.width-100)/2, frame.size.height-25, 100,15)];
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:90/255.0 green:160/255.0 blue:245/255.0 alpha:1];
        self.pageControl.hidesForSinglePage = YES;
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)setDelegate:(id<MZBannerViewDelegate>)delegate {
    _delegate = delegate;
    if ([delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)delegate;
        if (@available(iOS 11.0, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            vc.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

- (void)setImageUrls:( NSArray *)imageUrls {
    _imageUrls = imageUrls;
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    if (imageUrls.count == 0) {
        self.scrollView.scrollEnabled = NO;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        self.scrollView.contentOffset = CGPointMake(0, 0);
        if (self.placeholder) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            imageView.image = self.placeholder;
            [self.scrollView addSubview:imageView];
        }
    } else {
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*(imageUrls.count+2), self.scrollView.frame.size.height);
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        for (int i = 0; i < imageUrls.count+2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            NSString *url;
            if (i == imageUrls.count+1) {
                url = imageUrls[0];
            } else if (i == 0) {
                url = imageUrls[imageUrls.count-1];
            } else {
                url = imageUrls[i-1];
            }
            if (self.placeholder) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:self.placeholder];
            } else {
                [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
            }
            imageView.tag = 99+i;
            [self.scrollView addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
        }
        
    }
    self.pageControl.numberOfPages = imageUrls.count;
    self.pageControl.currentPage = 0;
    [self autoPlay];
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    if (imageNames.count == 0) {
        self.scrollView.scrollEnabled = NO;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        if (self.placeholder) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            imageView.image = self.placeholder;
            [self.scrollView addSubview:imageView];
        }
    } else {
        self.scrollView.scrollEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*(imageNames.count+2), self.scrollView.frame.size.height);
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        for (int i = 0; i < imageNames.count+2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            NSString *imageName;
            if (i == imageNames.count+1) {
                imageName = imageNames[0];
            } else if (i == 0) {
                imageName = imageNames[imageNames.count-1];
            } else {
                imageName = imageNames[i-1];
            }
            imageView.image = [UIImage imageNamed:imageName];
            imageView.tag = 99+i;
            [self.scrollView addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
        }
        
    }
    self.pageControl.numberOfPages = imageNames.count;
    self.pageControl.currentPage = 0;
    [self autoPlay];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.pageControl.pageIndicatorTintColor = normalColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.pageControl.currentPageIndicatorTintColor = tintColor;
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    if (autoScroll) {
        [self autoPlay];
    } else {
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
        if (self.scrollView.subviews.count > 0) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
        }
    }
}

- (void)setHidePageControl:(BOOL)hidePageControl {
    _hidePageControl = hidePageControl;
    self.pageControl.hidden = hidePageControl;
}

- (void)tapImageView:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag;
    if (index == 99) {
        index = 99+self.scrollView.subviews.count;
    } else if (index == 100+self.scrollView.subviews.count) {
        index = 100;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:didSelectedIndex:data:)]) {
        [self.delegate bannerView:self didSelectedIndex:index-100 data:self.dataArray?self.dataArray[index-100]:nil];
    }
}

- (void)autoPlay {
    if (!self.autoScroll) {
        return;
    }
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    if (self.interval == 0) {
        _interval = DefaultTimeInterval;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(timeFun) userInfo:nil repeats:YES];
}

- (void)setInterval:(NSTimeInterval)interval {
    _interval = interval;
    [self autoPlay];
}

- (void)timeFun {
    CGPoint point = self.scrollView.contentOffset;
    point.x += self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:point animated:YES];
    NSLog(@"%lf",point.x);
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_timer isValid]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([_timer isValid]) {
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.interval]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.x <= 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width-2*scrollView.frame.size.width, 0);
    } else if(offset.x >= scrollView.contentSize.width-scrollView.frame.size.width) {
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }
    NSInteger page = (NSInteger)(scrollView.contentOffset.x/scrollView.frame.size.width);
    if (page == 0) {
        self.pageControl.currentPage = scrollView.subviews.count-1;
    } else if (page == scrollView.subviews.count+2) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = page-1;
    }
}

@end
