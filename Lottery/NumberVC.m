//
//  NumberVC.m
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import "NumberVC.h"
#import "CLotteryInfo.h"
#import "LotteryCell.h"

@interface NumberVC (){
    NSMutableArray *dateArray;
    NSMutableArray *ballArray;
}

@end

@implementation NumberVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.mTableView setDelegate:self];
    [self.mTableView setDataSource:self];
    self.cellNib = [UINib nibWithNibName:@"LotteryCell" bundle:nil];
    
    [self.navigationItem setTitle:@"幸运号码"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnPressed)];
    
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    // 读档
    NSMutableDictionary* dic = [CLotteryInfo getLotteryInfo];
    int iItemCnt = [dic count]/8;
    
    dateArray = [[NSMutableArray alloc] initWithCapacity:iItemCnt];
    ballArray = [[NSMutableArray alloc] initWithCapacity:7*iItemCnt];
    
    for (int i = 1; i <= iItemCnt; i++)
    {
        NSString *strKey = [NSString stringWithFormat:@kKeyOfDateTime, i];
        [dateArray addObject:[dic objectForKey:strKey]];

        for (int j = 1; j <= 7; j++)
        {
            strKey = [NSString stringWithFormat:@kKeyOfBallInfo, i, j];
            [ballArray addObject:[dic objectForKey:strKey]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) rightBtnPressed{
    [self.mTableView setEditing:!self.mTableView.editing animated:YES];
    
    if(self.mTableView.editing){
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
    }
    else{
        [self.navigationItem.rightBarButtonItem setTitle:@"编辑"];
    }
}

#pragma mark - table view

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dateArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{    
    static NSString *CellID = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if(cell == nil)
    {
        [self.cellNib instantiateWithOwner:self options:nil];
        cell = self.mLotteryCell;
        
        // 获取所在行号
        NSUInteger row = indexPath.row;
        
        // 将时间填入自定义cell
        NSString *strDataTime = [dateArray objectAtIndex:row];
        [self.mLotteryCell.date setText:strDataTime];
        
        // 将7个球号填入自定义cell
        NSMutableArray *ballList = [[NSMutableArray alloc] initWithCapacity:7];
        int iIndex = row*7;
        for (int i = 0; i < 7; i++)
        {
            [ballList addObject:[ballArray objectAtIndex:iIndex + i]];
        }
        [self.mLotteryCell.redBall1 setText:[ballList objectAtIndex:0]];
        [self.mLotteryCell.redBall2 setText:[ballList objectAtIndex:1]];
        [self.mLotteryCell.redBall3 setText:[ballList objectAtIndex:2]];
        [self.mLotteryCell.redBall4 setText:[ballList objectAtIndex:3]];
        [self.mLotteryCell.redBall5 setText:[ballList objectAtIndex:4]];
        [self.mLotteryCell.redBall6 setText:[ballList objectAtIndex:5]];
        [self.mLotteryCell.blueBall setText:[ballList objectAtIndex:6]];
        
        cell = self.mLotteryCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 获取所在行号
    NSUInteger row = indexPath.row;
    
    // 删除该行的时间
    [dateArray removeObjectAtIndex:row];
    // 删除该行的7个球号
    NSRange range = NSMakeRange(row*7, 7);
    [ballArray removeObjectsInRange:range];
    
    // 存档
    [CLotteryInfo removeLotteryInfo:row];
    
    // 画面删除动画
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
