//
//  EaseSpotlightController.m
//  HLLSpotlightDemo
//
//  Created by skynet on 2019/7/26.
//  Copyright © 2019 HLL. All rights reserved.
//

#import "EaseSpotlightController.h"
#import "EaseSpotlightView.h"

@class EaseInternalSpotlightTransition;
@protocol EaseInternalSpotlightTransitionDelegate <NSObject>

- (void) animationTransitionWillPresentViewController:(EaseInternalSpotlightTransition *)animationTransition
                                    transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void) animationTransitionWillDismissViewController:(EaseInternalSpotlightTransition *)animationTransition
                                    transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
@end

@interface EaseInternalSpotlightTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic ,weak) id<EaseInternalSpotlightTransitionDelegate> delegate;
@property (nonatomic ,assign ,getter=isPresent) BOOL present;
@end

@interface EaseSpotlightController ()<UIViewControllerTransitioningDelegate,
EaseInternalSpotlightTransitionDelegate>
@property (nonatomic ,strong) UIButton * nextStepButton;
@property (nonatomic ,strong) UIButton * skipButton;
@property (nonatomic ,strong) EaseInternalSpotlightTransition * transition;
@end

@implementation EaseSpotlightController
- (void)dealloc{
    NSLog(@"[Spotlight] dealloc");
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self _commonInit];
    }
    return self;
}
- (void) _commonInit{
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.transitioningDelegate = self;
}

- (void) viewDidLoad{
    
    [super viewDidLoad];
    [self setupSpotlight];
    [self spotlight_setupSpotlightView];
    [self spotlight_setupContentView];
    [self spotlight_tapGesture];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void) setupSpotlight{
    
    _stepIndex = 0;
    _needSkipButton = _needNextStepButton = YES;
}

- (void) spotlight_setupSpotlightView{
    
    _spotlightView = [[EaseSpotlightView alloc] initWithFrame:self.view.bounds];
    _spotlightView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0.00 alpha:0.5];
    _spotlightView.userInteractionEnabled = NO;
    [self.view insertSubview:_spotlightView atIndex:0];
    
    [_spotlightView setupInitialSpotlight:[self initialSpotlight]];
}

- (void) spotlight_setupContentView{
    
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.restorationIdentifier = @"EaseSpotlightController.contentView";
    _contentView.userInteractionEnabled = NO;
    [self.view addSubview:_contentView];
    
    if (_needNextStepButton) {
        [self.view addSubview:self.nextStepButton];
        self.nextStepButton.frame = (CGRect){
            self.view.frame.size.width - 70,
            CGRectGetMaxY(self.view.frame) - 80,
            50,20
        };
    }
    
    if (_needSkipButton) {
        [self.view addSubview:self.skipButton];
        self.skipButton.frame = (CGRect){
            self.view.frame.size.width - 70,
            60,
            50,20
        };
    }
}

- (void) spotlight_tapGesture{
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_spotlightTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - API

- (EaseSpotlight *)initialSpotlight{
    return nil;
}

- (void) nextSpolight{
    _stepIndex ++;
}

#pragma mark - Action

- (void) _spotlightTapGesture:(UITapGestureRecognizer *)tapRecognizer{
    
    [self nextSpolight];
    if ([self.delegate respondsToSelector:@selector(easeSpotlightControllerDidTapNextStep:)]) {
        [self.delegate easeSpotlightControllerDidTapNextStep:self];
    }
}

#pragma mark - lazy

- (EaseInternalSpotlightTransition *)transition{
    if (!_transition) {
        _transition = [[EaseInternalSpotlightTransition alloc] init];
        _transition.delegate = self;
    }
    return _transition;
}

- (UIButton *)nextStepButton {
    if (!_nextStepButton) {
        _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [_nextStepButton  setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7]
                               forState:UIControlStateNormal];
        [_nextStepButton addTarget:self action:@selector(nextSpolight)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}

- (UIButton *)skipButton{
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton setTitle:@"skip >>" forState:UIControlStateNormal];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        [_skipButton  setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7]
                               forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(onSkip)
                  forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (void) onSkip{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - EaseInternalSpotlightTransitionDelegate

// present
- (void)animationTransitionWillPresentViewController:(EaseInternalSpotlightTransition *)animationTransition transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    [_spotlightView appearWithSpotlight:nil duration:[animationTransition transitionDuration:transitionContext]];
}
// dismiss
- (void)animationTransitionWillDismissViewController:(EaseInternalSpotlightTransition *)animationTransition transitionContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    [_spotlightView disappearWithDuration:[animationTransition transitionDuration:transitionContext]];
}

#pragma mark - UIViewControllerTransitioningDelegate
// Dismiss
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    self.transition.present = NO;
    return self.transition;
}
// Presented
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.transition.present = YES;
    return self.transition;
}
@end

@implementation EaseInternalSpotlightTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .250f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.isPresent) {
        [self _animationTransitionForPresent:transitionContext];
    }else{
        [self _animationTransitionForDismiss:transitionContext];
    }
}

// pressent
- (void) _animationTransitionForPresent:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView * containerView = transitionContext.containerView;
    
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    toViewController.view.alpha = 0.0f;
    [fromViewController viewWillDisappear:YES];
    [toViewController viewWillAppear:YES];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        toViewController.view.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [toViewController viewDidAppear:YES];
        [fromViewController viewDidDisappear:YES];
        [transitionContext completeTransition:YES];
    }];
    if ([self.delegate respondsToSelector:@selector(animationTransitionWillPresentViewController:transitionContext:)]) {
        [self.delegate animationTransitionWillPresentViewController:self transitionContext:transitionContext];
    }
    
}
// dismiss
- (void) _animationTransitionForDismiss:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [fromViewController viewWillDisappear:YES];
    [toViewController viewWillAppear:YES];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        fromViewController.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [toViewController viewDidAppear:YES];
        [fromViewController viewDidDisappear:YES];
        [transitionContext completeTransition:YES];
    }];
    if ([self.delegate respondsToSelector:@selector(animationTransitionWillDismissViewController:transitionContext:)]) {
        [self.delegate animationTransitionWillDismissViewController:self transitionContext:transitionContext];
    }
}
@end
