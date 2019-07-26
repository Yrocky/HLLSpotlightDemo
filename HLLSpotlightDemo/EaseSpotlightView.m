//
//  EaseSpotlightView.m
//  HLLSpotlightDemo
//
//  Created by skynet on 2019/7/26.
//  Copyright © 2019 HLL. All rights reserved.
//

#import "EaseSpotlightView.h"
#import "EaseSpotlight.h"

@interface EaseSpotlightView ()
@property (nonatomic ,strong ,readwrite) EaseSpotlight * spotlight;
@property (nonatomic ,assign) NSTimeInterval defaultAnimationDuration;
@property (nonatomic ,strong) CAShapeLayer * maskLayer;
@end
@implementation EaseSpotlightView

#pragma mark - cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self spotlightViewCommonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self spotlightViewCommonInit];
    }
    return self;
}
- (void) spotlightViewCommonInit{
    
    self.layer.mask = self.maskLayer;
    _defaultAnimationDuration = 0.25f;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.maskLayer.frame = self.bounds;
}

#pragma mark - API
- (void) setupInitialSpotlight:(EaseSpotlight *)initialSpotlight{
    if (initialSpotlight) {
        _spotlight = initialSpotlight;
    }
}

- (void)appearInitialSpotlightWithDuration:(NSTimeInterval)duration{
    [self appearWithSpotlight:nil duration:duration];
}

- (void) appearWithSpotlight:(nullable EaseSpotlight *)spotlight duration:(NSTimeInterval)duration{
    if (!spotlight) {
        spotlight = self.spotlight;
    }
    CAAnimation * appearAnimaiton = [self appearAnimationWithSpotlight:spotlight duration:duration];
    [self.maskLayer addAnimation:appearAnimaiton forKey:nil];
}

- (void) moveToSpotlight:(nonnull EaseSpotlight *)toSpotlight duration:(NSTimeInterval)duration moveType:(EaseSpotlightMoveType)moveType{
    
    if (!toSpotlight) {
        NSLog(@"[Spotlight] toSpotlight 不能为nil");
        return;
    }
    if (moveType == EaseSpotlightMoveDirect) {
        [self _moveDirectToSpotlight:toSpotlight duration:duration];
        
    }else if(moveType == EaseSpotlightMoveDisappear){
        [self _moveDisappearToSpotlight:toSpotlight duration:duration];
    }
}
- (void) disappearWithDuration:(NSTimeInterval)duration{
    
    CAAnimation * disappearAnimation = [self disappearAnimationWithSpotlight:nil duration:duration];
    [self.maskLayer addAnimation:disappearAnimation forKey:nil];
}

#pragma mark - Private

- (void) _moveDirectToSpotlight:(EaseSpotlight *)toSpotlight duration:(NSTimeInterval)duration{
    
    CAAnimation * moveAnimation = [self moveAnimationWithSpotlight:toSpotlight duration:duration];
    [self.maskLayer addAnimation:moveAnimation forKey:nil];
    self.spotlight = toSpotlight;
}
- (void) _moveDisappearToSpotlight:(EaseSpotlight *)toSpotlight duration:(NSTimeInterval)duration{
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        [self appearWithSpotlight:toSpotlight duration:duration];
        self.spotlight = toSpotlight;
    }];
    [self disappearWithDuration:duration];
    [CATransaction commit];
}
// 追加path，为了显示镂空的效果，需要使用 -bezierPathByReversingPath- 方法在一个path上再追加一个path
- (UIBezierPath *) _maskPath:(UIBezierPath *)path{
    
    UIBezierPath * tempPath = [UIBezierPath bezierPathWithRect:self.frame];
    [tempPath appendPath:[path bezierPathByReversingPath]];
    return tempPath;
}

#pragma mark - Layer Animation

- (CAAnimation *) appearAnimationWithSpotlight:(EaseSpotlight *)spotlight duration:(NSTimeInterval)duration{
    
    UIBezierPath * beginPath = [self _maskPath:spotlight.infinitesmalPath];
    UIBezierPath * endPath = [self _maskPath:spotlight.pathWrapper.path];
    return [self pathAnimaitonDuration:duration
                         withBeginPath:beginPath
                            andEndPath:endPath];
}

- (CAAnimation *) moveAnimationWithSpotlight:(EaseSpotlight *)spotlight duration:(NSTimeInterval)duration{
    
    UIBezierPath * endPath = [self _maskPath:spotlight.pathWrapper.path];
    return [self pathAnimaitonDuration:duration
                         withBeginPath:nil
                            andEndPath:endPath];
}
- (CAAnimation *) disappearAnimationWithSpotlight:(EaseSpotlight *)spotlight duration:(NSTimeInterval)duration{
    
    UIBezierPath * endPath = [self _maskPath:self.spotlight.infinitesmalPath];
    return [self pathAnimaitonDuration:duration
                         withBeginPath:nil
                            andEndPath:endPath];
}

- (CAAnimation *) pathAnimaitonDuration:(NSTimeInterval)duration withBeginPath:(UIBezierPath *)beginPath andEndPath:(UIBezierPath *)endPath{
    
    CABasicAnimation * pathAniamtion = [CABasicAnimation animationWithKeyPath:@"path"];
    if (!duration) {
        duration = self.defaultAnimationDuration;
    }
    pathAniamtion.duration = duration;
    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.66 :0 :0.33 :1];
    
    if (beginPath) {
        pathAniamtion.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    }
    pathAniamtion.toValue = (__bridge id _Nullable)(endPath.CGPath);
    pathAniamtion.removedOnCompletion = NO;
    pathAniamtion.fillMode = kCAFillModeForwards;
    return pathAniamtion;
}

#pragma mark - lazy

- (EaseSpotlight *)spotlight{
    if (!_spotlight) {
        _spotlight = [EaseSpotlight initialSpotlight];
    }
    return _spotlight;
}

- (CAShapeLayer *)maskLayer{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillRule = kCAFillRuleNonZero;
        _maskLayer.fillColor = [UIColor blackColor].CGColor;
    }
    return _maskLayer;
}
@end

