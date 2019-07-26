//
//  EaseSpotlightController.h
//  HLLSpotlightDemo
//
//  Created by skynet on 2019/7/26.
//  Copyright © 2019 HLL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EaseSpotlight;
@class EaseSpotlightView;
@class EaseSpotlightController;

@protocol EaseSpotlightControllerDelegate <NSObject>

- (void) easeSpotlightControllerDidTapNextStep:(EaseSpotlightController *)spotlightController;
@end

@interface EaseSpotlightController : UIViewController{
    EaseSpotlightView *_spotlightView;
    UIView *_contentView;
    NSInteger _stepIndex;
    
    BOOL _needNextStepButton;///<default YES
    BOOL _needSkipButton;///<default YES
}
@property (nonatomic ,weak) id<EaseSpotlightControllerDelegate> delegate;

- (void) setupSpotlight;
- (EaseSpotlight *) initialSpotlight;
- (void) nextSpolight;

@end

NS_ASSUME_NONNULL_END
