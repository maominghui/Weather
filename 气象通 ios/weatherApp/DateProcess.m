//
//  DateProcess.m
//  WeatherApp
//
//  Created by 520 on 14-6-22.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "DateProcess.h"

@implementation DateProcess
-(NSString *)dataHandleWith:(NSArray *)dateArray
{
    if([dateArray count]>0)
    {
      NSString *firstStr=[[dateArray objectAtIndex:0] substringToIndex:10];
      NSLog(@"data===%@",firstStr);
      NSString *lastStr=[[dateArray objectAtIndex:dateArray.count-1] substringWithRange:NSMakeRange(8,2)];
      NSLog(@"lastStr==%@",lastStr);
      firstStr=[firstStr stringByAppendingString:@","];
      firstStr=[firstStr stringByAppendingString:lastStr];
      firstStr=[firstStr stringByAppendingString:@"日气温变化图情况"];
      return firstStr;
    }else{
        return nil;
    }
}
-(NSString *)currentTime
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString *currentTime=[dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"===currentTime==%@",currentTime);
    return currentTime;
}
-(NSString *)currentDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *currentTime=[dateFormatter stringFromDate:[NSDate date]];
    NSString *currentTimeStr=[currentTime stringByAppendingString:@"日"];
    return currentTimeStr;
}
@end
