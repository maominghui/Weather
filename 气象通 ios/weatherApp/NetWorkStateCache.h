//
//  NetWorkStateCache.h
//  WeatherApp
//
//  Created by 520 on 14-6-23.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkStateCache : NSObject
-(void)saveNetWorkState:(int)netWorkState;
-(int)getNetWorkState;
@end
