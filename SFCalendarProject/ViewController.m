//
//  ViewController.m
//  SFCalendarProject
//
//  Created by sessionCh on 2017/1/3.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

#import "ViewController.h"
#import "SFCalendarManager.h"
#import "SFCalendarView.h"

@interface ViewController ()

@property (nonatomic, strong) SFCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.calendarView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SFCalendarView *)calendarView
{
    if (!_calendarView) {
        
        _calendarView = [[[NSBundle mainBundle] loadNibNamed:@"SFCalendarView" owner:nil options:nil] firstObject];
        _calendarView.frame = CGRectMake(0, 100.0f, self.view.width, 350.f);
    }
    
    return _calendarView;
}

@end
