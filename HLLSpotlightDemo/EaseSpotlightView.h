//
//  EaseSpotlightView.h
//  HLLSpotlightDemo
//
//  Created by skynet on 2019/7/26.
//  Copyright © 2019 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EaseSpotlight;

static CGFloat EaseSpotlightDefaultMoveDuration = 0.25f;

typedef NS_ENUM(NSInteger, EaseSpotlightMoveType) {
    EaseSpotlightMoveDirect,///<平移镂空效果
    EaseSpotlightMoveDisappear///<消失再显示镂空效果
};

@interface EaseSpotlightView : UIView

- (void) setupInitialSpotlight:(EaseSpotlight *)initialSpotlight;

// appear
- (void) appearInitialSpotlightWithDuration:(NSTimeInterval)duration;///<从初始的spotlight开始出现
- (void) appearWithSpotlight:(nullable EaseSpotlight *)spotlight duration:(NSTimeInterval)duration;

// move
- (void) moveToSpotlight:(nonnull EaseSpotlight *)toSpotlight
                duration:(NSTimeInterval)duration
                moveType:(EaseSpotlightMoveType)moveType;
// disappear
- (void) disappearWithDuration:(NSTimeInterval)duration;

@end
NS_ASSUME_NONNULL_END
