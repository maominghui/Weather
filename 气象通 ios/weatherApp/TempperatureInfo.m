//
//  TempperatureInfo.m
//  WeatherApp
//
//  Created by 520 on 14-6-22.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "TempperatureInfo.h"

@implementation TempperatureInfo
@synthesize maxTemp,minTemp,temp,obsTime;
-(id)initWithTempperature:(NSString *)maxTempStr andTemp:(NSString *)tempStr andMintempStr:(NSString *)minTempStr andObsTime:(NSString *)obsTimeStr
{
    self.maxTemp=maxTempStr;
    self.temp=tempStr;
    self.minTemp=minTempStr;
    self.obsTime=obsTimeStr;
    return self;
}
@end
