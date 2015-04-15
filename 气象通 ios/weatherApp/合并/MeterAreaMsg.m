//
//  MeterAreaMsg.m
//  Meteorological_app
//
//  Created by zhao on 14-6-24.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterAreaMsg.h"

@implementation MeterAreaMsg
@synthesize temperature,windDirandStr,precipitation,releasedate;

-(id)initWithtemp:(NSString *)thetemp andDir:(NSString *)windir andpreciption:(NSString *)thepre anddate:(NSString *)thedate
{

    MeterAreaMsg  *dayweath = [[MeterAreaMsg alloc] init];
    dayweath.temperature = thetemp;
    dayweath.windDirandStr = windir;
    dayweath.precipitation = thepre;
    dayweath.releasedate = thedate;
    return dayweath;
}

@end
