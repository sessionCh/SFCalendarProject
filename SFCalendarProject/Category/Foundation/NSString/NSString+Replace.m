//
//  NSString+Replace.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/9.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "NSString+Replace.h"

@implementation NSString (Replace)

/**
 *  字符串替换
 *
 *  @param replaceCharacter 将要替换成的字符
 *  @param startIndex       开始替换的位置
 *  @param lastSaveCount    末尾不需要替换的字符数量
 *
 *  @return 返回替换后的字符串
 */
- (NSString *)replaceCharacter:(NSString *)replaceCharacter startIndex:(NSInteger)startIndex lastSaveCount:(NSInteger)lastSaveCount
{
    NSMutableString *newStr = [[NSMutableString alloc] initWithFormat:@""];
    NSString *temp = nil;
    NSInteger length = [self length];
    for(int i = 0; i < length; i++) {
        
        if (i >= startIndex && i < length - lastSaveCount) { // 手机号中间替换为星号
            [newStr appendString:replaceCharacter];
        } else {
            temp = [self substringWithRange:NSMakeRange(i, 1)];
            [newStr appendString:temp];
        }
    }
    return newStr;
}

@end
