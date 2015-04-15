//
//  MeterWeatherAllView.h
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeterSQLMag.h"
#import "MetercityWeathView.h"

@protocol MeterScrollVIewDelegate<NSObject>
-(void)EScrollerCountychanged:(NSString *)countyname andareacode:(NSString *)thecode;
@end

@interface MeterScrollVIew : UIView<UIScrollViewDelegate>
@property(nonatomic,assign)id<MeterScrollVIewDelegate>delegate;
@property(nonatomic,retain)UIScrollView   *weathScroView; //滑动变换城市天气
@property(nonatomic,retain)MetercityWeathView *cityView;
@property(nonatomic,retain)MetercityWeathView *curCityView; //当前滑动到得cityview
@property(nonatomic,retain)NSMutableArray *curCityArr; //存储city对象
@property(nonatomic,retain)NSMutableArray *dataArray;  //临时sqlvalue对象存储
@property(nonatomic,retain)UIPageControl  *pageCtl;   //页面控制
@property(nonatomic)NSInteger currentpageindex;
@property(nonatomic)sqltestlist  *sqlvalue;
@property(nonatomic)CGRect viewsize;

- (id)initWithFrame:(CGRect)frame andCountyArr:(NSMutableArray *)array;
-(void)reloadScrollViewWithCountArr:(NSMutableArray *)array;

@end
