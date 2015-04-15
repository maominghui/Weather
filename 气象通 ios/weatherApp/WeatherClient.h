//
//  AFNYClient.h
//  WeatherApp
//
//  Created by 520 on 14-6-22.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "AFHTTPClient.h"


@interface WeatherClient : AFHTTPClient
+(WeatherClient *)sharedClient;


@end
