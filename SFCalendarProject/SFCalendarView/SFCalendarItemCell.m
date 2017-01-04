//
//  SFCalendarItemCell.m
//  SFProjectTemplate
//
//  Created by sessionCh on 2016/12/29.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFCalendarItemCell.h"
#import "SFCalendarManager.h"

@interface SFCalendarItemCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UIButton *btn;

- (IBAction)btnClick:(UIButton *)sender;

@end

@implementation SFCalendarItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.hidden = YES;
}

- (void)setModel:(SFCalendarItemModel *)model
{
    if (model) {
        _model = model;
        
        self.lab.text = [NSString stringWithFormat:@"%ld", model.date.day];
        self.lab.font = [UIFont systemFontOfSize:17.0f];
        self.bgView.hidden = YES;
    
        switch (model.type) {
            case SFCalendarTypeUp:
            case SFCalendarTypeDown:
            {
                self.lab.textColor = [UIColor lightGrayColor];
                break;
            }
                
            case SFCalendarTypeCurrent:
            {
                if (model.isNowDay) {
                    self.lab.textColor = [self stringTOColor:@"#FB6267"];
                    self.lab.font = [UIFont boldSystemFontOfSize:17.0f];
                } else {
                    self.lab.textColor = [UIColor grayColor];
                }
                
                if (model.isSelected) {
                    
                    self.bgView.hidden = NO;
                    self.lab.textColor = [UIColor whiteColor];
                    self.lab.font = [UIFont systemFontOfSize:17.0f];
                    
                    // 添加简易动画
                    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    animation.duration = 0.15;
                    animation.repeatCount = 1;
                    animation.autoreverses = YES;
                    animation.fromValue = [NSNumber numberWithFloat:1.0];
                    animation.toValue = [NSNumber numberWithFloat:1.1];
                    [self.bgView.layer addAnimation:animation forKey:@"scale-layer"];
                    
                } else {
                    self.bgView.hidden = YES;
                }
                
                break;
            }
                
            case SFCalendarTypeWeek:
            {
                self.lab.text = model.weekday;
                self.lab.font = [UIFont systemFontOfSize:13.0f];
                self.lab.textColor = [UIColor lightGrayColor];
                
                break;
                
            }
                
            case SFCalendarTypeMonth:
            {
                self.lab.text = model.month;
                self.lab.font = [UIFont systemFontOfSize:17.0f];

                if (model.isSelected) {
                    self.lab.textColor = [self stringTOColor:@"#FB6267"];
                } else {
                    self.lab.textColor = [UIColor grayColor];
                }
                break;
            }
                
            default:
                
                self.lab.textColor = [UIColor redColor];
                break;
        }
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    [[SFCalendarManager shareInstance] updateSelectedItemModel:self.model];
}

- (UIColor *)stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

@end
