//
//  AFNYClient.m
//  WeatherApp
//
//  Created by 520 on 14-6-22.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "WeatherClient.h"

@implementation WeatherClient

+(WeatherClient *)sharedClient
{
    static WeatherClient *sharedClient=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{sharedClient =[[WeatherClient alloc] initWithBaseURL:[NSURL URLWithString:API]];
    });
    return sharedClient;
}
@end
