//
//  MeterWeekWeath.m
//  Meteorological_app
//
//  Created by NyistMacBook on 14-6-25.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MeterWeekWeath.h"

@implementation MeterWeekWeath
@synthesize weekWeathDate,weekWeathImgname,weekWeathTemp;

-(id)initWithdate:(NSString *)thedate andname:(NSString *)thename andtemp:(NSString *)theTemp
{
    
    MeterWeekWeath  *weekWeath = [[MeterWeekWeath alloc] init];
    weekWeath.weekWeathDate = thedate;
    weekWeath.weekWeathImgname = thename;
    weekWeath.weekWeathTemp = theTemp;
    return weekWeath;
}

@end
