//
//  AFNYClient.m
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "AFNYClient.h"

#define  STrUrl @"http://pcc.scqx.gov.cn/jfids/data/GridData.svt?sqlid=PhoneService.selectCurWeather1&areacode=510100000"
@implementation AFNYClient
+ (AFNYClient *)sharedClient
{

    static AFNYClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFNYClient alloc] initWithBaseURL:[NSURL URLWithString:STrUrl]];
    });
    
    return _sharedClient;

}

@end
