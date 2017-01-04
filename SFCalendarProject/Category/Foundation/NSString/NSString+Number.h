//
//  NSString+Number.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Number)

/**
 *  数字转字符串
 */
+ (NSString *)stringFromFloatValue:(float)floatValue;
+ (NSString *)stringFromDoubleValue:(double)doubleValue;
+ (NSString *)stringFromLongValue:(long)longValue;
+ (NSString *)stringFromLongLongValue:(long long)longLongValue;

@end
