//
//  MeterCitySelectViewController.h
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeterSQLMag.h"
#import "MeterBaseTableview.h"
#import "MeterAddcityViewController.h"

@interface MeterCitySelectViewController : UIViewController<MeterBaseTableviewDelegate>
@property(nonatomic,retain)UIButton *leftButton;
@property(nonatomic,retain)UIButton *rightButton;
@property(nonatomic)sqltestlist  *sqlvalue;
@property(nonatomic,retain)MeterBaseTableview  *cityTableview;//城市列表
@end
