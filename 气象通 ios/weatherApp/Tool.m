//
//  Tool.m
//  WeatherApp
//
//  Created by 520 on 14-6-22.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "Tool.h"
#import "JSON.h"
#import "TempperatureInfo.h"//
#import "UserLoginInfo.h"
@implementation Tool
+(NSMutableArray *)getPast24temperature:(NSString *)request
{
    NSMutableArray *temp24Array=[NSMutableArray new];
    NSDictionary *dic=[request JSONValue];
    NSLog(@"dic====%@",dic);
    
    for (int i=0;i<[[dic objectForKey:@"data"] count];i++) {
            NSString *maxtemp=[[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"maxtemp"];// 最高气温
            NSString *mintemp=[[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"mintemp"];//最低气温
            NSString *obstime=[[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"obstime"];//时次
            NSString *temp=[[[dic objectForKey:@"data"] objectAtIndex:i] objectForKey:@"temp"];//气温
            TempperatureInfo *tempInfo=[[TempperatureInfo alloc] initWithTempperature:maxtemp andTemp:temp andMintempStr:mintemp andObsTime:obstime];
            [temp24Array addObject:tempInfo];
        }
      NSLog(@"temp24Arraycount==%d",[temp24Array count]);
        return temp24Array;
}
+(id)getLoginRequest:(NSString *)request
{
    NSDictionary *loginDic=[request JSONValue];
    NSLog(@"dic===%@",loginDic);
    NSString *count=[loginDic objectForKey:@"count"];
    NSLog(@"count==8888=%@",count);
    if([count intValue]==1)
    {
        NSString *count=[loginDic objectForKey:@"count"];
        NSLog(@"===totalProperty=count=%@",count);

      NSString *account=[[[loginDic objectForKey:@"data"] objectAtIndex:0] objectForKey:@"account"];
      NSLog(@"===totalProperty==%@",account);
    
      NSString *areaname=[[[loginDic objectForKey:@"data"] objectAtIndex:0]objectForKey:@"areaname"];
      NSLog(@"===totalProperty==%@",areaname);
    
      NSString *userId=[[[loginDic objectForKey:@"data"] objectAtIndex:0] objectForKey:@"id"];
      NSLog(@"===totalProperty==%@",userId);
    
      NSString *username=[[[loginDic objectForKey:@"data"] objectAtIndex:0] objectForKey:@"username"];
    
      UserLoginInfo *loginInfo=[[UserLoginInfo alloc] initWithLoginInfoCount:count andAccount:account andAreaName:areaname andUserId:userId andUserName:username];
      return loginInfo;
    }
    else
    {
        return nil;
    }
}

+(NSMutableArray *)getWeatherMation:(NSString *)request
{
    NSMutableString *contentStr =[[NSMutableString alloc] initWithString:request];
    NSDictionary *result =[contentStr JSONValue];
    NSLog(@"array %@",result);
    NSArray *contentArray=[[NSArray alloc] init];
    NSMutableArray *allDataArray = [[NSMutableArray alloc]init];
    NSMutableArray *fortimeArray = [[NSMutableArray alloc]init];
    NSMutableArray *maxtempArray = [[NSMutableArray alloc]init];
    NSMutableArray *mintempArray = [[NSMutableArray alloc]init];
    NSMutableArray *areanameArray = [[NSMutableArray alloc]init];
    NSMutableArray *weatherArray = [[NSMutableArray alloc]init];
    NSMutableArray *predictArray = [[NSMutableArray alloc]init];
    NSMutableArray *nweatherArray = [[NSMutableArray alloc]init];
    NSString *str =   [result objectForKey:@"count"];
    contentArray = [result objectForKey:@"data"];
    
    NSLog(@"ddd%@",str);
    NSLog(@"ssss%@",contentArray);
    
    for (int i=0;i<contentArray.count;i++) {
        
        NSString *foretime = [[contentArray objectAtIndex:i] objectForKey:@"forecasttime"];
        NSString *maxtemp = [[contentArray objectAtIndex:i] objectForKey:@"maxtemp"];
        NSString *mintemp = [[contentArray objectAtIndex:i] objectForKey:@"mintemp"];
        NSString *areaname = [[contentArray objectAtIndex:i] objectForKey:@"areaname"];
        NSString *predictday = [[contentArray objectAtIndex:i] objectForKey:@"predictday"];
        NSString *dweathername = [[contentArray objectAtIndex:i] objectForKey:@"dweathername"];
        NSString *nweathername = [[contentArray objectAtIndex:i] objectForKey:@"nweathername"];
        [fortimeArray addObject:[NSString stringWithFormat:@"%@",foretime]];
        [maxtempArray addObject:[NSString stringWithFormat:@"%@",maxtemp]];
        [mintempArray addObject:[NSString stringWithFormat:@"%@",mintemp]];
        [areanameArray addObject:[NSString stringWithFormat:@"%@",areaname]];
        [predictArray addObject:[NSString stringWithFormat:@"%@",predictday]];
        [weatherArray addObject:[NSString stringWithFormat:@"%@",dweathername]];
        [nweatherArray addObject:[NSString stringWithFormat:@"%@",nweathername]];
        
    }
    [allDataArray addObject:fortimeArray];
    [allDataArray addObject:maxtempArray];
    [allDataArray addObject:mintempArray];
    [allDataArray addObject:areanameArray];
    [allDataArray addObject:predictArray];
    [allDataArray addObject:weatherArray];
    [allDataArray addObject:nweatherArray];
    NSLog(@"uuuu%@",allDataArray);
    
    return allDataArray;
    
}
+(NSDictionary *)getLifeIndex:(NSString *)request
{
    
    NSMutableString *contentStr =[[NSMutableString alloc] initWithString:request];
    NSDictionary *result =[contentStr JSONValue];
    NSDictionary *contentArray=[[NSDictionary alloc] init];
    
    contentArray = [result objectForKey:@"zs"];
    
    
    
    NSLog(@"wwww%d",contentArray.count);
    return contentArray;
    
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
