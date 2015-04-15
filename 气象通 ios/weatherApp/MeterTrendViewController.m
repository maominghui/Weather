//
//  MeterTrendViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterTrendViewController.h"
#import "WeatherClient.h"
#import "Tool.h"
#import "TrendView.h"
#import "MBProgressHUD.h"
@interface MeterTrendViewController ()

@end

@implementation MeterTrendViewController
{
    NSMutableArray *infoMationArray;
    NSMutableArray *dateArray;
    NSMutableArray *weatherArray;
    NSMutableArray *nweatherArray;
    NSMutableArray *weekArray;
    NSString *dateString;
    NSString *weatherString;
    NSString *nweatherString;
    NSString *dataAll;
    NSString *weatherAll;
    NSString *nweatherAll;
    TrendView *viewLine;
    MBProgressHUD *HUD;
    
}
@synthesize forecasttimeLabel,dateLabel,weatherLabel;
@synthesize dweatherLabel,weekLabel,currAreaCode;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self treadRequest];
    [self showTextDialog];
    //currAreaCode = [[NSString alloc] init];
    
    NSLog(@"currAreaCode===%@",currAreaCode);
    
    infoMationArray = [[NSMutableArray alloc]init];
    dateArray = [[NSMutableArray alloc]init];
    weatherArray = [[NSMutableArray alloc]init];
    nweatherArray = [[NSMutableArray alloc]init];
    weekArray = [[NSMutableArray alloc]init];
    viewLine = [[TrendView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    forecasttimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 330, 221, 44)];
    [forecasttimeLabel setTextColor:[UIColor whiteColor]];
    [viewLine addSubview:forecasttimeLabel];
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 280, 320, 44)];
    [dateLabel setTextColor:[UIColor whiteColor]];
    [viewLine addSubview:dateLabel];
    weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 320, 44)];
    [weekLabel setTextColor:[UIColor whiteColor]];
    [viewLine addSubview:weekLabel];
    dweatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 320, 44)];
    [dweatherLabel setTextColor:[UIColor whiteColor]];
    [viewLine addSubview:dweatherLabel];
    weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 240, 320, 44)];
    [weatherLabel setTextColor:[UIColor whiteColor]];
    [viewLine addSubview:weatherLabel];
}
- (void)showTextDialog
{
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"请稍等";
    [HUD showAnimated:YES
  whileExecutingBlock:^{
      
      sleep(3);
      
  } completionBlock:^{
      if (infoMationArray != nil) {
      
          [HUD removeFromSuperview];
      }
  }];
}
- (void)showRefreshDialog
{
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.labelText = @"请稍等";
    [HUD showAnimated:YES
    whileExecutingBlock:^{
      
      sleep(3);
      
  } completionBlock:^{
      if (infoMationArray != nil) {
          
          [HUD removeFromSuperview];
          
          
      }
  }];
}

- (void)treadRequest
{
    __block NSString *areaname ;
    self.currAreaCode = @"510100000";

    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",treadUrl,self.currAreaCode];
    NSLog(@"999999999:%@",self.currAreaCode);
    [[WeatherClient sharedClient] postPath:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"----%@",operation.responseString);
        infoMationArray = [Tool getWeatherMation:operation.responseString];
        NSString *foretime = [[infoMationArray objectAtIndex:0] objectAtIndex:0];
        NSString *str = [foretime stringByAppendingString:@"发布"];
        forecasttimeLabel.text = str;
        areaname = [[infoMationArray objectAtIndex:3] objectAtIndex:0];
        NSString *area = [areaname stringByAppendingString:@"温度趋势图"];
        [self initUI:area];
        for (int i = 0;i < [[infoMationArray objectAtIndex:4] count]-1;i++)
        {
          dateString = [[[infoMationArray objectAtIndex:4] objectAtIndex:i] substringWithRange:NSMakeRange(5, 5)];
          [dateArray addObject:[NSString stringWithFormat:@"%@",dateString]];
        }
        dataAll =[dateArray componentsJoinedByString:@"  "];
        
        dateLabel.text = dataAll;
        NSLog(@"datae %@",dateArray);
        for (int i = 0;i < [[infoMationArray objectAtIndex:5] count]-1;i++)
        {
            weatherString = [[infoMationArray objectAtIndex:5] objectAtIndex:i];
            [weatherArray addObject:[NSString stringWithFormat:@"%@",weatherString]];
        }
        weatherAll = [weatherArray componentsJoinedByString:@"    "];
        NSLog(@"weath%@",weatherAll);

        dweatherLabel.text = weatherAll;
        NSLog(@"dadsa%@",dweatherLabel.text);
        for (int i = 0;i < [[infoMationArray objectAtIndex:6] count]-1;i++)
        {
            nweatherString = [[infoMationArray objectAtIndex:6] objectAtIndex:i];
            [nweatherArray addObject:[NSString stringWithFormat:@"%@",nweatherString]];
        }
        nweatherAll = [nweatherArray componentsJoinedByString:@"    "];
        weatherLabel.text = nweatherAll;
        NSLog(@"nweall%@",nweatherAll);
        [self timeChange];
        weekArray =  [infoMationArray objectAtIndex:1];
        NSMutableArray *dayWeatherArray = [[NSMutableArray alloc]init];
        NSMutableArray *nWeArray = [[NSMutableArray alloc]init];
        NSMutableArray *hArr = [[NSMutableArray alloc]initWithCapacity:[dateArray count]];
        //竖轴
        for (int i =0; i< 6; i++) {
            NSLog(@"===weather==%@",[weekArray objectAtIndex:i]);
            [dayWeatherArray addObject:[NSValue valueWithCGPoint:CGPointMake(20+i*30, [[weekArray objectAtIndex:i] floatValue])]];
            [nWeArray addObject:[NSValue valueWithCGPoint:CGPointMake(20+i*30, [[[infoMationArray objectAtIndex:2] objectAtIndex:i] floatValue])]];
        }
        NSMutableArray *vArr = [[NSMutableArray alloc]initWithCapacity:16];
        for (int i=0; i<17; i++) {
            [vArr addObject:[NSString stringWithFormat:@"%d",i*1]];
        }
        NSLog(@"wawa%@",weatherArray);
        [viewLine initWithFrame:CGRectZero lbArray:weekArray];
        [viewLine initWith:CGRectZero lbArray:[infoMationArray objectAtIndex:2]];
        [viewLine initWithDayImageFrame:CGRectZero dayImageArray:weatherArray];
        [viewLine initWithNightImageFrame:CGRectZero nightImageArray:nweatherArray];
        
        NSLog(@"iiiiii%@",[infoMationArray objectAtIndex:2]);
        [viewLine setHDesc:hArr];
        [viewLine setVDesc:vArr];
        [viewLine setHightArrayPoint:dayWeatherArray];
        [viewLine setLowArrayPoint:nWeArray];
        [self.view addSubview:viewLine];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    
    }];
}
- (void)timeChange
{
    NSArray *weekdayAry = [NSArray arrayWithObjects: @"周日",@"周一", @"周二", @"周三", @"周四", @"周五", @"周六",nil];
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:NSLocalizedString(@"eee", nil)];
    // 此处更改显示的大写字母的星期几
    [dateFormatter setShortWeekdaySymbols:weekdayAry];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSString *weakstr = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"dada%@",weakstr);
    if([weakstr isEqualToString:@"周日"])
    {
       weekLabel.text = @"周日  周一  周二   周三    周四    周五";
    }
    if([weakstr isEqualToString:@"周一"])
    {
        weekLabel.text =  @"周一  周二  周三    周四    周五    周六";
    }
    if([weakstr isEqualToString:@"周二"])
    {
        
        weekLabel.text =  @"周二  周三  周四  周五   周六   周日";
    }
    if([weakstr isEqualToString:@"周三"])
    {
        
        weekLabel.text =  @"周三  周四  周五  周六   周日   周一";
    }
    if([weakstr isEqualToString:@"周四"])
    {
        
        weekLabel.text =  @"周四  周五  周六  周日   周一   周二";
    }
    if([weakstr isEqualToString:@"周五"])
    {
        
        weekLabel.text =  @"周五  周六  周日  周一   周二   周三";
    }
    if([weakstr isEqualToString:@"周六"])
    {
        
        weekLabel.text =  @"周六  周日  周一  周二   周三   周四";
    }

}
- (void)initUI:(NSString *)areaname
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(200, 0, 100, 44)];
    label.text=areaname;
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:18];
    label.textColor=[UIColor blackColor];
    label.backgroundColor=[UIColor clearColor];
    self.navigationItem.titleView=label;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 35, 35)];
    button.titleLabel.text= @"Back";
    [button setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(treadRequest) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = backButton ;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
