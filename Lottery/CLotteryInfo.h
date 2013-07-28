//
//  CLotteryInfo.h
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-26.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kKeyOfBallInfo "%d_ballInfo%d"
#define kKeyOfDateTime "%d_dateTime"

@interface CLotteryInfo : NSObject

+ (void) setLotteryInfo:(NSMutableArray*) ballList;
+ (NSMutableDictionary*) getLotteryInfo;
+ (void) removeLotteryInfo: (NSUInteger)index;
@end
