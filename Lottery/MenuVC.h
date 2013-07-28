//
//  MenuVC.h
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
- (IBAction)machineNumberPressed:(id)sender;
- (IBAction)luckyNumberPressed:(id)sender;
- (IBAction)helpPressed:(id)sender;
@end
