//
//  Meterviewofpage.h
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import <UIKit/UIKit.h>
#import "AFNYClient.h"
#import "MeterPm2Msg.h"
#import "MeterTools.h"

@interface Meterviewofpage : UIView
@property(nonatomic,retain)UIImageView *imgview;
@property(nonatomic,retain)UILabel  *level; //优良等级
@property(nonatomic,retain)UILabel  *number;

- (id)initWithFrame:(CGRect)frame andcityid:(NSString *)thecityid;
-(void)reloadDatawithAreaCode:(NSString *)code andareaname:(NSString *)thename andcityid:(NSString *)cityid;
@end
