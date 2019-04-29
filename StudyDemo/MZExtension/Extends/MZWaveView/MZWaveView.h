//
//  MZWaveView.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/2/1.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WaveDirectionType) {
    WaveDirectionTypeForward = -1,//从左到右
    WaveDirectionTypeBackWard = 1 //从右到左
};

@interface MZWaveView : UIView
@property (nonatomic, assign) CGFloat frontHeight;    //外层最高高度，默认MZWaveView高度2/3
@property (nonatomic, assign) CGFloat insideHeight;   //内层最高高度，默认MZWaveView高度
@property (nonatomic ,strong) UIColor *frontColor;    //外层波形颜色，默认黑色
@property (nonatomic ,strong) UIColor *insideColor;   //内层波形颜色，默认灰色
@property (nonatomic ,assign) CGFloat frontSpeed;     //外层波形移动速度
@property (nonatomic ,assign) CGFloat insideSpeed;    //内层波形移动速度
@property (nonatomic ,assign) CGFloat waveOffset;     //两层波形相位差,默认M_PI
@property (nonatomic, assign) CGFloat frontWavePI;    //外层波浪全屏显示多少个2PI
@property (nonatomic, assign) CGFloat insideWavePI;   //内层波浪全屏显示多少个2PI
@property (nonatomic ,assign) WaveDirectionType directionType; //移动方向，默认从右往左
@end
