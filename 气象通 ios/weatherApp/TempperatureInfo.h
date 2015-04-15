//
//  TempperatureInfo.h
//  WeatherApp
//
//  Created by 520 on 14-6-22.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempperatureInfo : NSObject
@property (nonatomic,retain)NSString *maxTemp;//最高气温
@property (nonatomic,retain)NSString *temp;//气温
@property (nonatomic,retain)NSString *minTemp;//最低气温;
@property (nonatomic,retain)NSString *obsTime;//时次
-(id)initWithTempperature:(NSString *)maxTempStr andTemp:(NSString *)tempStr andMintempStr:(NSString *)minTempStr andObsTime:(NSString *)obsTimeStr;
@end
