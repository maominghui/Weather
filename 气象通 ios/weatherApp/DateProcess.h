//
//  DateProcess.h
//  WeatherApp
//
//  Created by 520 on 14-6-22.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateProcess : NSObject
-(NSString *)dataHandleWith:(NSArray *)dateArray;
-(NSString *)currentTime;
-(NSString *)currentDate;
@end
