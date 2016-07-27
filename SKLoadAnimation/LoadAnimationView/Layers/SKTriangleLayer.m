//
//  SKTriangleLayer.m
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/26.
//  Copyright © 2016年 nachuan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SKTriangleLayer.h"
#import "UIColor+Hex.h"
@interface SKTriangleLayer ()


@property (nonatomic, strong) UIBezierPath *smallTrianglePath;
@property (nonatomic, strong) UIBezierPath *topTrianglePath;
@property (nonatomic, strong) UIBezierPath *leftTrianglePath;
@property (nonatomic, strong) UIBezierPath *rightTrianglePath;

@property (nonatomic, assign) CGFloat smallTriangleX;
@property (nonatomic, assign) CGFloat smallTriangleY;

@property (nonatomic, assign) CGPoint smallTriangleTop;
@property (nonatomic, assign) CGPoint smallTriangleLeft;
@property (nonatomic, assign) CGPoint smallTriangleRight;

@property (nonatomic, assign) CGPoint bigTriangleTop;
@property (nonatomic, assign) CGPoint bigTriangleLeft;
@property (nonatomic, assign) CGPoint bigTriangleRight;

@end

@implementation SKTriangleLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super init]) {
        self.frame       = frame;
        self.path        = self.smallTrianglePath.CGPath;
        self.lineCap     = kCALineCapRound;
        self.lineJoin    = kCALineJoinRound;
        self.lineWidth   = 4;
        self.fillColor   = [UIColor colorWithHexString:@"#da70d6"].CGColor;
        self.strokeColor = [UIColor colorWithHexString:@"#da70d6"].CGColor;
    }
    return self;
}

#pragma mark - 懒加载路径

- (CGFloat)smallTriangleX
{
    if (_smallTriangleX == 0) {
        _smallTriangleX = self.bounds.size.width / 2.0;
    }
    return _smallTriangleX;
}

- (CGFloat)smallTriangleY
{
    if (_smallTriangleY == 0) {
        _smallTriangleY = self.bounds.size.height / 2.0;
    }
    return _smallTriangleY;
}

- (CGFloat)smallTriangleRadius
{
    if (_smallTriangleRadius == 0) {
        _smallTriangleRadius = 40;
    }
    return _smallTriangleRadius;
}

- (CGFloat)bigTriangleRadius
{
    if (_bigTriangleRadius == 0) {
        _bigTriangleRadius = 60;
    }
    return _bigTriangleRadius;
}

- (CGPoint)smallTriangleTop
{
    if (CGPointEqualToPoint(_smallTriangleTop, CGPointZero)) {
        _smallTriangleTop = CGPointMake(self.smallTriangleX, self.smallTriangleY - self.smallTriangleRadius);
    }
    return _smallTriangleTop;
}

- (CGPoint)smallTriangleLeft
{
    if (CGPointEqualToPoint(_smallTriangleLeft, CGPointZero)) {
        _smallTriangleLeft = CGPointMake(self.smallTriangleX + self.smallTriangleRadius * cos(M_PI / 6 + M_PI), self.smallTriangleY - self.smallTriangleRadius * sin(M_PI / 6 + M_PI));
    }
    return _smallTriangleLeft;
}

- (CGPoint)smallTriangleRight
{
    if (CGPointEqualToPoint(_smallTriangleRight, CGPointZero)) {
        _smallTriangleRight = CGPointMake(self.smallTriangleX + self.smallTriangleRadius * cos(-M_PI / 6), self.smallTriangleY - self.smallTriangleRadius * sin(-M_PI / 6));
    }
    return _smallTriangleRight;
}

- (CGPoint)bigTriangleTop
{
    if (CGPointEqualToPoint(_bigTriangleTop, CGPointZero)) {
        _bigTriangleTop = CGPointMake(self.smallTriangleX, self.smallTriangleY - self.bigTriangleRadius);
    }
    return _bigTriangleTop;
}

- (CGPoint)bigTriangleLeft
{
    if (CGPointEqualToPoint(_bigTriangleLeft, CGPointZero)) {
        _bigTriangleLeft = CGPointMake(self.smallTriangleX + self.bigTriangleRadius * cos(M_PI / 6 + M_PI), self.smallTriangleY - self.bigTriangleRadius * sin(M_PI / 6 + M_PI));
    }
    return _bigTriangleLeft;
}

- (CGPoint)bigTriangleRight
{
    if (CGPointEqualToPoint(_bigTriangleRight, CGPointZero)) {
        _bigTriangleRight = CGPointMake(self.smallTriangleX + self.bigTriangleRadius * cos(-M_PI / 6), self.smallTriangleY - self.bigTriangleRadius * sin(-M_PI / 6));
    }
    return _bigTriangleRight;
}

- (UIBezierPath *)smallTrianglePath
{
    if (!_smallTrianglePath) {
        _smallTrianglePath = [UIBezierPath bezierPath];
        [_smallTrianglePath moveToPoint:self.smallTriangleTop];
        [_smallTrianglePath addLineToPoint:self.smallTriangleLeft];
        [_smallTrianglePath addLineToPoint:self.smallTriangleRight];
        [_smallTrianglePath closePath];
    }
    return _smallTrianglePath;
}

- (UIBezierPath *)topTrianglePath
{
    if (!_topTrianglePath) {
        _topTrianglePath = [[UIBezierPath alloc] init];
        [_topTrianglePath moveToPoint:self.bigTriangleTop];
        [_topTrianglePath addLineToPoint:self.bigTriangleLeft];
        [_topTrianglePath addLineToPoint:self.bigTriangleRight];
        [_topTrianglePath closePath];
    }
    return _topTrianglePath;
}

- (UIBezierPath *)leftTrianglePath {
    if (!_leftTrianglePath) {
        _leftTrianglePath = [[UIBezierPath alloc] init];
        [_leftTrianglePath moveToPoint:self.smallTriangleTop];
        [_leftTrianglePath addLineToPoint:self.bigTriangleLeft];
        [_leftTrianglePath addLineToPoint:self.smallTriangleRight];
        [_leftTrianglePath closePath];
    }
    return _leftTrianglePath;
}

- (UIBezierPath *)rightTrianglePath {
    if (!_rightTrianglePath) {
        _rightTrianglePath = [[UIBezierPath alloc] init];
        [_rightTrianglePath moveToPoint:self.smallTriangleTop];
        [_rightTrianglePath addLineToPoint:self.bigTriangleLeft];
        [_rightTrianglePath addLineToPoint:self.bigTriangleRight];
        [_rightTrianglePath closePath];
    }
    return _rightTrianglePath;
}

- (NSTimeInterval)animationBeginTime
{
    if (!_animationBeginTime) {
        _animationBeginTime = 0.0;
    }
    return _animationBeginTime;
}

- (NSTimeInterval)animationDuration
{
    if (!_animationDuration) {
        _animationDuration = 0.3;
    }
    return _animationDuration;
}

- (void)triangleExpandAnimation:(id)delegate
{
    CABasicAnimation *leftTriangleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    leftTriangleAnimation.fromValue = (__bridge id _Nullable)(self.smallTrianglePath.CGPath);
    leftTriangleAnimation.toValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    leftTriangleAnimation.duration = self.animationDuration;
    leftTriangleAnimation.beginTime = self.animationBeginTime;
    
    CABasicAnimation *rightTriangleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rightTriangleAnimation.fromValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    rightTriangleAnimation.toValue = (__bridge id _Nullable)(self.rightTrianglePath.CGPath);
    rightTriangleAnimation.duration = self.animationDuration;
    rightTriangleAnimation.beginTime = leftTriangleAnimation.beginTime + leftTriangleAnimation.duration;
    
    CABasicAnimation *topTriangleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    topTriangleAnimation.fromValue = (__bridge id _Nullable)(self.rightTrianglePath.CGPath);
    topTriangleAnimation.toValue = (__bridge id _Nullable)(self.topTrianglePath.CGPath);
    topTriangleAnimation.duration = self.animationDuration;
    topTriangleAnimation.beginTime = rightTriangleAnimation.beginTime + rightTriangleAnimation.duration;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = delegate;
    animationGroup.animations = @[leftTriangleAnimation, rightTriangleAnimation, topTriangleAnimation];
    animationGroup.duration = 3 * self.animationDuration;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [self addAnimation:animationGroup forKey:kTriangleExpandAnimationKey];
    
}


- (void)triangleRotateAnimation:(id)delegate
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.delegate = delegate;
    rotateAnimation.fromValue = @0;
    rotateAnimation.toValue = @(M_PI * 2);
    rotateAnimation.duration = self.animationDuration * 5;
    rotateAnimation.beginTime = self.animationBeginTime;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    [self addAnimation:rotateAnimation forKey:kTriangleRotateAnimationKey];
    
    
}





































@end
