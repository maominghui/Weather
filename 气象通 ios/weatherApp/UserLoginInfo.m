//
//  UserLoginInfo.m
//  WeatherApp
//
//  Created by 520 on 14-6-23.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "UserLoginInfo.h"
#import "UserLoginInfoCache.h"
@implementation UserLoginInfo
@synthesize loginCount,account,areaname;
@synthesize userId,username;
-(id)initWithLoginInfoCount:(NSString *)countStr andAccount:(NSString *)accountStr andAreaName:(NSString *)areanameStr andUserId:(NSString *)userIdStr andUserName:(NSString *)usernameStr
{
    self.loginCount=countStr;
    self.account=accountStr;
    self.areaname=areanameStr;
    self.userId=userIdStr;
    self.username=usernameStr;
    NSDictionary *userDic=[NSDictionary dictionaryWithObjectsAndKeys:countStr,@"count",accountStr,@"account",areanameStr,@"areaname",userIdStr,@"userId",usernameStr,@"username",nil];
    [UserLoginInfo initNSDictionary:userDic];
    return self;
}
+(void)initNSDictionary:(NSDictionary *)userDic;
{
    [[UserLoginInfoCache alloc] saveUserLoginInfo:userDic];
}
@end
