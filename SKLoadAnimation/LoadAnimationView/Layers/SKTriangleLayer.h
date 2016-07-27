//
//  SKTriangleLayer.h
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/26.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

static NSString *kTriangleExpandAnimationKey = @"kTriangleExpandAnimationKey";
static NSString *kTriangleRotateAnimationKey = @"kTriangleRotateAnimationKey";

@interface SKTriangleLayer : CAShapeLayer

/** 圆外三角形的圆半径 默认60 */
@property (nonatomic, assign) CGFloat bigTriangleRadius;

/** 圆内三角形的圆半径 默认40 */
@property (nonatomic, assign) CGFloat smallTriangleRadius;

/** 动画时长,单一动画,非组合动画 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/** 动画开始时间 */
@property (nonatomic, assign) NSTimeInterval animationBeginTime;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)triangleExpandAnimation:(id)delegate;

- (void)triangleRotateAnimation:(id)delegate;

@end
