//
//  MeterTools.h
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeterPm2Msg.h"
#import "MeterAreaMsg.h"
#import "MeterProvicen.h"
#import "MeterWeekWeath.h"

@interface MeterTools : NSObject
@property(nonatomic)NSInteger currindex;

+(MeterTools *)shareInstance;
-(NSMutableArray *)getproince:(NSString *)request; //获取省份、县和市通用一个方法即可
-(NSString *)getareaweathState:(NSString *)request; //获得当前天气状况
-(NSMutableArray *)getweekWeath:(NSString *)request; //获取一周天气信息
-(NSMutableArray *)getdayPmValue:(NSString *)request; //获取当天空气质量和pm值
-(NSMutableArray *)getdayWeathSatte:(NSString *)request; //获取温度、降雨量等信息
@end
