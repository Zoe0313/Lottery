//
//  LotteryCell.h
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-27.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *redBall1;
@property (weak, nonatomic) IBOutlet UILabel *redBall2;
@property (weak, nonatomic) IBOutlet UILabel *redBall3;
@property (weak, nonatomic) IBOutlet UILabel *redBall4;
@property (weak, nonatomic) IBOutlet UILabel *redBall5;
@property (weak, nonatomic) IBOutlet UILabel *redBall6;
@property (weak, nonatomic) IBOutlet UILabel *blueBall;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
