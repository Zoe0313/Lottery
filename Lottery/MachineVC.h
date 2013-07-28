//
//  MachineVC.h
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MachineVC : UIViewController
@property (weak, nonatomic) IBOutlet UIToolbar *mToolbar;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mAnimate;
@end
