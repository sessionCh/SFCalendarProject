//
//  SFCalendarCell.m
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFCalendarCell.h"
#import "SFCalendarItemCell.h"
#import "SFCalendarManager.h"

@interface SFCalendarCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SFCalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:@"SFCalendarItemCell" bundle:nil] forCellWithReuseIdentifier:@"SFCalendarItemCell"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)updateUI
{
    [self.collectionView reloadData];
}

- (UICollectionView *)getCollectionView
{
    return self.collectionView;
}

- (void)setModel:(SFCalendarModel *)model
{
    if (model) {
        _model = model;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionView Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFCalendarItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SFCalendarItemCell" forIndexPath:indexPath];
    
    cell.model = self.model.dataArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == SFCalendarCellTypeHeader) {
        
        return CGSizeMake(self.collectionView.width / 7, self.collectionView.height);
    } else if (self.type == SFCalendarCellTypeTop) {
        
        return CGSizeMake(self.collectionView.width / 5, self.collectionView.height);
    }
    
    return CGSizeMake(self.collectionView.width / 7, self.collectionView.height / 6);
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

@end
