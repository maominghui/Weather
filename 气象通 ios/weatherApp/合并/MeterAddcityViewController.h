//
//  MeterAddcityViewController.h
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeterTools.h"
#import "AFNYClient.h"
#import "MeterSQLMag.h"
#import "MeterNetAlert.h"
#import "MeterPickerView.h"

@interface MeterAddcityViewController : UIViewController<MeterPickerViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSString  *currCityCode;
@property(nonatomic,retain)UIImageView  *meterBackImg; //背景
@property(nonatomic,retain)UIButton *leftButton;
@property(nonatomic,retain)UIButton *rightButton;

@property(nonatomic,retain)UILabel  *provincesLabel; //省份
@property(nonatomic,retain)UILabel  *cityLabel;     //市
@property(nonatomic,retain)UILabel  *countryLabel; //县

@property(nonatomic,retain)UITextField *provincesTextfield;
@property(nonatomic,retain)UITextField *cityTextfield;
@property(nonatomic,retain)UITextField *countryTextfield;

@property(nonatomic,retain)MeterPickerView *provicenPicker; //省份选择列表
@property(nonatomic,retain)MeterPickerView *cityPicker;   //城市选择列表
@property(nonatomic,retain)MeterPickerView *countryPicker; //县选择列表
@property(nonatomic,retain)NSMutableArray  *tempArr;
@property(nonatomic,retain)sqltestlist  *sqlValue; //作为数据库操作参数
@property(nonatomic,retain)UIAlertView  *addcityAlert; //天气城市添加成功警示框

@end
