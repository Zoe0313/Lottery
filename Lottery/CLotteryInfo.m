//
//  CLotteryInfo.m
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-26.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import "CLotteryInfo.h"


static NSUInteger g_iInfoCount = 0;

@implementation CLotteryInfo

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void) setLotteryInfo:(NSMutableArray*) ballList
{
    g_iInfoCount++;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 当前时间的存档
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDateInfo = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString* strKey = [NSString stringWithFormat:@kKeyOfDateTime, g_iInfoCount];
    [defaults setObject:strDateInfo forKey:strKey];
    
    // 当前收集球号的存档
    for (int i = 1; i <= 7; i++)
    {
        strKey = [NSString stringWithFormat:@kKeyOfBallInfo, g_iInfoCount, i];
        [defaults setObject:[ballList objectAtIndex:i-1] forKey:strKey];
    }
    
    [defaults synchronize];
}

+ (NSMutableDictionary*) getLotteryInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (int i = 1; i <= g_iInfoCount; i++)
    {
        NSString* strKey = [NSString stringWithFormat:@kKeyOfDateTime, i];
        NSString* strDateInfo = [defaults objectForKey:strKey];
        
        [dic setObject:strDateInfo forKey:strKey];
        
        for (int j = 1; j <= 7; j++)
        {
            strKey = [NSString stringWithFormat:@kKeyOfBallInfo, i, j];
            NSString* strNumber = [defaults objectForKey:strKey];
            
            [dic setObject:strNumber forKey:strKey];
        }
    }

    return dic;
}

+ (void) removeLotteryInfo: (NSUInteger)index
{
    if(index >= g_iInfoCount)
    {
        return;
    }
    
    // 读出所有的信息
    NSMutableDictionary* dic = [CLotteryInfo getLotteryInfo];
    int iItemCnt = [dic count]/8;
    
    NSMutableArray *dateArray = [[NSMutableArray alloc] initWithCapacity:iItemCnt-1];
    NSMutableArray *ballArray = [[NSMutableArray alloc] initWithCapacity:7*(iItemCnt-1)];
    
    for (int i = 1; i <= iItemCnt; i++)
    {
        if (i - 1 == index) {// 过滤要删除的那项
            continue;
        }
        
        NSString *strKey = [NSString stringWithFormat:@kKeyOfDateTime, i];
        [dateArray addObject:[dic objectForKey:strKey]];
        
        for (int j = 1; j <= 7; j++)
        {
            strKey = [NSString stringWithFormat:@kKeyOfBallInfo, i, j];
            [ballArray addObject:[dic objectForKey:strKey]];
        }
    }
    
    // 存入处理好的信息
    g_iInfoCount--;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
    for (int i = 1; i <= g_iInfoCount; i++)
    {
        // 当前时间的存档
        NSString* strKey = [NSString stringWithFormat:@kKeyOfDateTime, i];
        NSString* strDateInfo = [dateArray objectAtIndex:i-1];
        [defaults setObject:strDateInfo forKey:strKey];
        
        // 当前收集球号的存档
        for (int j = 1; j <= 7; j++)
        {
            strKey = [NSString stringWithFormat:@kKeyOfBallInfo, i, j];
            NSString* strNumber = [ballArray objectAtIndex:(i-1)*7+j-1];
            [defaults setObject:strNumber forKey:strKey];
        }
    }

    [defaults synchronize];
}

@end