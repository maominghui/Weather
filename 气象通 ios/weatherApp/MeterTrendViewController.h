//
//  MeterTrendViewController.h
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MeterTrendViewController : UIViewController

@property(nonatomic,retain)NSString  *currAreaCode;
@property (strong, nonatomic)  UILabel *weekLabel;
@property (strong, nonatomic)  UILabel *forecasttimeLabel;
@property (strong, nonatomic)  UILabel *dateLabel;
@property (strong, nonatomic)  UILabel *weatherLabel;
@property (strong, nonatomic)  UILabel *dweatherLabel;

@end
