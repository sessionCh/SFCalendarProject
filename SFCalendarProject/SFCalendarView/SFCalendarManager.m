//
//  SFCalendarManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFCalendarManager.h"

@interface SFCalendarManager ()

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSArray<SFCalendarModel *> *dataArray;    // 日期数据模型
@property (nonatomic, strong) SFCalendarModel *headerModel;             // 头部数据模型
@property (nonatomic, strong) SFCalendarModel *topModel;                // 顶部数据模型
@property (nonatomic, strong) SFCalendarItemModel *selectedItemModel;   // 当前被选中的日期
@property (nonatomic, strong) SFCalendarItemModel *selectedMonthModel;  // 当前被选中的月份

@property (nonatomic, copy) SFCalendarItemUpdateBlock block;

@end

@implementation SFCalendarManager

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Setter/Getter

- (NSDate *)date
{
    if (!_date) {
        
        // 获得时间对象
        NSDate *date = [NSDate date];
        // 获得系统的时区
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        // 当前时间与系统格林尼治时间的差
        NSTimeInterval time = [zone secondsFromGMTForDate:date];
        // 当前系统准确的时间
        _date = [date dateByAddingTimeInterval:time];
        
//        // 测试
//        _date = [[_date dateAfterMonth:1] lastdayOfMonth];

        NSLog(@"---[当前时间：%@]---", _date);
    }
    return _date;
}

// 获取日期数据
- (NSArray<SFCalendarModel *> *)getCalendarData
{
    return self.dataArray;
}

// 获取星期数据
- (SFCalendarModel *)getWeekdayData
{
    return self.headerModel;
}

// 获取月份数据
- (SFCalendarModel *)getMonthData
{
    return self.topModel;
}

// 获取选中的日期
- (SFCalendarItemModel *)getSelectedItemModel
{
    return self.selectedItemModel;
}

// 获取选中的月份
- (SFCalendarItemModel *)getSelectedMonthModel
{
    return self.selectedMonthModel;
}

- (NSArray<SFCalendarModel *> *)dataArray
{
    if (!_dataArray) {
        
        NSMutableArray *mDataArray = [NSMutableArray arrayWithCapacity:0];
        
        for (NSInteger i = 0; i < KCalendarMonthCount; i++) {
            
            NSMutableArray *mItemArray = [NSMutableArray arrayWithCapacity:0];
            
            // 当月
            NSDate *curDate = [self.date dateAfterMonth:i];
            // 当月大小
            NSInteger curMonthSize = [curDate daysInMonth];
            
            // 当月第一天
            NSDate *beginDate = [curDate begindayOfMonth];
            // 当月第一天对应的星期
            NSInteger weekIndex = beginDate.weekday;
            
            // 当月第一天如果是周日，默认从第二排开始
            NSInteger upSize = weekIndex == 1 ? 7 : weekIndex - 1;
            
            // 当月第一天日期前移 upSize 天，得到当月记录的第一天（从上月开始记录）
            NSDate *startDate = [beginDate dateAfterDay:-upSize];
            
            // 记录游标
            NSInteger cursor = 0;
            
            // 记录上月日期部分
            for (NSInteger j = 0; j < upSize; j++, cursor++) {
                
                SFCalendarItemModel *item = [[SFCalendarItemModel alloc] init];
                item.index = i;                 // 设置索引
                item.date = [startDate dateAfterDay:cursor];
                item.type = SFCalendarTypeUp;
                [mItemArray addObject:item];
            }
            
            // 记录当月日期部分
            for (NSInteger jj = 0; jj < curMonthSize; jj++, cursor++) {
                
                SFCalendarItemModel *item = [[SFCalendarItemModel alloc] init];
                item.index = i;                 // 设置索引
                item.date = [startDate dateAfterDay:cursor];
                item.type = SFCalendarTypeCurrent;
                
                if ([item.date isSameDay:self.date]) { // 判断是否是今天
                    
                    item.isNowDay = YES;
                    self.selectedItemModel = item;
                    self.selectedItemModel.isSelected = YES;
                }
                
                [mItemArray addObject:item];
            }
            
            // 记录下月日期部分
            NSInteger downSize = 42 - upSize - curMonthSize;      // 剩下天数
            for (NSInteger jjj = 0; jjj < downSize; jjj++, cursor++) {
                
                SFCalendarItemModel *item = [[SFCalendarItemModel alloc] init];
                item.index = i;                 // 设置索引
                item.date = [startDate dateAfterDay:cursor];
                item.type = SFCalendarTypeDown;
                [mItemArray addObject:item];
            }
            
            SFCalendarModel *model = [[SFCalendarModel alloc] init];
            model.index = i;                                        // 设置索引
            model.number = curDate.month;                           // 设置当前月
            model.dataArray = mItemArray.copy;                      // 设置当月日期
            
            [mDataArray addObject:model];
        }
        
        // 设置数据
        _dataArray = mDataArray.copy;
    }
    return _dataArray;
}

- (SFCalendarModel *)headerModel
{
    if (!_headerModel) {
        _headerModel = [[SFCalendarModel alloc] init];
        
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        
        NSArray *weekdays = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        
        for (NSInteger i = 1; i <= 7; i++) {
            SFCalendarItemModel *item = [[SFCalendarItemModel alloc] init];
            item.weekday = weekdays[i - 1];
            item.type = SFCalendarTypeWeek;
            
            [dataArray addObject:item];
        }
        _headerModel.dataArray = dataArray.copy;
    }
    return _headerModel;
}

- (SFCalendarModel *)topModel
{
    if (!_topModel) {
        _topModel = [[SFCalendarModel alloc] init];
        
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        
        
        for (NSInteger i = 0; i < KCalendarMonthCount; i++) {
            SFCalendarItemModel *item = [[SFCalendarItemModel alloc] init];
            // 获取下一月
            NSDate *upDate = [self.date dateAfterMonth:i];
            item.index = i;
            item.month = [NSString stringWithFormat:@"%ld月", upDate.month];
            item.year = [NSString stringWithFormat:@"%ld", upDate.year];
            item.type = SFCalendarTypeMonth;
            
            if (i == 0) {
                item.isSelected = YES;
                self.selectedMonthModel = item;
            }
            
            [dataArray addObject:item];
        }
        _topModel.dataArray = dataArray.copy;
    }
    return _topModel;
}

#pragma mark - Update

// 根据滑动索引改变月份
- (void)updateSelectedMonthIndex:(NSInteger)index
{
    if (index != self.selectedMonthModel.index) {
        
        // 更新数据
        self.selectedMonthModel.isSelected = NO;
        SFCalendarItemModel *item = self.topModel.dataArray[index];
        item.isSelected = YES;
        self.selectedMonthModel = item;
        
        // 通知回调
        if (self.block) {
            self.block(SFCalendarTypeItemSlide);
        }
    }
}

// 根据选中item改变数据
- (void)updateSelectedItemModel:(SFCalendarItemModel *)model
{
    if (model && model != self.selectedItemModel) {
                
        // 如果点击上月或下月图标，滚动到对应页面
        switch (model.type) {
                
            case SFCalendarTypeCurrent:
            {
                SFCalendarItemModel *oldModel = self.selectedItemModel;
                oldModel.isSelected = NO;
                SFCalendarItemModel *newModel = model;
                newModel.isSelected = YES;
                
                self.selectedItemModel = newModel;
                
                if (self.block) {
                    self.block(SFCalendarTypeCurrent);
                }
                
                NSLog(@"---[当前选中：%@  上次选中：%@]---", newModel.date.formatYMD, oldModel.date.formatYMD);

                break;
            }
                
            case SFCalendarTypeUp:
            {
                if (model.index > 0) { // 第一个月除外
                    
                    // 获取上月数据
                    SFCalendarModel *upModel = self.dataArray[model.index - 1];
                    WeakSelf
                    [upModel.dataArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(SFCalendarItemModel * _Nonnull upItem, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([upItem.date isSameDay:model.date] &&
                            upItem.type == SFCalendarTypeCurrent) { // 前一月对应的日期
                            SFCalendarItemModel *oldModel = weakSelf_SC.selectedItemModel;
                            oldModel.isSelected = NO;
                            SFCalendarItemModel *newModel = upItem;
                            newModel.isSelected = YES;
                            
                            weakSelf_SC.selectedItemModel = newModel;
                            
                            if (weakSelf_SC.block) {
                                weakSelf_SC.block(SFCalendarTypeUp);
                            }
                            
                            NSLog(@"---[当前选中：%@  上次选中：%@]---", newModel.date.formatYMD, oldModel.date.formatYMD);

                            return ;
                        }
                     }];
                }
                
                break;
            }
                
            case SFCalendarTypeDown:
            {
                if (model.index < KCalendarMonthCount - 1) { // 最后一个月除外
                    
                    // 获取上月数据
                    SFCalendarModel *downModel = self.dataArray[model.index + 1];
                    WeakSelf
                    [downModel.dataArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(SFCalendarItemModel * _Nonnull downItem, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ([downItem.date isSameDay:model.date] &&
                            downItem.type == SFCalendarTypeCurrent) { // 前一月对应的日期
                            SFCalendarItemModel *oldModel = weakSelf_SC.selectedItemModel;
                            oldModel.isSelected = NO;
                            SFCalendarItemModel *newModel = downItem;
                            newModel.isSelected = YES;
                            
                            weakSelf_SC.selectedItemModel = newModel;
                            
                            if (weakSelf_SC.block) {
                                weakSelf_SC.block(SFCalendarTypeDown);
                            }

                            NSLog(@"---[当前选中：%@  上次选中：%@]---", newModel.date.formatYMD, oldModel.date.formatYMD);

                            return ;
                        }
                    }];
                }
                break;
            }
               
            case SFCalendarTypeMonth:
            {
                if (model.index != self.selectedMonthModel.index) {
                    
                    // 更新数据
                    self.selectedMonthModel.isSelected = NO;
                    SFCalendarItemModel *item = self.topModel.dataArray[model.index];
                    item.isSelected = YES;
                    self.selectedMonthModel = item;
                    
                    // 通知回调
                    if (self.block) {
                        self.block(SFCalendarTypeMonth);
                    }
                }
                
                NSLog(@"---[当前选中的月份：%@]---", model.month);
            
                break;
            }
                
            default:
                
                break;
        }
    }
}

#pragma mark - Block

// 选中日期或月份回调
- (void)itemUpdateBlock:(SFCalendarItemUpdateBlock)block
{
    self.block = block;
}

@end
