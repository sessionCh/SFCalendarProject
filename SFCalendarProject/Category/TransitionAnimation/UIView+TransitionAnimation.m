
//
//  UIView+TransitionAnimation.m
//  LogisticsCloudProject
//
//  Created by 123 on 15/6/30.
//  Copyright (c) 2015年 zngoo. All rights reserved.
//

#import "UIView+TransitionAnimation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (TransitionAnimation)

- (void)setTransitionAnimationType:(ZGTransitionAnimationType)transtionAnimationType toward:(ZGTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration
{
    CATransition * transition = [CATransition animation];
    transition.duration = duration;
    NSArray * animations = @[@"cameraIris",
                             @"cube",
                             @"fade",
                             @"moveIn",
                             @"oglFlip",
                             @"pageCurl",
                             @"pageUnCurl",
                             @"push",
                             @"reveal",
                             @"rippleEffect",
                             @"suckEffect"];
    NSArray * subTypes = @[@"fromLeft", @"fromRight", @"fromTop", @"fromBottom"];
    transition.type = animations[transtionAnimationType];
    transition.subtype = subTypes[transitionAnimationToward];
    
    [self.layer addAnimation:transition forKey:nil];
}

@end
