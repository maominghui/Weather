//
//  MeterAreaMsg.h
//  Meteorological_app
//
//  Created by zhao on 14-6-24.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeterAreaMsg : NSObject
@property(nonatomic,strong)NSString  *temperature; //温度
@property(nonatomic,strong)NSString  *windDirandStr; //风向风力
@property(nonatomic,strong)NSString  *precipitation;//降水
@property(nonatomic,strong)NSString  *releasedate; //发布日期

-(id)initWithtemp:(NSString *)thetemp andDir:(NSString *)windir andpreciption:(NSString *)thepre anddate:(NSString *)thedate;

@end
