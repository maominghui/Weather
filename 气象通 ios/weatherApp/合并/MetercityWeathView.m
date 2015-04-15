//
//  MetercityWeathView.m
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MetercityWeathView.h"

@implementation MetercityWeathView
@synthesize currCode,tmpLabel,weathState,windandWater,repushDate,pageview,weekWeathView;
@synthesize weekWeathBtn,areaName,shadowView;

- (id)initWithFrame:(CGRect)frame andwithCode:(NSString *)thecode andareaName:(NSString *)thename andcityid:(NSString *)thecityid
{
    self = [super initWithFrame:frame];
    if (self) {
        
        shadowView = [[UIView alloc] initWithFrame:CGRectMake(180,iphone5?220:200,60,80)];
        shadowView.layer.cornerRadius = 6;
        shadowView.layer.masksToBounds = YES;
        shadowView.backgroundColor = [UIColor grayColor];
        shadowView.alpha = 0.5;
        
        currCode = [[NSString alloc] initWithString:thecode];
        tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(40,10,100,100)];
        tmpLabel.textColor = [UIColor whiteColor];
        tmpLabel.font = [UIFont systemFontOfSize:30];
        
        weathState = [[UILabel alloc] initWithFrame:CGRectMake(40,95,100,30)];
        weathState.textColor = [UIColor whiteColor];
        weathState.font = [UIFont systemFontOfSize:15];
        
        windandWater = [[UILabel alloc] initWithFrame:CGRectMake(40,130,200,30)];
        windandWater.textColor = [UIColor whiteColor];
        windandWater.font = [UIFont systemFontOfSize:15];
        
        repushDate = [[UILabel alloc] initWithFrame:CGRectMake(40,165,200,30)];
        repushDate.textColor = [UIColor whiteColor];
        repushDate.font = [UIFont systemFontOfSize:15];

        pageview = [[Meterviewofpage alloc] initWithFrame:CGRectMake(180,iphone5?220:200,60,80) andcityid:thecityid];
       
       
        weekWeathBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        weekWeathBtn.backgroundColor = [UIColor redColor];
        [weekWeathBtn setFrame:CGRectMake(40,iphone5?380:290,240,20)];
        
        weekWeathView = [[MeterWeekweathView alloc] initWithFrame:weekWeathBtn.frame andcode:currCode];
        [self addSubview:shadowView];
        [self addSubview:tmpLabel];
        [self addSubview:weathState];
        [self addSubview:windandWater];
        [self addSubview:repushDate];
        [self addSubview:pageview];
        [self addSubview:weekWeathBtn];
        [self addSubview:weekWeathView];
        [self sendRequestWithCode:thecode andareaName:thename andcityid:thecityid];
    }

    return self;
}

-(void)sendRequestWithCode:(NSString *)thecode andareaName:(NSString *)thename andcityid:(NSString *)thecityid
{
     //再次发送请求
    // [self clear];
     [pageview reloadDatawithAreaCode:thecode andareaname:thename andcityid:thecityid];
     [weekWeathView reloadWeekWeathWithData:thecode];
     NSString *requestUrl = nil;
     requestUrl = [NSString stringWithFormat:@"%@%@",DAYWEATHSTATEADDRESS,thecode];
     [[AFNYClient sharedClient] postPath:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
        NSString *State = [[MeterTools shareInstance] getareaweathState:operation.responseString];
        [weathState  setText:State];
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
     }];

     requestUrl = [NSString stringWithFormat:@"%@%@",DAYWEATHADDRESS,thecode];
     [[AFNYClient sharedClient] postPath:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSMutableArray *temparr = [[MeterTools shareInstance] getdayWeathSatte:operation.responseString];
         if ([temparr count]>0) {

             MeterAreaMsg  *tempWeath = [temparr objectAtIndex:0];
             [tmpLabel setText:tempWeath.temperature];
             [windandWater setText:[NSString stringWithFormat:@"%@  %@",tempWeath.windDirandStr,tempWeath.precipitation]];
             [repushDate  setText:tempWeath.releasedate];
         }
         
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)clear
{

    tmpLabel.text = @"";
    weathState.text = @"";
    windandWater.text = @"";
    repushDate.text = @"";
    
}

@end
