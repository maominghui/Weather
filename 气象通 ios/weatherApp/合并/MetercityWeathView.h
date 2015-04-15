//
//  MetercityWeathView.h
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNYClient.h"
#import "MeterAreaMsg.h"
#import "Meterviewofpage.h"
#import "MeterWeekweathView.h"

@interface MetercityWeathView : UIView
@property(nonatomic,strong)NSString *currCode;      //当前地区编码
@property(nonatomic,strong)NSString *areaName;
@property(nonatomic,retain)UILabel  *tmpLabel;      //温度
@property(nonatomic,retain)UILabel  *weathState;   //天气状况
@property(nonatomic,retain)UILabel  *windandWater; //风力降水
@property(nonatomic,retain)UILabel  *repushDate;   //发布时间
@property(nonatomic,retain)Meterviewofpage  *pageview;
@property(nonatomic,retain)UIButton  *weekWeathBtn; //点击按钮现实一周天气列表
@property(nonatomic,retain)MeterWeekweathView  *weekWeathView; //一周天气
@property(nonatomic,retain)UIView *shadowView;//阴影视图
- (id)initWithFrame:(CGRect)frame andwithCode:(NSString *)thecode andareaName:(NSString *)thename andcityid:(NSString *)thecityid;
-(void)sendRequestWithCode:(NSString *)thecode andareaName:(NSString *)thename andcityid:(NSString *)thecityid;

@end
