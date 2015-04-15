//
//  MeterWeathViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

//    [[AFNYClient sharedClient] postPath:STrUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        NSLog(@"*****:%@",operation);
//        NSLog(@"list=========data:%@",operation.responseString);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//    }];


#import "MeterWeathViewController.h"

@interface MeterWeathViewController ()
@end

@implementation MeterWeathViewController
@synthesize meterBackImg,leftbtn,rightbtn,weathScrolView,sqlvalue;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    sqlvalue = [[sqltestlist alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"图片标题.png"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    meterBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,iphone5?480:370)];
    [meterBackImg  setImage:[UIImage imageNamed:@"首页背景无字.png"]];
    [self.view addSubview:meterBackImg];
    [self  createNaviBaritems];
    [self  createScrollView];
}

-(void)createScrollView
{
    weathScrolView = [[MeterScrollVIew alloc] initWithFrame:CGRectMake(0,0,320,iphone5?480:370) andCountyArr:[[MeterSQLMag shareinstance] displayData]];
    weathScrolView.delegate = self;
    [self.view addSubview:weathScrolView];
}

#pragma --Mark MeterScrollViewDelegate Method --
-(void)EScrollerCountychanged:(NSString *)countyname andareacode:(NSString *)thecode
{
    NSString  *str = [[NSString alloc] initWithString:thecode];
    NSLog(@"8888888888:%@",thecode);
    MeterTrendViewController *trendVC = [[MeterTrendViewController alloc] init];
    trendVC.currAreaCode = str;
    MeterLiveViewController *liveVC = [[MeterLiveViewController alloc] init];
    liveVC.currAreaCode = str;
    [leftbtn setTitle:countyname forState:UIControlStateNormal];
    [leftbtn setTitle:countyname forState:UIControlStateSelected];
}

-(void)createNaviBaritems
{
    leftbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    leftbtn.titleLabel.font =[UIFont systemFontOfSize:15];
    leftbtn.titleLabel.textColor = [UIColor whiteColor];
    if ([[[MeterSQLMag shareinstance] displayData] count]>0) {
        
        sqlvalue = [[[MeterSQLMag shareinstance] displayData] objectAtIndex:0];
        [leftbtn  setTitle:sqlvalue.countyName forState:UIControlStateNormal];
        [leftbtn  setTitle:sqlvalue.countyName forState:UIControlStateSelected];
    }else {
        
         [leftbtn  setTitle:@"城市选择" forState:UIControlStateNormal];
         [leftbtn  setTitle:@"城市选择" forState:UIControlStateSelected];
    }
    
    [leftbtn  setFrame:CGRectMake(0,0,150,40)];
    [leftbtn  addTarget:self action:@selector(citySelectbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [leftbtn setImageEdgeInsets:UIEdgeInsetsMake(0,-20, 0, 10)];
    UIImage *img = [UIImage imageNamed:@"location2.png"];
    [leftbtn setImage:img forState:UIControlStateNormal];
    UIBarButtonItem   *leftBarbtn = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftBarbtn;
    
    rightbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightbtn  setFrame:CGRectMake(0,0,40,40)];
    [rightbtn  addTarget:self action:@selector(refreshBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [rightbtn setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [rightbtn setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateSelected];
    UIBarButtonItem   *rightBarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightBarbtn;
}

-(void)citySelectbtnClicked:(UIButton *)btn
{
    MeterCitySelectViewController  *cityVC = [[MeterCitySelectViewController alloc] init];
    [self.navigationController pushViewController:cityVC animated:NO];
}

-(void)refreshBtnClicked:(UIButton *)btn
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    [weathScrolView  reloadScrollViewWithCountArr:[[MeterSQLMag shareinstance] displayData]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
