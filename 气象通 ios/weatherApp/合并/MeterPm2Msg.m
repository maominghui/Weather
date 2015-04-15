//
//  MeterPm2Msg.m
//  Meteorological_app
//
//  Created by zhao on 14-6-26.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterPm2Msg.h"

@implementation MeterPm2Msg
@synthesize imgName,quality,pm2str;
-(id)initWithimg:(NSString *)thename andthequality:(NSString *)thequality andpm2:(NSString *)thepm
{
  
    MeterPm2Msg *pmMsg = [[MeterPm2Msg alloc] init];
    pmMsg.imgName = thename;
    pmMsg.quality = thequality;
    pmMsg.pm2str = thepm;
    return pmMsg;
}

@end
