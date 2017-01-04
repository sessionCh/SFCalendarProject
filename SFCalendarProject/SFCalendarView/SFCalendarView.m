
//
//  SFCalendarView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFCalendarView.h"
#import "SFCalendarCell.h"
#import "SFCalendarManager.h"

@interface SFCalendarView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UIView *topRightViewContent;

@property (weak, nonatomic) IBOutlet UIView *headerViewContent;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) SFCalendarCell *headerView;
@property (nonatomic, strong) SFCalendarCell *topRightView;

@property (nonatomic, strong) NSArray<SFCalendarModel *> *dataArray;
@property (nonatomic, strong) SFCalendarModel *headerModel;
@property (nonatomic, strong) SFCalendarModel *topRightModel;

@end

@implementation SFCalendarView

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:@"SFCalendarCell" bundle:nil] forCellWithReuseIdentifier:@"SFCalendarCell"];
    
    // 设置月份
    self.topRightView = [[[NSBundle mainBundle] loadNibNamed:@"SFCalendarCell" owner:nil options:nil] firstObject];
    self.topRightView.type = SFCalendarCellTypeTop;
    self.topRightView.model = self.topRightModel;
    UICollectionView *collectionView = [self.topRightView getCollectionView];
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.scrollEnabled = YES;

    [self.topRightViewContent addSubview:self.topRightView];
    
    // 设置cell头部
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"SFCalendarCell" owner:nil options:nil] firstObject];
    
    self.headerView.type = SFCalendarCellTypeHeader;
    self.headerView.model = self.headerModel;
    
    [self.headerViewContent addSubview:self.headerView];
    
    SFCalendarItemModel *selectedItem = [[SFCalendarManager shareInstance] getSelectedMonthModel];
    // 设置年份
    self.topLab.text = selectedItem.year;
    
    // 数据发生改变，更新视图
    WeakSelf
    [[SFCalendarManager shareInstance] itemUpdateBlock:^(SFCalendarType type) {
        
        [weakSelf_SC.collectionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([view isKindOfClass:[SFCalendarCell class]]) {
                SFCalendarCell *cell = view;
                [cell updateUI];
            }
        }];
        
        
        switch (type) {
                
            case SFCalendarTypeCurrent:
            {
                
                break;
            }
                
            case SFCalendarTypeUp:
            case SFCalendarTypeDown:
            {
                // 刷新cell
                SFCalendarItemModel *selectedItem = [[SFCalendarManager shareInstance] getSelectedItemModel];
                if (selectedItem.index >= 0 && selectedItem.index < KCalendarMonthCount) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedItem.index inSection:0];
                    [weakSelf_SC.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
                }
                break;
            }
                
            case SFCalendarTypeMonth:
            {
                SFCalendarItemModel *selectedItem = [[SFCalendarManager shareInstance] getSelectedMonthModel];

                // 设置年份
                weakSelf_SC.topLab.text = selectedItem.year;

                // 刷新cell
                if (selectedItem.index >= 0 && selectedItem.index < KCalendarMonthCount) {
                    
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedItem.index inSection:0];
                    [weakSelf_SC.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
                    
                    [[weakSelf_SC.topRightView getCollectionView] scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

                }
                [weakSelf_SC.topRightView updateUI];

                break;
            }
                
            case SFCalendarTypeItemSlide:  // 更新头部
            {
                SFCalendarItemModel *selectedItem = [[SFCalendarManager shareInstance] getSelectedMonthModel];
                
                // 设置年份
                weakSelf_SC.topLab.text = selectedItem.year;

                // 刷新cell
                if (selectedItem.index >= 0 && selectedItem.index < KCalendarMonthCount) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedItem.index inSection:0];
                    [[weakSelf_SC.topRightView getCollectionView] scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
                }
                
                [weakSelf_SC.topRightView updateUI];
         
                break;
            }
                
            default:
                break;
        }
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutIfNeeded];
    self.headerView.frame = self.headerViewContent.bounds;
    self.topRightView.frame = self.topRightViewContent.bounds;
}

#pragma mark - Setter/Getter

- (SFCalendarModel *)topRightModel
{
    if (!_topRightModel) {
        _topRightModel = [[SFCalendarManager shareInstance] getMonthData];
    }
    return _topRightModel;
}

- (SFCalendarModel *)headerModel
{
    if (!_headerModel) {
        _headerModel = [[SFCalendarManager shareInstance] getWeekdayData];
    }
    return _headerModel;
}

- (NSArray<SFCalendarModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[SFCalendarManager shareInstance] getCalendarData];
    }
    return _dataArray;
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFCalendarCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.width, self.collectionView.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [[SFCalendarManager shareInstance] updateSelectedMonthIndex:currentPage];
}

@end
