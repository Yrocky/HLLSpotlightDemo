//
//  HLLTest.m
//  HLLSpotlightDemo
//
//  Created by admin on 16/1/26.
//  Copyright © 2016年 HLL. All rights reserved.
//

#import "HLLTest.h"

@interface HLLTest ()

@property (nonatomic ,assign) NSInteger count;

@end
@implementation HLLTest

- (void)viewDidLoad{

    [super viewDidLoad];
    self.delegate = self;
    _count = 0;
    [self next:NO];
}

- (void) next:(BOOL)animation{

    switch (self.count) {
        case 0:
            self.spotlight = [[HLLSpotlight alloc] initSpotlightForOvalWithCenter:CGPointMake(345, 42) andWidth:40];
            break;
        case 1:{
            HLLSpotlight * spotlight = [[HLLSpotlight alloc] initSpotlightForOvalWithCenter:CGPointMake(296, 42) andWidth:35];
            [self.spotlightView moveToSpotlight:spotlight duration:.25 moveType:SpotlightMoveDirect];
        }
            break;
        case 2:{
            HLLSpotlight * spotlight = [[HLLSpotlight alloc] initSpotlightForRounedRectWithCenter:CGPointMake(375/2, 42) andSize:CGSizeMake(120, 40) andRadius:6];
            [self.spotlightView moveToSpotlight:spotlight duration:.25 moveType:SpotlightMoveDisappear];
        }
            break;
        case 3:
        {
            HLLSpotlight * spotlight = [[HLLSpotlight alloc] initSpotlightForOvalWithCenter:CGPointMake(375/2, 200) andWidth:220];
            [self.spotlightView moveToSpotlight:spotlight duration:.25 moveType:SpotlightMoveDisappear];
        }
            break;
        case 4:
            [self dismissViewControllerAnimated:animation completion:nil];
            break;
        default:
            break;
    }
    _count ++;
}
#pragma mark - HLLSpotlightDelegate

- (void) spotlightViewControllerDidTap:(HLLSpotlightViewController *)spotlightViewController{

    NSLog(@"tap");
    [self next:YES];
}
@end
