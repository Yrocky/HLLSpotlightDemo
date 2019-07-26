//
//  EaseSpotlight.m
//  HLLSpotlightDemo
//
//  Created by skynet on 2019/7/26.
//  Copyright © 2019 HLL. All rights reserved.
//

#import "EaseSpotlight.h"

CG_INLINE CGRect EaseRectMake(CGPoint center, CGSize size) {
    return (CGRect){
        center.x - size.width/2,
        center.y - size.height/2,
        size
    };
}

CG_INLINE CGPoint EaseRectCenter(CGRect frame) {
    return (CGPoint){
        CGRectGetMidX(frame),
        CGRectGetMidY(frame)
    };
}

@interface EaseSpotlight ()

@end

@implementation EaseSpotlight

+ (instancetype) spotlightWithPath:(EaseSpotlightPath *)path{
    return [[self alloc] initWithPath:path];
}

- (instancetype) initWithPath:(EaseSpotlightPath *)path{
    self = [super init];
    if (self) {
        _pathWrapper = path;
    }
    return self;
}

+ (instancetype)initialSpotlight{
    return [self spotlightWithPath:[EaseSpotlightPath ovalPathCenter:CGPointZero size:CGSizeZero]];
}

- (UIBezierPath *)infinitesmalPath{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:({
        EaseRectMake(EaseRectCenter(self.pathWrapper.frame), CGSizeZero);
    }) cornerRadius:0];
    return path;
}

@end

@implementation EaseSpotlightPath

+ (instancetype) ovalPathCenter:(CGPoint)center size:(CGSize)size{
    EaseSpotlightPath * path = [EaseSpotlightPath new];
    path->_center = center;
    path->_frame = EaseRectMake(center, size);
    path->_path = [UIBezierPath bezierPathWithOvalInRect:path.frame];
    return path;
}

+ (instancetype) rectanglePathCenter:(CGPoint)center size:(CGSize)size{
    return [self rectanglePathCenter:center size:size radius:0.0f];
}

+ (instancetype) rectanglePathCenter:(CGPoint)center size:(CGSize)size radius:(CGFloat)raduis{
    return [self rectanglePathCenter:center size:size radius:raduis corners:UIRectCornerAllCorners];
}

+ (instancetype) rectanglePathCenter:(CGPoint)center size:(CGSize)size radius:(CGFloat)raduis corners:(UIRectCorner)corners{
    EaseSpotlightPath * path = [EaseSpotlightPath new];
    path->_center = center;
    path->_frame = EaseRectMake(center, size);
    path->_path = [UIBezierPath bezierPathWithRoundedRect:path.frame
                                        byRoundingCorners:corners
                                              cornerRadii:CGSizeMake(raduis, raduis)];
    return path;
}

+ (instancetype)bezierPath:(UIBezierPath *)path{
    EaseSpotlightPath * pathWrapper = [EaseSpotlightPath new];
    pathWrapper->_path = path;
    pathWrapper->_frame = path.bounds;
    return pathWrapper;
}

- (CGRect) frame{
    return _frame;
}
@end
