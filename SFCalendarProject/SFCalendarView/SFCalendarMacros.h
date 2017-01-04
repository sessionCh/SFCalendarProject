//
//  SFCalendarMacros.h
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#ifndef SFCalendarMacros_h
#define SFCalendarMacros_h


#import "NSDate+Extension.h"
#import "UIView+Frame.h"

// WeakSelf
#define WeakSelf __weak __typeof(&*self)weakSelf_SC = self;

// 显示月份数目
#define KCalendarMonthCount 18

typedef NS_ENUM(NSInteger, SFCalendarType) {
    SFCalendarTypeUnknown,                  // 未定义
    SFCalendarTypeUp,                       // 上月
    SFCalendarTypeCurrent,                  // 当前月
    SFCalendarTypeDown,                     // 下月
    SFCalendarTypeWeek,                     // 表示星期选项
    SFCalendarTypeMonth,                    // 表示点击月份
    SFCalendarTypeItemSlide,                // 表示滑动日期
    SFCalendarTypeTopSlide,                 // 表示头部滑动
};

#endif /* SFCalendarMacros_h */
