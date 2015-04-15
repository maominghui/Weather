//
//  MeterProvicen.m
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MeterProvicen.h"

@implementation MeterProvicen
@synthesize provinceName,provinceId;

-(id)initWithName:(NSString *)name andId:(NSString *)theid
{
    
    MeterProvicen *proince = [[MeterProvicen alloc] init];
    proince.provinceName = name;
    proince.provinceId = theid;
    return proince;
    
}
@end
