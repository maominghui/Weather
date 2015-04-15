//
//  Config.h
//  WeatherApp
//
//  Created by 520 on 14-6-24.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
@property BOOL isNetworkRunning;

+(Config *) Instance;
+(id)allocWithZone:(NSZone *)zone;

@end
