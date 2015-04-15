//
//  MeterView.m
//  Meteorological_app
//
//  Created by 520 on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "TrendView.h"
@interface TrendView ()
{
    CALayer *linesLayer;
    UIView *popView;
    UILabel *disLabel;
    UILabel *dayLabel;
    UILabel *nightLabel;
    CGPoint goPoint;
    CGPoint lowPoint;
    NSMutableArray *labelArray;
    NSMutableArray *imageDayArray;
    NSMutableArray *imageNightArray;
    UIImageView *weatherImage;
    
}
@end

@implementation TrendView
@synthesize hightArrayPoint,hInterval;
@synthesize vInterval,vDesc;
@synthesize hDesc,lowArrayPoint;

- (id)initWithFrame:(CGRect)frame  lbArray:(NSMutableArray *)textArray   /*重写初始化*/
{
    self = [super initWithFrame:frame];
    if (self) {
        AllLbArray=textArray;
    }
    return self;
}
- (id)initWith:(CGRect)frame lbArray:(NSMutableArray *)lowArray
{
    self = [super initWithFrame:frame];
    if (self) {
        labelArray=lowArray;

    }
    
    return self;

}
-(id)initWithDayImageFrame:(CGRect)frame dayImageArray:(NSMutableArray *)dayImageArray
{
        self = [super initWithFrame:frame];
    
    if (self) {
        imageDayArray=dayImageArray;
    }
    return self;
}
-(id)initWithNightImageFrame:(CGRect)frame nightImageArray:(NSMutableArray *)nightImageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        imageNightArray = nightImageArray;
    }
    return self;
}

#define ZeroPoint CGPointMake(30,460)/*drawRect view初始化的时候调用*/
- (void)drawRect:(CGRect)rect
{
    [self setClearsContextBeforeDrawing: YES];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画背景线条------------------
    CGColorRef backColorRef = [UIColor blackColor].CGColor;
    CGFloat backLineWidth = 1.0f;
    CGFloat backMiterLimit = 0.f;
    
    CGContextSetLineWidth(context, backLineWidth);//主线宽度
    CGContextSetMiterLimit(context, backMiterLimit);//投影角度
    
    CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, backColorRef);//设置双条线
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineCap(context, kCGLineCapRound );
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    /*  //虚线
     float lengths[] = {1,3};
     CGContextSetLineDash(context, 0, lengths,2);
     CGContextMoveToPoint(context,30,370);
     CGContextAddLineToPoint(context,30,70);
     */
//    UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zsy_02.png"]];
//    imageView.frame=CGRectMake(0,0,320,45);
//    [self addSubview:imageView];
//    UILabel *NavLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,15,320,30)];
//    NavLabel.backgroundColor=[UIColor clearColor];
//    NavLabel.textAlignment=1;
//    NavLabel.text=@"24小时内气温变化图";
//    NavLabel.textColor=[UIColor whiteColor];
//    [imageView addSubview:NavLabel];
//    [self addSubview:imageView];
    
   // NSLog(@"vdes.count%d",vDesc.count);
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(120,40, 160, 30)];
    [timeLabel setTextAlignment:1];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setTextColor:[UIColor whiteColor]];
    timeLabel.numberOfLines = 1;
    timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.font=[UIFont boldSystemFontOfSize:18.0f];
    [self addSubview:timeLabel];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70,400, 60, 30)];
    [label setTextAlignment:1];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    label.numberOfLines = 1;
    label.adjustsFontSizeToFitWidth = YES;
    label.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:label];
   
//    //气温UILabel
//    UILabel *temperatureLabel=[[UILabel alloc] initWithFrame:CGRectMake(5,40,60,30)];
//    [temperatureLabel setTextAlignment:0];
//    [temperatureLabel setBackgroundColor:[UIColor clearColor]];
//    [temperatureLabel setTextColor:[UIColor whiteColor]];
//    temperatureLabel.adjustsFontSizeToFitWidth=YES;
//    [temperatureLabel setText:@"气温(℃)"];
//    temperatureLabel.font=[UIFont systemFontOfSize:12.0f];
//    [self addSubview:temperatureLabel];
//    
    
    //    //画点线条------------------
    CGColorRef pointColorRef = [UIColor colorWithRed:24.0f/255.0f green:116.0f/255.0f blue:205.0f/255.0f alpha:1.0].CGColor;
    CGFloat pointLineWidth = 2.0f;
    CGFloat pointMiterLimit = 5.0f;
    
    CGContextSetLineWidth(context, pointLineWidth);//主线宽度
    CGContextSetMiterLimit(context, pointMiterLimit);//投影角度
    
    
    CGContextSetShadowWithColor(context, CGSizeMake(3,5),8, pointColorRef);//设置双条线
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineCap(context, kCGLineCapRound );
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    
	//绘图   折线  高温折线图
	
    for (int i=0; i<[hightArrayPoint count]; i++)
	{
                     CGPoint p1;
        if(i==0)
        {
            p1 = [[hightArrayPoint objectAtIndex:0] CGPointValue];
            CGContextMoveToPoint(context, p1.x*1.7,400-p1.y-200-50);//*vInterval/20

            goPoint = CGPointMake(p1.x*1.7, 400-p1.y-200-50);//*vInterval/20
            CGContextAddLineToPoint(context, goPoint.x, goPoint.y);;
            
            //添加触摸点
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            //[bt setBackgroundColor:[UIColor redColor]];
            [bt setBackgroundImage:[UIImage imageNamed:@"红.png"] forState:UIControlStateNormal];
            [bt setFrame:CGRectMake(0,0,6,6)];
            [bt setCenter:goPoint];
            [bt addTarget:self
                   action:@selector(btAction:)
         forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bt];
            
            dayLabel=[[UILabel alloc] init];
            [dayLabel setFrame:CGRectMake(0,0,70,15)];
            [dayLabel setCenter:CGPointMake(goPoint.x+4, goPoint.y-10)];
            [self addSubview:dayLabel];

            dayLabel.text=[[AllLbArray objectAtIndex:0] stringByAppendingString:@"℃"];
            dayLabel.textColor = [UIColor whiteColor];

            weatherImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            [weatherImage setCenter:CGPointMake(goPoint.x+4, goPoint.y-30)];
            [weatherImage setImage:[UIImage imageNamed:[imageDayArray objectAtIndex:0]]];
            [self addSubview:weatherImage];
            NSLog(@"all%@",dayLabel.text);

            
        }
        else
        {
		p1 = [[hightArrayPoint objectAtIndex:i] CGPointValue];
        goPoint = CGPointMake(p1.x*1.7, 400-p1.y-200-50);//*vInterval/20
		CGContextAddLineToPoint(context, goPoint.x, goPoint.y);;
        
        //添加触摸点
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bt setBackgroundImage:[UIImage imageNamed:@"红.png"] forState:UIControlStateNormal];
        [bt setFrame:CGRectMake(0,0,6,6)];
        [bt setCenter:goPoint];
        [bt addTarget:self
               action:@selector(btAction:)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt];
            
            dayLabel=[[UILabel alloc] init];
            [dayLabel setFrame:CGRectMake(0,0,70,15)];
            [dayLabel setCenter:CGPointMake(goPoint.x+8, goPoint.y-10)];
            [self addSubview:dayLabel];
            dayLabel.text=[[AllLbArray objectAtIndex:i] stringByAppendingString:@"℃"];
            dayLabel.textColor = [UIColor whiteColor];
            NSLog(@"all%@",dayLabel.text);
            weatherImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            [weatherImage setCenter:CGPointMake(goPoint.x+4, goPoint.y-30)];
            [weatherImage setImage:[UIImage imageNamed:[imageDayArray objectAtIndex:i]]];
            [self addSubview:weatherImage];
            


      }
	}
	CGContextStrokePath(context);
    
   //低温折线图
    for (int i=0; i<[lowArrayPoint
                     count]; i++)
	{
        CGPoint p1;
        if(i==0)
        {
            //设置第一个label
            p1 = [[lowArrayPoint objectAtIndex:0] CGPointValue];
            CGContextMoveToPoint(context, p1.x*1.7,400-p1.y-150-50);//*vInterval/20
            
             lowPoint = CGPointMake(p1.x*1.7, 400-p1.y-150-50);//*vInterval/20
            CGContextAddLineToPoint(context, lowPoint.x, lowPoint.y);;
            
            //添加触摸点
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            //[bt setBackgroundColor:[UIColor redColor]];
            [bt setBackgroundImage:[UIImage imageNamed:@"蓝.png"] forState:UIControlStateNormal];
            [bt setFrame:CGRectMake(0,0,6,6)];
            
            [bt setCenter:lowPoint];
            
            [bt addTarget:self
                   action:@selector(btAction:)
         forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bt];
            
            dayLabel=[[UILabel alloc] init];
            [dayLabel setFrame:CGRectMake(0,0,70,15)];
            [dayLabel setCenter:CGPointMake(lowPoint.x+4, lowPoint.y+15)];
            [self addSubview:dayLabel];
            
            dayLabel.text=[[labelArray objectAtIndex:0] stringByAppendingString:@"℃"];
            dayLabel.textColor = [UIColor whiteColor];
            
            weatherImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            [weatherImage setCenter:CGPointMake(lowPoint.x+4, lowPoint.y+40)];
            [weatherImage setImage:[UIImage imageNamed:[imageNightArray objectAtIndex:0]]];
            [self addSubview:weatherImage];
            

            
        }
        else
        {
            p1 = [[lowArrayPoint objectAtIndex:i] CGPointValue];
            lowPoint = CGPointMake(p1.x*1.7, 400-p1.y-150-50);//*vInterval/20
            CGContextAddLineToPoint(context, lowPoint.x, lowPoint.y);;
            //添加触摸点
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [bt setBackgroundImage:[UIImage imageNamed:@"蓝.png"] forState:UIControlStateNormal];
            [bt setFrame:CGRectMake(0,0,6,6)];
            [bt setCenter:lowPoint];
            [bt addTarget:self
                   action:@selector(btAction:)
         forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:bt];
            // 设置低温label 除了第一个以后的
            dayLabel=[[UILabel alloc] init];
            [dayLabel setFrame:CGRectMake(0,0,70,15)];
            [dayLabel setCenter:CGPointMake(lowPoint.x+4, lowPoint.y+15)];
            [self addSubview:dayLabel];
            
            dayLabel.text=[[labelArray objectAtIndex:i] stringByAppendingString:@"℃"];
            dayLabel.textColor = [UIColor whiteColor];
            
            weatherImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            [weatherImage setCenter:CGPointMake(lowPoint.x+4, lowPoint.y+40)];
            [weatherImage setImage:[UIImage imageNamed:[imageNightArray objectAtIndex:i]]];
            [self addSubview:weatherImage];

            
        }
	}
	CGContextStrokePath(context);
    
}

- (void)btAction:(id)sender{

}

@end
