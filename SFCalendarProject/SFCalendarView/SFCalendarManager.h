//
//  SFCalendarManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFCalendarMacros.h"
#import "SFCalendarModel.h"
#import "SFCalendarItemModel.h"

typedef void (^SFCalendarItemUpdateBlock)(SFCalendarType type); // 数据更新通知

@interface SFCalendarManager : NSObject

+ (instancetype)shareInstance;

// 获取日期数据
- (NSArray<SFCalendarModel *> *)getCalendarData;

// 获取星期数据
- (SFCalendarModel *)getWeekdayData;

// 获取月份数据
- (SFCalendarModel *)getMonthData;

// 获取选中的日期
- (SFCalendarItemModel *)getSelectedItemModel;

// 获取选中的月份
- (SFCalendarItemModel *)getSelectedMonthModel;

// 根据滑动索引改变月份
- (void)updateSelectedMonthIndex:(NSInteger)index;

// 根据选中item改变数据
- (void)updateSelectedItemModel:(SFCalendarItemModel *)model;

// 选中日期或月份 回调
- (void)itemUpdateBlock:(SFCalendarItemUpdateBlock)block;

@end
