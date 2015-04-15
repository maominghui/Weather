//
//  MeterWeekweathView.m
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MeterWeekweathView.h"

@implementation MeterWeekweathView
@synthesize subView,frameBtn,tableList,currCode;

- (id)initWithFrame:(CGRect)frame andcode:(NSString *)code
{
    self = [super initWithFrame:frame];
    if (self) {
        
        currCode = [[NSString alloc] initWithString:code];
        subView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,iphone5?390:300)];
        subView.backgroundColor = [UIColor grayColor];
        subView.tag = 0;
        UIButton  *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn  setFrame:CGRectMake(40,2,240,20)];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.backgroundColor = [UIColor redColor];
        [subView addSubview:cancelBtn];
        tableList = [[MeterBaseTableview alloc] initWithFrame:CGRectMake(0,18,320,subView.frame.size.height-cancelBtn.frame.size.height) andDataArr:[[NSMutableArray alloc] init]];
        [tableList setTableTag:6];
        [subView addSubview:tableList];
        frameBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [frameBtn setFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        [frameBtn addTarget:self action:@selector(frameBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:frameBtn];
        [self  reloadWeekWeathWithData:currCode];
    }
    
    return self;
}

-(void)reloadWeekWeathWithData:(NSString *)currcode
{
    currCode = currcode;
    NSString  *requestURL = [NSString stringWithFormat:@"%@%@",WEEKWEATHADDRESS,currCode];
    [[AFNYClient sharedClient] postPath:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        [tableList relodataWithArray:[[MeterTools shareInstance] getweekWeath:operation.responseString]];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
}

-(void)cancelBtnClicked:(UIButton *)btn
{
    if (subView!=nil) {
        
        subView.tag = 0;
        [subView  removeFromSuperview];
    }
}

-(void)frameBtnClicked:(UIButton *)btn
{

    if (subView.tag == 0) {
        
        subView.tag = 1;
        [self.superview addSubview:subView];
    }
}

@end
