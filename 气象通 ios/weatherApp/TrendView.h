//
//  MeterView.h
//  Meteorological_app
//
//  Created by 520 on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TrendView : UIView
{
    NSMutableArray *AllLbArray;
}
// 横竖轴距离间隔
@property (assign) NSInteger hInterval;
@property (assign) NSInteger vInterval;

//横竖轴显示标签
@property (nonatomic, strong) NSArray *hDesc;
@property (nonatomic, strong) NSArray *vDesc;

//点信息

@property (nonatomic, strong) NSArray *hightArrayPoint;
@property (nonatomic ,strong) NSArray *lowArrayPoint;

-(void)setLabelText:(NSMutableArray *)textArray;/*这方法不用了
                                                 */
- (id)initWithFrame:(CGRect)frame  lbArray:(NSMutableArray *)textArray;  /*重写初始化方法  MeterView*view =[[MeterView alloc] initWithFrame:cgrectmake lbArray:textArray] */
- (id)initWith:(CGRect)frame lbArray:(NSMutableArray *)lowArray;
- (id)initWithDayImageFrame:(CGRect)frame dayImageArray:(NSMutableArray *)dayImageArray;
- (id)initWithNightImageFrame:(CGRect)frame nightImageArray:(NSMutableArray *)nightImageArray;

@end
