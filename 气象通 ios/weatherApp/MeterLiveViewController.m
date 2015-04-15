//
//  MeterLiveViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterLiveViewController.h"
#import "MeterView.h"
#import "Tool.h"
#import "WeatherClient.h"
#import "AFHTTPRequestOperation.h"
#import "TempperatureInfo.h"
#define TEMP24API @"http://pcc.scqx.gov.cn/jfids/data/GridData.svt?sqlid=PhoneService.selectTemp24&areacode="
@interface MeterLiveViewController ()

@end

@implementation MeterLiveViewController
@synthesize temp24Array,currAreaCode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    currAreaCode = [[NSString alloc] init];
    self.navigationController.navigationBar.hidden=YES;
    
}
-(void)getRequest
{
    MeterView *view=[[MeterView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    NSMutableArray *hightTempPoint = [[NSMutableArray alloc]init];//高温数组
    NSMutableArray *lowTempPoint=[[NSMutableArray alloc] init];//低温数组
    // 横轴
    NSMutableArray *hArr=[[NSMutableArray alloc] init]; //横轴日期集合
    //生成随机点
    for(int i=0;i<[temp24Array count];i++)
    {
        TempperatureInfo *tempInfo=[temp24Array objectAtIndex:i];
        [hightTempPoint addObject:[NSValue valueWithCGPoint:CGPointMake(30+i*10,[tempInfo.maxTemp floatValue]*10)]];//高温点集合
        [lowTempPoint addObject:[NSValue valueWithCGPoint:CGPointMake(30+i*10,[tempInfo.minTemp floatValue]*10)]];//低温点集合
        [hArr addObject:[NSString stringWithFormat:@"%@",tempInfo.obsTime]];
    }
    //竖轴
    NSMutableArray *vArr=[[NSMutableArray alloc] init];
    for(int i=0;i<12;i++)
    {
        [vArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [view setHDesc:hArr];
    [view setVDesc:vArr];
    [view setHightArrayPoint:hightTempPoint];
    [view setLowArrayPoint:lowTempPoint];
    [self.view addSubview:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currAreaCode = @"510100000";

    self.view.backgroundColor=[UIColor blackColor];
    temp24Array=[NSMutableArray new];
    NSString  *requestUrl = [NSString stringWithFormat:@"%@%@",TEMP24API,currAreaCode];
    [[WeatherClient sharedClient] getPath:requestUrl parameters:[NSDictionary dictionaryWithObjectsAndKeys:nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        temp24Array=[Tool getPast24temperature:operation.responseString];
        [self getRequest];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求数据失败：%@",error);
    }];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
