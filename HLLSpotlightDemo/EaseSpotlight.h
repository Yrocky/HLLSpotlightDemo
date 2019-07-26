//
//  EaseSpotlight.h
//  HLLSpotlightDemo
//
//  Created by skynet on 2019/7/26.
//  Copyright © 2019 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EaseSpotlightPath : NSObject{
    UIBezierPath *_path;
    CGPoint _center;
    CGRect _frame;
}
@property (nonatomic ,strong ,readonly) UIBezierPath * path;

///<椭圆（圆、椭圆）
+ (instancetype) ovalPathCenter:(CGPoint)center size:(CGSize)size;

///<矩形（正方形、长方形）
+ (instancetype) rectanglePathCenter:(CGPoint)center size:(CGSize)size;
+ (instancetype) rectanglePathCenter:(CGPoint)center size:(CGSize)size radius:(CGFloat)raduis;
+ (instancetype) rectanglePathCenter:(CGPoint)center size:(CGSize)size radius:(CGFloat)raduis corners:(UIRectCorner)corners;

///<贝塞尔曲线
+ (instancetype) bezierPath:(UIBezierPath *)path;

- (CGRect) frame;
@end

@interface EaseSpotlight : NSObject

// 初始
+ (instancetype) initialSpotlight;

+ (instancetype) spotlightWithPath:(EaseSpotlightPath *)path;
- (instancetype) initWithPath:(EaseSpotlightPath *)path;

@property (nonatomic ,strong ,readonly) EaseSpotlightPath * pathWrapper;

@property (nonatomic ,strong ,readonly) UIBezierPath * infinitesmalPath;

@end

NS_ASSUME_NONNULL_END
