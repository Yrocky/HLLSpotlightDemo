//
//  EaseTestViewController.m
//  HLLSpotlightDemo
//
//  Created by skynet on 2019/7/26.
//  Copyright © 2019 HLL. All rights reserved.
//

#import "EaseTestViewController.h"
#import "EaseSpotlight.h"
#import "EaseSpotlightView.h"

@interface EaseTestViewController ()
@end

@implementation EaseTestViewController

#pragma mark - override

- (void)setupSpotlight{
    [super setupSpotlight];
    _needNextStepButton = NO;
}

- (EaseSpotlight *)initialSpotlight{
    return [EaseSpotlight spotlightWithPath:({
        [EaseSpotlightPath ovalPathCenter:CGPointMake(145, 200) size:CGSizeMake(145, 50)];
    })];
}

- (void)nextSpolight{
    [super nextSpolight];
    if (_stepIndex == 1) {
        [_spotlightView moveToSpotlight:({
            [EaseSpotlight spotlightWithPath:({
                [EaseSpotlightPath ovalPathCenter:CGPointMake(300, 300) size:CGSizeMake(100, 100)];
            })];
        }) duration:EaseSpotlightDefaultMoveDuration moveType:EaseSpotlightMoveDirect];
    } else if (_stepIndex == 2) {
        [_spotlightView moveToSpotlight:({
            [EaseSpotlight spotlightWithPath:({
                [EaseSpotlightPath ovalPathCenter:CGPointMake(200, 300) size:CGSizeMake(80, 80)];
            })];
        }) duration:EaseSpotlightDefaultMoveDuration moveType:EaseSpotlightMoveDirect];
    } else if (_stepIndex == 3) {
        [_spotlightView moveToSpotlight:({
            [EaseSpotlight spotlightWithPath:({
                [EaseSpotlightPath rectanglePathCenter:CGPointMake(100, 200) size:CGSizeMake(100, 70)];
            })];
        }) duration:EaseSpotlightDefaultMoveDuration moveType:EaseSpotlightMoveDirect];
    } else if (_stepIndex == 4){
        [_spotlightView moveToSpotlight:({
            [EaseSpotlight spotlightWithPath:({
                [EaseSpotlightPath rectanglePathCenter:CGPointMake(150, 200) size:CGSizeMake(150, 90) radius:10];
            })];
        }) duration:EaseSpotlightDefaultMoveDuration moveType:EaseSpotlightMoveDirect];
    } else if (_stepIndex == 5){
        [_spotlightView moveToSpotlight:({
            [EaseSpotlight spotlightWithPath:({
                
                UIBezierPath* aPath = [UIBezierPath bezierPath];
                aPath.lineWidth = 5.0;
                
                aPath.lineCapStyle = kCGLineCapRound; //线条拐角
                aPath.lineJoinStyle = kCGLineCapRound; //终点处理
                
                // Set the starting point of the shape.
                [aPath moveToPoint:CGPointMake(100.0, 50.0)];
                
                // Draw the lines
                [aPath addLineToPoint:CGPointMake(200.0, 140.0)];
                [aPath addLineToPoint:CGPointMake(160, 240)];
                [aPath addLineToPoint:CGPointMake(40.0, 240)];
                [aPath addLineToPoint:CGPointMake(0.0, 140.0)];
                [aPath closePath];//第五条线通过调用closePath方法得到的
                
                [aPath stroke];//Draws line 根据坐标点连线
                
                [EaseSpotlightPath bezierPath:aPath];
            })];
        }) duration:EaseSpotlightDefaultMoveDuration moveType:EaseSpotlightMoveDisappear];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
