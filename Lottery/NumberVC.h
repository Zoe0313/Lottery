//
//  NumberVC.h
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LotteryCell;

@interface NumberVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) UINib *cellNib;
@property (strong, nonatomic) IBOutlet LotteryCell *mLotteryCell;

@end
