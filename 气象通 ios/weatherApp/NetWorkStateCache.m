//
//  NetWorkStateCache.m
//  WeatherApp
//
//  Created by 520 on 14-6-23.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "NetWorkStateCache.h"
#define NETSTATE @"网络状态"
@implementation NetWorkStateCache
-(void)saveNetWorkState:(int)netWorkState
{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    NSString *netWork=[NSString stringWithFormat:@"%d",netWorkState];
    [setting setObject:netWork forKey:NETSTATE];
    [setting synchronize];
}
-(int)getNetWorkState
{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    NSString *netWork=[setting objectForKey:NETSTATE];
    return [netWork intValue];
}
@end
