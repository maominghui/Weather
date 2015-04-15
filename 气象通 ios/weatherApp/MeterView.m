//
//  MeterView.m
//  Meteorological_app
//
//  Created by 520 on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterView.h"
#import "DateProcess.h"
@interface MeterView ()
{
    CALayer *linesLayer;
    UIView *popView;
    UILabel *disLabel;
}
@end

@implementation MeterView
@synthesize hightArrayPoint,hInterval;
@synthesize vInterval,vDesc;
@synthesize hDesc,lowArrayPoint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        hInterval = 10;
        vInterval = 50;
    }
    return self;
}
#define ZeroPoint CGPointMake(30,460)

- (void)drawRect:(CGRect)rect
{
    [self setClearsContextBeforeDrawing: YES];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    /*  //虚线
     float lengths[] = {1,3};
     CGContextSetLineDash(context, 0, lengths,2);
     CGContextMoveToPoint(context,30,370);
     CGContextAddLineToPoint(context,30,70);
     */
    UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zsy_02.png"]];
    imageView.frame=CGRectMake(0,0,320,45);
    [self addSubview:imageView];
    UILabel *NavLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,15,320,30)];
    NavLabel.backgroundColor=[UIColor clearColor];
    NavLabel.textAlignment=1;
    NavLabel.text=@"24小时内气温变化图";
    NavLabel.textColor=[UIColor whiteColor];
    [imageView addSubview:NavLabel];
    [self addSubview:imageView];
    
    int x = 290 ;
    int y =iphone5?470:430 ;
   
    for (int i=0;i<vDesc.count; i++) {
        CGPoint bPoint = CGPointMake(30, y);
        CGPoint ePoint = CGPointMake(x, y);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [label setCenter:CGPointMake(bPoint.x-15,iphone5?bPoint.y-30+40:bPoint.y-30)];
        [label setTextAlignment:1];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:[NSString stringWithFormat:@"%d",[[vDesc objectAtIndex:i] intValue]*3]];
        label.font=[UIFont systemFontOfSize:12.0f];
        [self addSubview:label];

        if(i==vDesc.count-1)
        {
            UIImage *hImage=[UIImage imageNamed:@"hLine.jpg"];
            CGContextDrawImage(context,CGRectMake(29,iphone5?110:70,262,1),hImage.CGImage);
            
        }else if(i==0)
        {
            UIImage *hImage=[UIImage imageNamed:@"hLine.jpg"];
            CGContextDrawImage(context,CGRectMake(29,iphone5?479:400,262,1),hImage.CGImage);

        }else
        {
            UIImage *hImage=[UIImage imageNamed:@"虚线.png"];
            CGContextDrawImage(context,CGRectMake(bPoint.x,iphone5?bPoint.y-30+40:bPoint.y-30,262,1),hImage.CGImage);
        }
        
        y -=iphone5?33.1:30;
        
    }
    UIImage *image=[UIImage imageNamed:@"vLine.png"];
    CGContextDrawImage(context,CGRectMake(29,iphone5?110:70,1,iphone5?370:330),image.CGImage);
    CGContextDrawImage(context,CGRectMake(290,iphone5?110:70,1,iphone5?370:330),image.CGImage);
    NSString *currentTime=[[DateProcess alloc] currentTime];
    
   
    CGContextMoveToPoint(context,[currentTime intValue]>12?70:220,iphone5?479:400);
    CGContextAddLineToPoint(context,[currentTime intValue]>12?70:220,iphone5?111:71);
    // CGContextMoveToPoint(context,290,400);
    //CGContextAddLineToPoint(context,290,70);
    
    //时间
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(105,iphone5?40+27:40, 180, 30)];
    [timeLabel setTextAlignment:1];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setTextColor:[UIColor whiteColor]];
    timeLabel.numberOfLines = 1;
    timeLabel.adjustsFontSizeToFitWidth = YES;
     NSString *dateHandle=[[DateProcess alloc] dataHandleWith:hDesc];
    [timeLabel setText:dateHandle];
    timeLabel.font=[UIFont boldSystemFontOfSize:20.0f];
    [self addSubview:timeLabel];
    
    // 日
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([currentTime intValue]>12?45:190,iphone5?440+40:400, 60, 30)];
    [label setTextAlignment:1];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    label.numberOfLines = 1;
    label.adjustsFontSizeToFitWidth = YES;
    NSString *currentStr=[[DateProcess alloc] currentDate];
    [label setText:currentStr];
    label.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:label];
   
    //气温UILabel
    UILabel *temperatureLabel=[[UILabel alloc] initWithFrame:CGRectMake(5,iphone5?40+30:40,70,30)];
    [temperatureLabel setTextAlignment:0];
    [temperatureLabel setBackgroundColor:[UIColor clearColor]];
    [temperatureLabel setTextColor:[UIColor whiteColor]];
    temperatureLabel.adjustsFontSizeToFitWidth=YES;
    [temperatureLabel setText:@"气温(℃)"];
    temperatureLabel.font=[UIFont systemFontOfSize:12.0f];
    [self addSubview:temperatureLabel];
    
    
    //    //画点折线条的线
    CGColorRef pointColorRef = [UIColor colorWithRed:24.0f/255.0f green:116.0f/255.0f blue:205.0f/255.0f alpha:1.0].CGColor;
    CGFloat pointLineWidth = 2.5f;
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
            CGContextMoveToPoint(context, p1.x,iphone5?400-p1.y+40+10:400-p1.y+2);//*vInterval/20

            CGPoint goPoint = CGPointMake(p1.x,iphone5?400-p1.y+40+10:400-p1.y+2);//*vInterval/20
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
        }
        else
        {
		p1 = [[hightArrayPoint objectAtIndex:i] CGPointValue];
        CGPoint goPoint = CGPointMake(p1.x,iphone5?400-p1.y+40+10:400-p1.y+2);//*vInterval/20
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
      }
	}
	CGContextStrokePath(context);
    
   //低温折线图
    for (int i=0; i<[lowArrayPoint count]; i++)
	{
        CGPoint p1;
        if(i==0)
        {
            p1 = [[lowArrayPoint objectAtIndex:0] CGPointValue];
            CGContextMoveToPoint(context, p1.x,iphone5?400-p1.y+40+10:400-p1.y+2);//*vInterval/20
            
            CGPoint goPoint = CGPointMake(p1.x,iphone5?400-p1.y+40+10:400-p1.y+2);//*vInterval/20
            CGContextAddLineToPoint(context, goPoint.x, goPoint.y);;
            
            //添加触摸点
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            //[bt setBackgroundColor:[UIColor redColor]];
            [bt setBackgroundImage:[UIImage imageNamed:@"蓝.png"] forState:UIControlStateNormal];
            [bt setFrame:CGRectMake(0,0,6,6)];
            
            [bt setCenter:goPoint];
            
            [bt addTarget:self
                   action:@selector(btAction:)
         forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:bt];
        }
        else
        {
            p1 = [[lowArrayPoint objectAtIndex:i] CGPointValue];
            CGPoint goPoint = CGPointMake(p1.x,iphone5?400-p1.y+40+10:400-p1.y+2);//*vInterval/20
            CGContextAddLineToPoint(context, goPoint.x,goPoint.y);
            
            //添加触摸点
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            
            [bt setBackgroundImage:[UIImage imageNamed:@"蓝.png"] forState:UIControlStateNormal];
            [bt setFrame:CGRectMake(0,0,6,6)];
            
            [bt setCenter:goPoint];
            
            [bt addTarget:self
                   action:@selector(btAction:)
         forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:bt];
        }
	}
	CGContextStrokePath(context);
    
}
- (void)btAction:(id)sender{
   
//    [disLabel setText:@"100"];
//    UIButton *bt = (UIButton*)sender;
//    popView.center = CGPointMake(bt.center.x, bt.center.y - popView.frame.size.height/2);
//    [popView setAlpha:0.0f];

}

@end
