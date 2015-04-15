//
//  MeterTools.m
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MeterTools.h"
#import "JSON.h"

@implementation MeterTools
@synthesize currindex;

+(MeterTools *)shareInstance
{

    static MeterTools *shareInstance_ = nil;
    static dispatch_once_t  Token;
    dispatch_once(&Token,^{
        
        shareInstance_ = [[MeterTools alloc] init];
    });
    
    return shareInstance_;
}

-(NSMutableArray *)getproince:(NSString *)request
{
    
    NSMutableString    *contentstr = [[NSMutableString  alloc] initWithString:request];
    NSDictionary   *result = [contentstr   JSONValue];
    NSLog(@"JSon    result=======:%@",[result objectForKey:@"data"]);
    NSArray  *proArr = [result objectForKey:@"data"];
    NSMutableArray  *AllArray = [[NSMutableArray alloc] init];
    for (int i =0; i<[proArr count]; i++) {
        
        NSString  *thename = [[proArr objectAtIndex:i] objectForKey:@"name"];
        NSString  *theid = [[proArr objectAtIndex:i] objectForKey:@"code"];
        NSLog(@"******:%@",thename);
        NSLog(@"&&&&&&:%@",theid);
        MeterProvicen  *proObject = [[MeterProvicen alloc] initWithName:thename andId:theid];
        [AllArray addObject:proObject];
    }
    
    return AllArray;
}

-(NSMutableArray *)getweekWeath:(NSString *)request
{

    NSMutableString    *contentstr = [[NSMutableString  alloc] initWithString:request];
    NSDictionary   *result = [contentstr   JSONValue];
    NSLog(@"weekdata:%@",[result objectForKey:@"data"]);
    NSArray  *proArr = [result objectForKey:@"data"];
    NSMutableArray  *AllArray = [[NSMutableArray alloc] init];
    for (int i =0; i<[proArr count]; i++) {
        
        NSString  *maxtemp = [[proArr objectAtIndex:i] objectForKey:@"maxtemp"];
        if ([maxtemp isEqual:[NSNull null]]) {
            
            maxtemp = @"";
        }else {
           
            maxtemp = [NSString stringWithFormat:@"%@%@",maxtemp,@"℃"];
        }
        
        NSString  *mintemp = [[proArr objectAtIndex:i] objectForKey:@"mintemp"];
        if ([mintemp isEqual:[NSNull null]]) {
            
            mintemp = @"";
        }else {
            mintemp= [NSString stringWithFormat:@"%@%@",mintemp,@"℃"];
        }
        
        NSString  *date = nil;
        NSArray *dateArr = [[[[proArr objectAtIndex:i] objectForKey:@"predictday"] substringFromIndex:5] componentsSeparatedByString:@" "];
        if ([dateArr count]>0) {
            
            date = [dateArr objectAtIndex:0];
        } else {
            
            date = @"00-00";
        }
        
        NSString *weathName = [NSString stringWithFormat:@"q%@.png",[[proArr objectAtIndex:i] objectForKey:@"nweather"]];
        NSString  *temp = [NSString stringWithFormat:@"%@ ~ %@",mintemp,maxtemp];
        MeterWeekWeath  *weekWeath = [[MeterWeekWeath alloc] initWithdate:date andname:weathName andtemp:temp];
        [AllArray addObject:weekWeath];
        
    }
    
    return AllArray;
}

-(NSString *)getareaweathState:(NSString *)request
{

    NSString *temp = nil;
    NSMutableString    *contentstr = [[NSMutableString  alloc] initWithString:request];
    NSDictionary   *result = [contentstr   JSONValue];
    NSArray  *proArr = [result objectForKey:@"data"];
    if ([proArr count]>0) {
        
        temp = [NSString stringWithFormat:@"%@",[[proArr objectAtIndex:0] objectForKey:@"weathername"]];
        
    }
    
    return temp;

}

-(NSMutableArray *)getdayPmValue:(NSString *)request
{

    NSMutableArray  *AllArray = [[NSMutableArray alloc] init];
    NSMutableString    *contentstr = [[NSMutableString  alloc] initWithString:request];
    NSDictionary   *result = [contentstr   JSONValue];
    NSArray  *proArr = [result objectForKey:@"data"];
    NSLog(@"%@",proArr);
    if ([proArr count]>0) {
    
        for (int i =0; i<[proArr count]; i++) {
            
            NSString  *imgname = [NSString stringWithFormat:@"%@.png",[[proArr objectAtIndex:i] objectForKey:@"quality"]];
            NSString  *quality = [[proArr objectAtIndex:i] objectForKey:@"quality"];
            NSNumber  *number = [[proArr objectAtIndex:i] objectForKey:@"pm2_5"];
            NSString  *pm2_5Str = [number stringValue];
            
            MeterPm2Msg  *tempValue = [[MeterPm2Msg alloc] initWithimg:imgname andthequality:quality andpm2:pm2_5Str];
            [AllArray addObject:tempValue];
        }
        
    }
    return AllArray;
}

-(NSMutableArray *)getdayWeathSatte:(NSString *)request
{
    
    NSMutableArray  *AllArray = [[NSMutableArray alloc] init];
    NSMutableString    *contentstr = [[NSMutableString  alloc] initWithString:request];
    NSDictionary   *result = [contentstr   JSONValue];
    NSArray  *proArr = [result objectForKey:@"data"];
    if ([proArr count]>0) {
        
         for (int i =0; i<[proArr count]; i++) {
             
             //温度
             NSNumber  *temp = [[NSNumber alloc] init];
             temp = [[proArr objectAtIndex:i] objectForKey:@"temp"];
             NSString  *tempStr = [NSString stringWithFormat:@"%@℃",[temp stringValue]];
             
             //风向风力
             NSString  *windDir = [[proArr objectAtIndex:i] objectForKey:@"winddcn"];
             NSString  *windStr = [[proArr objectAtIndex:i] objectForKey:@"windv"];
             NSString  *windall = [NSString stringWithFormat:@"%@风%@级",windDir,windStr];
             
             //降水
             temp = [[proArr objectAtIndex:i] objectForKey:@"precipitation"];
             NSString  *waterStr = [NSString stringWithFormat:@"降水:%@mm",[temp stringValue]];
             
             //观测日
             NSString *obsdate = [[proArr objectAtIndex:i] objectForKey:@"obsdate"];
             //观测时
             NSString *obstime = [[proArr objectAtIndex:i] objectForKey:@"obstime"];
             
             NSString *releaseDate = [NSString stringWithFormat:@"%@ %@:00 发布",obsdate,obstime];
             MeterAreaMsg  *dayweath = [[MeterAreaMsg alloc] initWithtemp:tempStr andDir:windall andpreciption:waterStr anddate:releaseDate];
             [AllArray addObject:dayweath];
         }
    }
    
    return AllArray;
}

@end
