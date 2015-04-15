//
//  MeterPm2Msg.h
//  Meteorological_app
//
//  Created by zhao on 14-6-26.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeterPm2Msg : NSObject
@property(nonatomic,strong)NSString *imgName;
@property(nonatomic,strong)NSString *quality;
@property(nonatomic,strong)NSString *pm2str;

-(id)initWithimg:(NSString *)thename andthequality:(NSString *)thequality andpm2:(NSString *)thepm;
@end
