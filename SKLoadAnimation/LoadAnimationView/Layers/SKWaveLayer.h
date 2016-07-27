//
//  SKWaveLayer.h
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/27.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static NSString *kWaveAnimationKey = @"kWaveAnimationKey";

@interface SKWaveLayer : CAShapeLayer

/** 动画时长,单一动画,非组合动画 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/** 动画开始时间 */
@property (nonatomic, assign) NSTimeInterval animationBeginTime;

/** 波浪所在矩形内圆半径 默认60 */
@property (nonatomic, assign) CGFloat smallWaveRadius;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)waveAnimation:(id)delegate;

@end
