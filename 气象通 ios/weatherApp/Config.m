//
//  Config.m
//  WeatherApp
//
//  Created by 520 on 14-6-24.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "Config.h"

@implementation Config
static Config * instance = nil;
+(Config *) Instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            [self new];
        }
    }
    return instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if(instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

@end
