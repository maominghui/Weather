//
//  Meterviewofpage.m
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "Meterviewofpage.h"

@implementation Meterviewofpage
@synthesize imgview,level,number;

enum{
    
    viewspace_x = 4,
    viewspace_y = 4
};

- (id)initWithFrame:(CGRect)frame andcityid:(NSString *)thecityid
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imgview = [[UIImageView alloc] initWithFrame:CGRectMake(viewspace_x,viewspace_y,52,10)];
        [self addSubview:imgview];
        level = [[UILabel alloc] initWithFrame:CGRectMake(viewspace_x,17,52,30)];
        if ([level.text length]<2) {
            
            level.textAlignment = NSTextAlignmentCenter;
            level.font = [UIFont systemFontOfSize:20];
            
        }else {
        
            level.textAlignment = NSTextAlignmentLeft;
            level.font = [UIFont systemFontOfSize:12];
        }
        
        level.textColor = [UIColor whiteColor];
        [self addSubview:level];
        
        number = [[UILabel alloc] initWithFrame:CGRectMake(viewspace_x,49,52,30)];
        number.textAlignment = NSTextAlignmentCenter;
        number.font = [UIFont systemFontOfSize:20];
        number.textColor = [UIColor whiteColor];
        [self addSubview:number];
        
        [self reloadDatawithAreaCode:nil andareaname:nil andcityid:thecityid];
    }
    
    return self;
}

-(void)reloadDatawithAreaCode:(NSString *)code andareaname:(NSString *)thename andcityid:(NSString *)cityid
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",PM2WEATHADDRESS,cityid];
    [[AFNYClient sharedClient] postPath:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MeterPm2Msg  *pmValue = [[MeterPm2Msg alloc] init];
        NSMutableArray  *all = [[MeterTools shareInstance] getdayPmValue:operation.responseString];
        if ([all count]>0) {
            
            pmValue = [all objectAtIndex:0];
            NSLog(@"~~~~~~~~~~~~~~~~~~~:%@",pmValue.imgName);
            NSLog(@"~~~~~~~~~~~~~~~~~~~:%@",pmValue.quality);
            NSLog(@"~~~~~~~~~~~~~~~~~~~:%@",pmValue.pm2str);
            [imgview setImage:[UIImage imageNamed:pmValue.imgName]];
            [level setText:pmValue.quality];
            if ([level.text length]<2) {
                
                level.textAlignment = NSTextAlignmentCenter;
                level.font = [UIFont systemFontOfSize:20];
                
            }else {
                
                [imgview setImage:[UIImage imageNamed:@"中.png"]];
                level.textAlignment = NSTextAlignmentLeft;
                level.font = [UIFont systemFontOfSize:12];
            }

            [number setText:pmValue.pm2str];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}

@end
