//
//  MeterWeekWeath.h
//  Meteorological_app
//
//  Created by NyistMacBook on 14-6-25.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeterWeekWeath : NSObject
@property(nonatomic,strong)NSString *weekWeathDate;
@property(nonatomic,strong)NSString *weekWeathImgname;
@property(nonatomic,retain)NSString *weekWeathTemp;

-(id)initWithdate:(NSString *)thedate andname:(NSString *)thename andtemp:(NSString *)theTemp;
@end
