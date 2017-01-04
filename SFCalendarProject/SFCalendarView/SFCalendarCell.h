//
//  SFCalendarCell.h
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCalendarModel.h"

typedef NS_ENUM(NSInteger, SFCalendarCellType) {
    SFCalendarCellTypeUnknown,          // 未定义
    SFCalendarCellTypeTop,              // 表示头部
    SFCalendarCellTypeHeader,           // 表示头部
    SFCalendarCellTypeCell              // 表示cell
};

@interface SFCalendarCell : UICollectionViewCell

@property (nonatomic, strong) SFCalendarModel *model;
@property (nonatomic, assign) SFCalendarCellType type;

- (void)updateUI;
- (UICollectionView *)getCollectionView;

@end
