//
//  SKLoadAnimationView.m
//  SKLoadAnimation
//
//  Created by nachuan on 16/7/26.
//  Copyright © 2016年 nachuan. All rights reserved.
//

#import "SKLoadAnimationView.h"
#import "SKCircleLayer.h"
#import "SKTriangleLayer.h"
#import "SKRectangleLayer.h"
#import "SKWaveLayer.h"
@interface SKLoadAnimationView ()

@property (nonatomic, strong) SKCircleLayer *circleLayer;
@property (nonatomic, strong) SKTriangleLayer *triangleLayer;
@property (nonatomic, strong) SKRectangleLayer *rectangleLayer;
@property (nonatomic, strong) SKWaveLayer *waveLayer;

@end

@implementation SKLoadAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        [self addCircleLayer];
    }
    return self;
}

#pragma mark - 懒加载

- (SKCircleLayer *)circleLayer
{
    if (!_circleLayer) {
        _circleLayer = [[SKCircleLayer alloc] initWithFrame:self.bounds];
    }
    return _circleLayer;
}

- (SKTriangleLayer *)triangleLayer
{
    if (!_triangleLayer) {
        _triangleLayer = [[SKTriangleLayer alloc] initWithFrame:self.bounds];
    }
    return _triangleLayer;
}

- (SKRectangleLayer *)rectangleLayer
{
    if (!_rectangleLayer) {
        _rectangleLayer = [[SKRectangleLayer alloc] initWithFrame:self.bounds];
    }
    return _rectangleLayer;
}

- (SKWaveLayer *)waveLayer
{
    if (!_waveLayer) {
        _waveLayer = [[SKWaveLayer alloc] initWithFrame:self.bounds];
    }
    return _waveLayer;
}


- (void)addCircleLayer
{
    [self.layer addSublayer:self.circleLayer];
    [_circleLayer expandAnimation:self];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[_circleLayer animationForKey:kExpandAnimationKey]]) {
        [_circleLayer wobbleAnimationGroup:self];
    }else if ([anim isEqual:[_circleLayer animationForKey:kWobbleAnimationGroupKey]]){
        [self.layer insertSublayer:self.triangleLayer below:_circleLayer];
        [_triangleLayer triangleExpandAnimation:self];
    }else if ([anim isEqual:[_triangleLayer animationForKey:kTriangleExpandAnimationKey]]){
        [_triangleLayer triangleRotateAnimation:self];
        [_circleLayer contractAmimation:self];
    }else if ([anim isEqual:[_triangleLayer animationForKey:kTriangleRotateAnimationKey]]){
        [self.layer addSublayer:self.rectangleLayer];
        [_rectangleLayer strokeChangeWithColor:[UIColor cyanColor] delegate:self];
    }else if ([anim isEqual:[_rectangleLayer animationForKey:kRectangleStrokeAnimationKey]]){
        [self.layer insertSublayer:self.waveLayer below:_rectangleLayer];
        [_waveLayer waveAnimation:self];
    }else if ([anim isEqual:[_waveLayer animationForKey:kWaveAnimationKey]]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(loadAnimationCompletion)]) {
            [self.delegate loadAnimationCompletion];
        }
    }
}

@end
