//
//  MeterWeekweathView.h
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//未来一周的天气

#import <UIKit/UIKit.h>
#import "AFNYClient.h"
#import "MeterTools.h"
#import "MeterBaseTableview.h"

@interface MeterWeekweathView : UIView
@property(nonatomic,strong)NSString *currCode;
@property(nonatomic,retain)UIView  *subView;
@property(nonatomic,retain)UIButton *frameBtn;
@property(nonatomic,retain)MeterBaseTableview  *tableList;

- (id)initWithFrame:(CGRect)frame andcode:(NSString *)code;
-(void)reloadWeekWeathWithData:(NSString *)currcode;
@end
