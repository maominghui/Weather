
//
//  UserLoginInfoCache.m
//  WeatherApp
//
//  Created by 520 on 14-6-23.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "UserLoginInfoCache.h"
#define UserLoginKey @"1"
@implementation UserLoginInfoCache
-(void)saveUserLoginInfo:(NSDictionary *)dic
{
    NSLog(@"userInfo======");
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    [setting setObject:dic forKey:UserLoginKey];
    [setting synchronize];
}
-(NSDictionary *)getUserLoginInfo
{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    NSDictionary *userDic=[setting objectForKey:UserLoginKey];
    return userDic;
}
@end
