//
//  SFCalendarItemModel.h
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFCalendarMacros.h"

@interface SFCalendarItemModel : NSObject

@property (nonatomic, assign) BOOL isNowDay;            // 是否当天
@property (nonatomic, assign) BOOL isSelected;          // 是否选中
@property (nonatomic, assign) NSInteger index;          // 索引
@property (nonatomic, assign) SFCalendarType type;  // 类型

// 日期属性
@property (nonatomic, strong) NSDate *date;             // 当前日期

// 星期属性
@property (nonatomic, copy) NSString *weekday;          // 星期

// 月份属性
@property (nonatomic, copy) NSString *month;            // 月份
@property (nonatomic, copy) NSString *year;             // 年份

@end
