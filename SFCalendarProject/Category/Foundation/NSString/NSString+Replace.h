//
//  NSString+Replace.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/9.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Replace)

/**
 *  字符串替换
 *
 *  @param replaceCharacter 将要替换成的字符
 *  @param startIndex       开始替换的位置
 *  @param lastSaveCount    末尾不需要替换的字符数量
 *
 *  @return 返回替换后的字符串
 */
- (NSString *)replaceCharacter:(NSString *)replaceCharacter startIndex:(NSInteger)startIndex lastSaveCount:(NSInteger)lastIndex;

@end
