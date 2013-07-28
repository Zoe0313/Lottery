//
//  MachineVC.m
//  Lottery
//
//  Created by 刘 晓霞 on 13-7-24.
//  Copyright (c) 2013年 Lxx. All rights reserved.
//

#import "MachineVC.h"
#import "CLotteryInfo.h"
#import "NumberVC.h"

@interface MachineVC (){
    NSTimer *animateTimer;
    NSInteger imageIndex;
    BOOL bStartAnimate;
    NSInteger iStartPressCount;
    NSMutableArray *ballArray;
    NSMutableArray *redBallShakeArray;
    NSMutableArray *blueBallShakeArray;
}

@end

@implementation MachineVC

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
    [self.navigationItem setTitle:@"摇奖机"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 导航条右边"重置"button
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(resetBtnPressed:)];
    [rightItem setEnabled:NO];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    // 底部uitoolbar添加已摇奖球
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    for(int i = 0; i <= 6; i++)
    {
        UIImageView *ball = [[UIImageView alloc] initWithFrame:CGRectMake(i*30,20,27,27)];
        if(i == 6)// 蓝球
        {
            [ball setImage:[UIImage imageNamed:@"blueball.png"]];
        }
        else// 红球
        {
            [ball setImage:[UIImage imageNamed:@"redball.png"]];
        }
        
        // 球号label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,27,27)];
        [label setText:@""];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:15.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [ball addSubview:label];
        [ball setHidden:YES];
        
        UIBarButtonItem *ballItem = [[UIBarButtonItem alloc]initWithCustomView:ball];
        [buttons addObject: ballItem];
    }

    // 底部uitoolbar添加"收藏"button
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleBordered target:self action:@selector(collectPressed:)];
    [collectItem setEnabled:NO];
    [buttons addObject: collectItem];
    
    [self.mToolbar setItems: buttons animated:YES];
    
    // 摇奖button
    [self.startButton setFrame:CGRectMake(224, 330, 19, 33)];
    [self.startButton setEnabled:YES];
    
    // 初始红球动画图片
    UIImage *firstAnimate = [UIImage imageNamed:@"1.png"];
    [self.mAnimate setImage:firstAnimate];
    [self.mAnimate setAlpha:0.2];
    
    // 加载红球动画图片
    NSMutableArray *redShakeImage = [[NSMutableArray alloc] initWithCapacity:20];
    for (int i = 1; i <= 20; i++) {
        [redShakeImage addObject:[NSString stringWithFormat:@"%d.png", i]];
    }
    redBallShakeArray = redShakeImage;
    
    // 加载蓝球动画图片
    NSMutableArray *blueShakeImage = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 21; i <= 30; i++) {
        [blueShakeImage addObject:[NSString stringWithFormat:@"%d.png", i]];
    }
    blueBallShakeArray = blueShakeImage;
    
    // 动画计时器初始化
    bStartAnimate = false;
    iStartPressCount = 0;
    animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(startAnimate) userInfo:nil repeats:YES];
    
    ballArray = [[NSMutableArray alloc] initWithCapacity:7];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) resetBtnPressed:(id)sender {
    // 重置button不可按
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    // 开始摇奖button可按
    [self.startButton setEnabled:YES];
    
    NSArray *buttons = [self.mToolbar items];
    for (int i = 0; i <= 7; i++)
    {
        UIBarButtonItem *ballItem = [buttons objectAtIndex:i];
        if (i == 7)// 收藏button不可按
        {
            [ballItem setEnabled:NO];
        }
        else// 隐藏mToolbar上的奖球
        {
            UIImageView *ballImageView = (UIImageView*)ballItem.customView;
            UILabel *label = ballImageView.subviews[0];
            [label setText:@""];
            [ballImageView setHidden:YES];
        }
    }
    
    // 清空当前抽出奖球显示label
    [self.numberLabel setText:@""];
    
    // 初始红球动画图片
    UIImage *firstAnimate = [UIImage imageNamed:@"1.png"];
    [self.mAnimate setImage:firstAnimate];
    
    imageIndex = 0;
    bStartAnimate = false;
    iStartPressCount = 0;
    
    [ballArray removeAllObjects];
    ballArray = [[NSMutableArray alloc] initWithCapacity:7];
}

- (void) collectPressed:(id)sender {    
    // 存档 
    [CLotteryInfo setLotteryInfo:ballArray];
    
    [self resetBtnPressed:nil];
    
    NumberVC *numberVC = [[NumberVC alloc] initWithNibName:@"NumberVC" bundle:nil];
    [self.navigationController pushViewController:numberVC animated:YES];
    
    // 导航条左边"返回"button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    [backButton setTitle:@"返回"];
    self.navigationItem.backBarButtonItem = backButton;
}

- (IBAction)startButtonPressed:(id)sender {
    
    // 开始摇奖button不可按
    [self.startButton setEnabled:NO];
    
    // 摇出7个球后不可按
    iStartPressCount++;
    if(iStartPressCount > 7)
    {
        return;
    }
    
    // 清除摇奖器上显示球号
    [self.numberLabel setText:@""];
    
    // 开始动画播放
    bStartAnimate = true;
}


// 动画播放
- (void) startAnimate
{
    if(!bStartAnimate)
    {
        return;
    }
    
    int iImageCnt = 0;
    if(iStartPressCount == 7)
    {
        iImageCnt = [blueBallShakeArray count];
    }
    else
    {
        iImageCnt = [redBallShakeArray count];
    }
    
    // 图片切换下标
	imageIndex++;
	if (imageIndex >= iImageCnt)
    {
		imageIndex = 0;
        bStartAnimate = false;
        
        // 开始摇奖button可按
        if(iStartPressCount < 7)
        {
            [self.startButton setEnabled:YES];
        }
        
        // 随机一个奖球号
        NSInteger number = 0;
        if (iStartPressCount == 7)// 随机双色球的唯一一个蓝球号
        {
            number = arc4random() % 15 + 1;
            [self.numberLabel setTextColor:[UIColor blueColor]];
        }
        else// 随机双色球的六个红球号
        {
            number = arc4random() % 32 + 1;
            [self.numberLabel setTextColor:[UIColor redColor]];
        }
        
        NSString *strNumber = [NSString stringWithFormat:@"%d", number];
        
        // 摇奖器上显示当前摇出球号
        [self.numberLabel setText:strNumber];
        
        // 奖球号记录
        [ballArray addObject:strNumber];
        
        // 底部uitoolbar奖球更新
        NSArray *buttons = [self.mToolbar items];
        UIBarButtonItem *ballItem = [buttons objectAtIndex:iStartPressCount-1];
        UIImageView *ballImageView = (UIImageView*)ballItem.customView;
        UILabel *label = ballImageView.subviews[0];
        [label setText:strNumber];
        [ballImageView setHidden:NO];
        
        // 当7个球全摇出后，收藏button可按
        if (iStartPressCount == 7)
        {
            UIBarButtonItem *collectItem = [buttons objectAtIndex:7];
            [collectItem setEnabled:YES];
        }
        // 只要摇出第一个球，重置button就可按
        if (iStartPressCount == 1)
        {
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }
        return;
	}
    
    // 动画切换图片
    if(iStartPressCount == 7)
    {
        UIImage *image = [UIImage imageNamed:[blueBallShakeArray objectAtIndex:imageIndex]];
        [self.mAnimate setImage:image];
    }
    else
    {
        UIImage *image = [UIImage imageNamed:[redBallShakeArray objectAtIndex:imageIndex]];
        [self.mAnimate setImage:image];
    }
}
@end
