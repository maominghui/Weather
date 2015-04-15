//
//  MeterWeathViewController.h
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import <UIKit/UIKit.h>
#import "MeterSQLMag.h"
#import "MeterScrollVIew.h"
#import "MeterCitySelectViewController.h"
#import "MeterTrendViewController.h"
#import "MeterLiveViewController.h"

@interface MeterWeathViewController : UIViewController<MeterScrollVIewDelegate>
@property(nonatomic,retain)UIImageView  *meterBackImg; //背景
@property(nonatomic,retain)UIButton *leftbtn;
@property(nonatomic,retain)UIButton *rightbtn;
@property(nonatomic,retain)sqltestlist  *sqlvalue;
@property(nonatomic,retain)MeterScrollVIew *weathScrolView;


@end
