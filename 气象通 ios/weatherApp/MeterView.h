//
//  MeterView.h
//  Meteorological_app
//
//  Created by 520 on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MeterView : UIView
// 横竖轴距离间隔
@property (assign) NSInteger hInterval;
@property (assign) NSInteger vInterval;

//横竖轴显示标签
@property (nonatomic, strong) NSArray *hDesc;
@property (nonatomic, strong) NSArray *vDesc;

//点信息

@property (nonatomic, strong) NSArray *hightArrayPoint;
@property (nonatomic ,strong) NSArray *lowArrayPoint;
@end
