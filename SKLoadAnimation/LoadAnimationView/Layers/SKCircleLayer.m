//
//  SKCircleLayer.m
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/26.
//  Copyright © 2016年 nachuan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SKCircleLayer.h"
#import "UIColor+Hex.h"
@interface SKCircleLayer ()



@property (nonatomic, strong) UIBezierPath *smallCirclePath; //小圆路径
@property (nonatomic, strong) UIBezierPath *bigCirclePath;  //大圆路径
@property (nonatomic, strong) UIBezierPath *verticalSquishCirclePath; //竖直挤扁路径
@property (nonatomic, strong) UIBezierPath *horizontalSquishCirclePaht;//水平挤扁路径

@property (nonatomic, assign) CGFloat smallCircleX;
@property (nonatomic, assign) CGFloat smallCircleY;
@property (nonatomic, assign) CGFloat smallCircleW;
@property (nonatomic, assign) CGFloat smallCircleH;

@property (nonatomic, assign) CGFloat bigCircleX;
@property (nonatomic, assign) CGFloat bigCircleY;
@property (nonatomic, assign) CGFloat bigCircleW;
@property (nonatomic, assign) CGFloat bigCircleH;

@property (nonatomic, assign) CGFloat squishCircleX;
@property (nonatomic, assign) CGFloat squishCircleY;
@property (nonatomic, assign) CGFloat squishCircleW;
@property (nonatomic, assign) CGFloat squishCircleH;

@end

static const NSTimeInterval kAnimationDuration  = 0.3;
static const NSTimeInterval kAnimationBeginTime = 0.0;


@implementation SKCircleLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame        = frame;
        self.path         = self.smallCirclePath.CGPath;
        self.fillColor    = [UIColor colorWithHexString:@"#daffff"].CGColor;
        self.circleRadius = 50.0;
        self.squishRatio  = 0.1;
    }
    return self;
}

#pragma mark - 懒加载路径

- (CGFloat)smallCircleX
{
    if (_smallCircleX == 0) {
        _smallCircleX = self.bounds.size.width / 2.0;
    }
    return _smallCircleX;
}

- (CGFloat)smallCircleY
{
    if (_smallCircleY == 0) {
        _smallCircleY = self.bounds.size.height / 2.0;
    }
    return _smallCircleY;
}

- (UIBezierPath *)smallCirclePath
{
    if (!_smallCirclePath) {
        _smallCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.smallCircleX, self.smallCircleY, self.smallCircleW, self.smallCircleH)];
    }
    return _smallCirclePath;
}


- (CGFloat)bigCircleX
{
    if (_bigCircleX == 0) {
        _bigCircleX = self.bounds.size.width / 2.0 - self.circleRadius;
    }
    return _bigCircleX;
}

- (CGFloat)bigCircleY
{
    if (_bigCircleY == 0) {
        _bigCircleY = self.bounds.size.height / 2.0 - self.circleRadius;
    }
    return _bigCircleY;
}

- (CGFloat)bigCircleW
{
    if (_bigCircleW == 0) {
        _bigCircleW = self.circleRadius * 2;
    }
    return _bigCircleW;
}

- (UIBezierPath *)bigCirclePath
{
    if (!_bigCirclePath) {
        _bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bigCircleX, self.bigCircleY, self.bigCircleW, self.bigCircleW)];
    }
    return _bigCirclePath;
}



- (CGFloat)squishCircleX
{
    if (_squishCircleX == 0) {
        _squishCircleX = self.bounds.size.width / 2.0 - self.circleRadius + self.circleRadius * self.squishRatio * 0.5;
    }
    return _squishCircleX;
}

- (CGFloat)squishCircleY
{
    if (_squishCircleY == 0) {
        _squishCircleY = self.bounds.size.height / 2.0 - self.circleRadius + self.circleRadius * self.squishRatio * 0.5;
    }
    return _squishCircleY;
}

- (CGFloat)squishCircleW
{
    if (_squishCircleW == 0) {
        _squishCircleW = self.circleRadius * (1 - self.squishRatio) * 2;
    }
    return _squishCircleW;
}

- (UIBezierPath *)verticalSquishCirclePath
{
    if (!_verticalSquishCirclePath) {
        _verticalSquishCirclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bigCircleX, self.squishCircleY, self.bigCircleW, self.squishCircleW)];
    }
    return _verticalSquishCirclePath;
}

- (UIBezierPath *)horizontalSquishCirclePaht
{
    if (!_horizontalSquishCirclePaht) {
        _horizontalSquishCirclePaht = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.squishCircleX, self.squishCircleY, self.squishCircleW, self.squishCircleW)];
    }
    return _horizontalSquishCirclePaht;
}

- (void)wobbleAnimationGroup:(id)delegate
{
    /** 竖直挤压 */
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.bigCirclePath.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.verticalSquishCirclePath.CGPath);
    animation1.duration = kAnimationDuration;
    animation1.beginTime = kAnimationBeginTime;
    
    /** 竖直挤压后紧接水平挤压 */
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.verticalSquishCirclePath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.horizontalSquishCirclePaht.CGPath);
    animation2.duration = kAnimationDuration;
    animation2.beginTime = animation1.beginTime + animation1.duration;
    
    /** 水平挤压恢复原样 */
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.horizontalSquishCirclePaht.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.verticalSquishCirclePath.CGPath);
    animation3.duration = kAnimationDuration;
    animation3.beginTime = animation2.beginTime + animation2.duration;
    
    /** 恢复到挤压前的状态 */
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.verticalSquishCirclePath.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.bigCirclePath.CGPath);
    animation4.duration = kAnimationDuration;
    animation4.beginTime = animation3.beginTime + animation3.duration;
    
    /** 创建动画组 */
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = delegate;
    animationGroup.animations = @[animation1, animation2, animation3, animation4];
    animationGroup.duration = 4 * kAnimationDuration;
    animationGroup.repeatCount = 2;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [self addAnimation:animationGroup forKey:kWobbleAnimationGroupKey];
}

- (void)expandAnimation:(id)delegate
{
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnimation.delegate = delegate;
    expandAnimation.fromValue = (__bridge id _Nullable)(self.smallCirclePath.CGPath);
    expandAnimation.toValue = (__bridge id _Nullable)(self.bigCirclePath.CGPath);
    expandAnimation.duration = kAnimationDuration;
    expandAnimation.fillMode = kCAFillModeForwards;
    expandAnimation.removedOnCompletion = NO;
    [self addAnimation:expandAnimation forKey:kExpandAnimationKey];
}

- (void)contractAmimation:(id)delegate
{
    CABasicAnimation *contractAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    contractAnimation.delegate = delegate;
    contractAnimation.fromValue = (__bridge id _Nullable)(self.bigCirclePath.CGPath);
    contractAnimation.toValue = (__bridge id _Nullable)(self.smallCirclePath.CGPath);
    contractAnimation.duration = kAnimationDuration;
    contractAnimation.fillMode = kCAFillModeForwards;
    contractAnimation.removedOnCompletion = NO;
    [self addAnimation:contractAnimation forKey:kContractAnimationKey];
}


@end
