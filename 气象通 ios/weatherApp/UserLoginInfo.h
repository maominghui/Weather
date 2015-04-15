//
//  UserLoginInfo.h
//  WeatherApp
//
//  Created by 520 on 14-6-23.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLoginInfo : NSObject
@property (nonatomic,retain) NSString *loginCount;
@property (nonatomic,retain) NSString *account;
@property (nonatomic,retain) NSString *areaname;
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *username;
-(id)initWithLoginInfoCount:(NSString *)countStr andAccount:(NSString *)accountStr andAreaName:(NSString *)areanameStr andUserId:(NSString *) userIdStr andUserName:(NSString *)usernameStr;
+(void)initNSDictionary:(NSDictionary *)userDic;
@end
