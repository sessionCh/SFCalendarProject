//
//  UIView+TransitionAnimation.h
//  LogisticsCloudProject
//
//  Created by 123 on 15/6/30.
//  Copyright (c) 2015年 zngoo. All rights reserved.
//  转场动画

/**
 * 使用该类别需要添加QuartzCore.framework
 */
#import <UIKit/UIKit.h>

/**动画效果*/
typedef enum
{
    ZGTransitionAnimationTypeCameraIris,
    //相机
    ZGTransitionAnimationTypeCube,
    //立方体
    ZGTransitionAnimationTypeFade,
    //淡入
    ZGTransitionAnimationTypeMoveIn,
    //移入
    ZGTransitionAnimationTypeOglFilp,
    //翻转
    ZGTransitionAnimationTypePageCurl,
    //翻去一页
    ZGTransitionAnimationTypePageUnCurl,
    //添上一页
    ZGTransitionAnimationTypePush,
    //平移
    ZGTransitionAnimationTypeReveal,
    //移走
    ZGTransitionAnimationTypeRippleEffect,
    ZGTransitionAnimationTypeSuckEffect
}ZGTransitionAnimationType;

/**动画方向*/
typedef enum
{
    ZGTransitionAnimationTowardFromLeft,
    ZGTransitionAnimationTowardFromRight,
    ZGTransitionAnimationTowardFromTop,
    ZGTransitionAnimationTowardFromBottom
}ZGTransitionAnimationToward;


@interface UIView (TransitionAnimation)


//为当前视图添加切换的动画效果
//参数是动画类型和方向
//如果要切换两个视图，应将动画添加到父视图
- (void)setTransitionAnimationType:(ZGTransitionAnimationType)transtionAnimationType toward:(ZGTransitionAnimationToward)transitionAnimationToward duration:(NSTimeInterval)duration;


@end
