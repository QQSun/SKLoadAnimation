//
//  SKRectangleLayer.m
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/27.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKRectangleLayer.h"
#import <UIKit/UIKit.h>

@interface SKRectangleLayer ()

@property (nonatomic, assign) CGFloat smallRectangleX;
@property (nonatomic, assign) CGFloat smallRectangleY;

@property (nonatomic, assign) CGPoint smallRectangleLeftBottom;
@property (nonatomic, assign) CGPoint smallRectangleLeftTop;
@property (nonatomic, assign) CGPoint smallRectangleRightTop;
@property (nonatomic, assign) CGPoint smallRectangleRightBottom;

@property (nonatomic, strong) UIBezierPath *smallRectanglePath;
@property (nonatomic, strong) UIBezierPath *bigRectanglePath;

@end

@implementation SKRectangleLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = 4;
        self.lineCap = kCALineCapRound;
        self.path = self.smallRectanglePath.CGPath;
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


- (CGFloat)smallRectangleX
{
    if (_smallRectangleX == 0) {
        _smallRectangleX = self.bounds.size.width / 2.0;
    }
    return _smallRectangleX;
}



- (CGFloat)smallRectangleY
{
    if (_smallRectangleY == 0) {
        _smallRectangleY = self.bounds.size.height / 2.0;
    }
    return _smallRectangleY;
}

- (CGFloat)smallRectangleRadius
{
    if (_smallRectangleRadius == 0) {
        _smallRectangleRadius = 60;
    }
    return _smallRectangleRadius;
}

- (CGPoint)smallRectangleLeftBottom
{
    if (CGPointEqualToPoint(_smallRectangleLeftBottom, CGPointZero)) {
        _smallRectangleLeftBottom = CGPointMake(self.smallRectangleX + self.smallRectangleRadius * cos(M_PI/6 + M_PI) , self.smallRectangleY - self.smallRectangleRadius * sin(M_PI/6 + M_PI));
    }
    return _smallRectangleLeftBottom;
}

- (CGPoint)smallRectangleLeftTop
{
    if (CGPointEqualToPoint(_smallRectangleLeftTop, CGPointZero)) {
        _smallRectangleLeftTop = CGPointMake(self.smallRectangleLeftBottom.x, self.smallRectangleLeftBottom.y - self.smallRectangleRadius * 2 * cos(M_PI / 6));
    }
    return _smallRectangleLeftTop;
}

- (CGPoint)smallRectangleRightTop
{
    if (CGPointEqualToPoint(_smallRectangleRightTop, CGPointZero)) {
        _smallRectangleRightTop = CGPointMake(self.smallRectangleLeftTop.x + self.smallRectangleRadius * 2 * cos(M_PI / 6), self.smallRectangleLeftTop.y);
    }
    return _smallRectangleRightTop;
}

- (CGPoint)smallRectangleRightBottom
{
    if (CGPointEqualToPoint(_smallRectangleRightBottom, CGPointZero)) {
        _smallRectangleRightBottom = CGPointMake(self.smallRectangleRightTop.x, self.smallRectangleLeftBottom.y);
    }
    return _smallRectangleRightBottom;
}

- (UIBezierPath *)smallRectanglePath
{
    if (!_smallRectanglePath) {
        _smallRectanglePath = [UIBezierPath bezierPath];
        [_smallRectanglePath moveToPoint:self.smallRectangleLeftBottom];
        [_smallRectanglePath addLineToPoint:self.smallRectangleLeftTop];
        [_smallRectanglePath addLineToPoint:self.smallRectangleRightTop];
        [_smallRectanglePath addLineToPoint:self.smallRectangleRightBottom];
        [_smallRectanglePath closePath];
    }
    return _smallRectanglePath;
}

- (void)strokeChangeWithColor:(UIColor *)color delegate:(id)delegate
{
    self.strokeColor = color.CGColor;
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.delegate = delegate;
    strokeAnimation.fromValue = @0.0;
    strokeAnimation.toValue = @1.0;
    strokeAnimation.beginTime = self.animationBeginTime;
    strokeAnimation.duration = self.animationDuration;
    strokeAnimation.fillMode = kCAFillModeForwards;
    strokeAnimation.removedOnCompletion = NO;
    [self addAnimation:strokeAnimation forKey:kRectangleStrokeAnimationKey];
}

@end
