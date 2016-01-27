//
//  ViewController.m
//  HLLSpotlightDemo
//
//  Created by admin on 16/1/25.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self addMask];
    return;
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self.view addSubview:view];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
    label.text = @"sdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdfsdfddgdgdfgdf";
    label.numberOfLines = 0;
//    label.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [view addSubview:label];
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:label.bounds];
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100) cornerRadius:30] bezierPathByReversingPath]];
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor blackColor].CGColor;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    maskLayer.path = path.CGPath;
    [view.layer setMask:maskLayer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        UIBezierPath * path = [UIBezierPath bezierPathWithRect:label.bounds];
        UIBezierPath * toPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(150, 300, 100, 50) cornerRadius:15];
        [path appendPath:[toPath bezierPathByReversingPath]];
        
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.toValue = (__bridge id _Nullable)(path.CGPath);
        animation.duration = 1.34;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.66 :0 :0.33 :1];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [maskLayer addAnimation:animation forKey:nil];
    });
}
- (void)addMask{
    UIButton * _maskButton = [[UIButton alloc] init];
    [_maskButton setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_maskButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [self.view addSubview:_maskButton];
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    // MARK: circlePath
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH / 2, 300) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    // MARK: roundRectanglePath
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 400, SCREEN_WIDTH - 2 * 20, 100) cornerRadius:15] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    [_maskButton.layer setMask:shapeLayer];
}
@end
