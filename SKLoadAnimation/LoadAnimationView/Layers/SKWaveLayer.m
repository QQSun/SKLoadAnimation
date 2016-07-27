//
//  SKWaveLayer.m
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/27.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKWaveLayer.h"
#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"

@interface SKWaveLayer ()

@property (strong, nonatomic) UIBezierPath *wavePathPre;
@property (strong, nonatomic) UIBezierPath *wavePathStart;
@property (strong, nonatomic) UIBezierPath *wavePathLow;
@property (strong, nonatomic) UIBezierPath *wavePathMid;
@property (strong, nonatomic) UIBezierPath *wavePathHigh;
@property (strong, nonatomic) UIBezierPath *wavePathComplete;

@property (nonatomic, assign) CGFloat smallWaveX;
@property (nonatomic, assign) CGFloat smallWaveY;

@property (nonatomic, assign) CGFloat smallWaveLeftBottomX;
@property (nonatomic, assign) CGFloat smallWaveLeftBottomY;

@property (nonatomic, assign) CGPoint smallWaveLeftBottom;
@property (nonatomic, assign) CGPoint smallWaveLeftTop;
@property (nonatomic, assign) CGPoint smallWaveRightTop;
@property (nonatomic, assign) CGPoint smallWaveRightBottom;


@end

@implementation SKWaveLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
//        self.backgroundColor = [UIColor blackColor].CGColor;
        self.fillColor = [UIColor colorWithHexString:@"#40e0b0"].CGColor;
        self.path = self.wavePathStart.CGPath;
    }
    return self;
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


- (CGFloat)smallWaveX
{
    if (_smallWaveX == 0) {
        _smallWaveX = self.bounds.size.width / 2.0;
    }
    return _smallWaveX;
}



- (CGFloat)smallWaveY
{
    if (_smallWaveY == 0) {
        _smallWaveY = self.bounds.size.height / 2.0;
    }
    return _smallWaveY;
}

- (CGFloat)smallWaveLeftBottomX
{
    if (_smallWaveLeftBottomX == 0) {
        _smallWaveLeftBottomX = self.smallWaveLeftBottom.x;
    }
    return _smallWaveLeftBottomX;
}

- (CGFloat)smallWaveLeftBottomY
{
    if (_smallWaveLeftBottomY) {
        _smallWaveLeftBottomY = self.smallWaveLeftBottom.y;
    }
    return _smallWaveLeftBottomY;
}

- (CGFloat)smallWaveRadius
{
    if (_smallWaveRadius == 0) {
        _smallWaveRadius = 60;
    }
    return _smallWaveRadius;
}

- (CGPoint)smallWaveLeftBottom
{
    if (CGPointEqualToPoint(_smallWaveLeftBottom, CGPointZero)) {
        _smallWaveLeftBottom = CGPointMake(self.smallWaveX + self.smallWaveRadius * cos(M_PI/6 + M_PI) , self.smallWaveY - self.smallWaveRadius * sin(M_PI/6 + M_PI));
    }
    return _smallWaveLeftBottom;
}

- (CGPoint)smallWaveLeftTop
{
    if (CGPointEqualToPoint(_smallWaveLeftTop, CGPointZero)) {
        _smallWaveLeftTop = CGPointMake(self.smallWaveLeftBottom.x, self.smallWaveLeftBottom.y - self.smallWaveRadius * 2 * cos(M_PI / 6));
    }
    return _smallWaveLeftTop;
}

- (CGPoint)smallWaveRightTop
{
    if (CGPointEqualToPoint(_smallWaveRightTop, CGPointZero)) {
        _smallWaveRightTop = CGPointMake(self.smallWaveLeftTop.x + self.smallWaveRadius * 2 * cos(M_PI / 6), self.smallWaveLeftTop.y);
    }
    return _smallWaveRightTop;
}

- (CGPoint)smallWaveRightBottom
{
    if (CGPointEqualToPoint(_smallWaveRightBottom, CGPointZero)) {
        _smallWaveRightBottom = CGPointMake(self.smallWaveRightTop.x, self.smallWaveLeftBottom.y);
    }
    return _smallWaveRightBottom;
}


- (UIBezierPath *)wavePathPre
{
    if (!_wavePathPre) {
        _wavePathPre = [UIBezierPath bezierPath];
        [_wavePathPre moveToPoint:self.smallWaveLeftBottom];
        [_wavePathPre addLineToPoint:CGPointMake(self.smallWaveLeftBottom.x, self.smallWaveLeftBottom.y - 1)];
        [_wavePathPre addLineToPoint:CGPointMake(self.smallWaveRightBottom.x, self.smallWaveLeftBottom.y - 1)];
        [_wavePathPre addLineToPoint:self.smallWaveRightBottom];
        [_wavePathPre closePath];
    }
    return _wavePathPre;
}

- (UIBezierPath *)wavePathStart
{
    if (!_wavePathStart) {
        _wavePathStart = [UIBezierPath bezierPath];
        [_wavePathStart moveToPoint:self.smallWaveLeftBottom];
        [_wavePathStart addLineToPoint:CGPointMake(self.smallWaveLeftBottom.x, self.smallWaveLeftBottom.y - 20)];
        [_wavePathStart addCurveToPoint:CGPointMake(self.smallWaveRightBottom.x, self.smallWaveRightBottom.y - 20) controlPoint1:CGPointMake(self.smallWaveLeftBottom.x + 30, self.smallWaveRightBottom.y - 30) controlPoint2:CGPointMake(self.smallWaveLeftBottom.x + 40, self.smallWaveRightBottom.y - 10)];
        [_wavePathStart addLineToPoint:self.smallWaveRightBottom];
        [_wavePathStart closePath];
    }
    return _wavePathStart;
}


- (UIBezierPath *)wavePathLow
{
    if (!_wavePathLow) {
        _wavePathLow = [UIBezierPath bezierPath];
        [_wavePathLow moveToPoint:self.smallWaveLeftBottom];
        [_wavePathLow addLineToPoint:CGPointMake(self.smallWaveLeftBottom.x, self.smallWaveLeftBottom.y - 40)];
        [_wavePathLow addCurveToPoint:CGPointMake(self.smallWaveRightBottom.x, self.smallWaveRightBottom.y - 40) controlPoint1:CGPointMake(self.smallWaveLeftBottom.x + 30, self.smallWaveRightBottom.y - 35) controlPoint2:CGPointMake(self.smallWaveLeftBottom.x + 40, self.smallWaveRightBottom.y - 50)];
        [_wavePathLow addLineToPoint:self.smallWaveRightBottom];
        [_wavePathLow closePath];
    }
    return _wavePathLow;
}

- (UIBezierPath *)wavePathMid
{
    if (!_wavePathMid) {
        _wavePathMid = [UIBezierPath bezierPath];
        [_wavePathMid moveToPoint:self.smallWaveLeftBottom];
        [_wavePathMid addLineToPoint:CGPointMake(self.smallWaveLeftBottom.x, self.smallWaveLeftBottom.y - 60)];
        [_wavePathMid addCurveToPoint:CGPointMake(self.smallWaveRightBottom.x, self.smallWaveRightBottom.y - 60) controlPoint1:CGPointMake(self.smallWaveLeftBottom.x + 30, self.smallWaveRightBottom.y - 70) controlPoint2:CGPointMake(self.smallWaveLeftBottom.x + 40, self.smallWaveRightBottom.y - 50)];
        [_wavePathMid addLineToPoint:self.smallWaveRightBottom];
        [_wavePathMid closePath];
    }
    return _wavePathMid;
}


- (UIBezierPath *)wavePathHigh
{
    if (!_wavePathHigh) {
        _wavePathHigh = [UIBezierPath bezierPath];
        [_wavePathHigh moveToPoint:self.smallWaveLeftBottom];
        [_wavePathHigh addLineToPoint:CGPointMake(self.smallWaveLeftBottom.x, self.smallWaveLeftBottom.y - 80)];
        [_wavePathHigh addCurveToPoint:CGPointMake(self.smallWaveRightBottom.x, self.smallWaveRightBottom.y - 80) controlPoint1:CGPointMake(self.smallWaveLeftBottom.x + 30, self.smallWaveRightBottom.y - 75) controlPoint2:CGPointMake(self.smallWaveLeftBottom.x + 40, self.smallWaveRightBottom.y - 90)];
        [_wavePathHigh addLineToPoint:self.smallWaveRightBottom];
        [_wavePathHigh closePath];
    }
    return _wavePathHigh;
}

- (UIBezierPath *)wavePathComplete
{
    if (!_wavePathComplete) {
        _wavePathComplete = [UIBezierPath bezierPath];
        [_wavePathComplete moveToPoint:self.smallWaveLeftBottom];
        [_wavePathComplete addLineToPoint:self.smallWaveLeftTop];
        [_wavePathComplete addLineToPoint:self.smallWaveRightTop];
        [_wavePathComplete addLineToPoint:self.smallWaveRightBottom];
        [_wavePathComplete closePath];
    }
    return _wavePathComplete;
}


- (void)waveAnimation:(id)delegate
{
    //    1
    CABasicAnimation *waveAnimationPre = [CABasicAnimation animationWithKeyPath:@"path"];
    waveAnimationPre.fromValue = (__bridge id _Nullable)(self.wavePathPre.CGPath);
    waveAnimationPre.toValue = (__bridge id _Nullable)(self.wavePathStart.CGPath);
    waveAnimationPre.beginTime = 0.0;
    waveAnimationPre.duration = self.animationDuration;
    //    2
    CABasicAnimation *waveAnimationLow = [CABasicAnimation animationWithKeyPath:@"path"];
    waveAnimationLow.fromValue = (__bridge id _Nullable)(self.wavePathStart.CGPath);
    waveAnimationLow.toValue = (__bridge id _Nullable)(self.wavePathLow.CGPath);
    waveAnimationLow.beginTime = waveAnimationPre.beginTime + waveAnimationPre.duration;
    waveAnimationLow.duration = self.animationDuration;
    //    3
    CABasicAnimation *waveAnimationMid = [CABasicAnimation animationWithKeyPath:@"path"];
    waveAnimationMid.fromValue = (__bridge id _Nullable)(self.wavePathLow.CGPath);
    waveAnimationMid.toValue = (__bridge id _Nullable)(self.wavePathMid.CGPath);
    waveAnimationMid.beginTime = waveAnimationLow.beginTime + waveAnimationLow.duration;
    waveAnimationMid.duration = self.animationDuration;
    //    4
    CABasicAnimation *waveAnimationHigh = [CABasicAnimation animationWithKeyPath:@"path"];
    waveAnimationHigh.fromValue = (__bridge id _Nullable)(self.wavePathMid.CGPath);
    waveAnimationHigh.toValue = (__bridge id _Nullable)(self.wavePathHigh.CGPath);
    waveAnimationHigh.beginTime = waveAnimationMid.beginTime + waveAnimationMid.duration;
    waveAnimationHigh.duration = self.animationDuration;
    //    5
    CABasicAnimation *waveAnimationComplete = [CABasicAnimation animationWithKeyPath:@"path"];
    waveAnimationComplete.fromValue = (__bridge id _Nullable)(self.wavePathHigh.CGPath);
    waveAnimationComplete.toValue = (__bridge id _Nullable)(self.wavePathComplete.CGPath);
    waveAnimationComplete.beginTime = waveAnimationHigh.beginTime + waveAnimationHigh.duration;
    waveAnimationComplete.duration = self.animationDuration;
    //    6
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.delegate = delegate;
    animationGroup.animations = @[waveAnimationPre, waveAnimationLow, waveAnimationMid, waveAnimationHigh, waveAnimationComplete];
    animationGroup.duration = waveAnimationComplete.beginTime + waveAnimationComplete.duration;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    [self addAnimation:animationGroup forKey:kWaveAnimationKey];

}











































@end
