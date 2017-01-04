//
//  NSString+Number.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "NSString+Number.h"

@implementation NSString (Number)

/**
 *  数字转字符串
 */
+ (NSString *)stringFromFloatValue:(float)floatValue
{
    NSNumber *floatNumber = [NSNumber numberWithFloat:floatValue];
    return [floatNumber stringValue];
}

+ (NSString *)stringFromDoubleValue:(double)doubleValue
{
    NSNumber *doubleNumber = [NSNumber numberWithDouble:doubleValue];
    return [doubleNumber stringValue];
}

+ (NSString *)stringFromLongValue:(long)longValue
{
    NSNumber *longNumber = [NSNumber numberWithLong:longValue];
    return [longNumber stringValue];
}

+ (NSString *)stringFromLongLongValue:(long long)longLongValue
{
    NSNumber *longLongNumber = [NSNumber numberWithLongLong:longLongValue];
    return [longLongNumber stringValue];
}

@end
