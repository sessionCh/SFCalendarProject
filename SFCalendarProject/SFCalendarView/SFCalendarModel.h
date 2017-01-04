//
//  SFCalendarModel.h
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFCalendarItemModel.h"

@interface SFCalendarModel : NSObject

@property (nonatomic, assign) NSInteger number;                           // 月
@property (nonatomic, assign) NSInteger index;                            // 索引
@property (nonatomic, strong) NSArray<SFCalendarItemModel *> *dataArray;  // 本月数据

@end
