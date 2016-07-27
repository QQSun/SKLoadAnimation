//
//  SKCircleLayer.h
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/26.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static NSString *kWobbleAnimationGroupKey = @"kWobbleAnimationGroupKey";
static NSString *kExpandAnimationKey      = @"kExpandAnimationKey";
static NSString *kContractAnimationKey    = @"kContractAnimationKey";

@interface SKCircleLayer : CAShapeLayer

/** 圆半径 默认50 */
@property (nonatomic, assign) CGFloat circleRadius;

/** 挤压比率 默认0.1 */
@property (nonatomic, assign) CGFloat squishRatio;

/** 动画时长,单一动画,非组合动画 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/** 动画开始时间 */
@property (nonatomic, assign) NSTimeInterval animationBeginTime;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  摇晃动画
 */
- (void)wobbleAnimationGroup:(id)delegate;

/**
 *  膨胀动画
 */
- (void)expandAnimation:(id)delegate;

/**
 *  收缩动画
 */
- (void)contractAmimation:(id)delegate;

@end
