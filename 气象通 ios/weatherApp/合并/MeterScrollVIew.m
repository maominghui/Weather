//
//  MeterWeatherAllView.m
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MeterScrollVIew.h"

@implementation MeterScrollVIew
@synthesize dataArray,delegate,weathScroView,currentpageindex,pageCtl,sqlvalue,viewsize,curCityView,curCityArr;
@synthesize cityView;

- (id)initWithFrame:(CGRect)frame andCountyArr:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        viewsize = frame;
        sqlvalue = [[sqltestlist alloc] init];
        curCityArr = [[NSMutableArray alloc] init];
        dataArray = [[NSMutableArray alloc] initWithArray:array];
        for (sqltestlist *str in dataArray) {
            NSLog(@"%@",str.countyName);
        }
        
        curCityView = [[MetercityWeathView alloc] init];
        NSInteger  pagecount = [array count];
        pageCtl = [[UIPageControl alloc] initWithFrame:CGRectMake(80,10,160,20)];
        pageCtl.backgroundColor = [UIColor clearColor];
        pageCtl.numberOfPages = [array count];
        pageCtl.currentPage = 0;
        [self addSubview:pageCtl];
        
        weathScroView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,30,viewsize.size.width,viewsize.size.height-30)];
        weathScroView.pagingEnabled = YES;
        weathScroView.contentSize = CGSizeMake(viewsize.size.width*pagecount,viewsize.size.height-30);
        weathScroView.showsHorizontalScrollIndicator = NO;
        weathScroView.showsVerticalScrollIndicator = NO;
        weathScroView.scrollsToTop = NO;
        weathScroView.delegate = self;
        for (int i =0; i<pagecount;i++) {
            
            sqlvalue = [dataArray objectAtIndex:i];
            cityView = [[MetercityWeathView alloc] initWithFrame:CGRectMake(viewsize.size.width*i,20,viewsize.size.width,viewsize.size.height-20) andwithCode:sqlvalue.countyId andareaName:sqlvalue.countyName andcityid:sqlvalue.cityId];
            [curCityArr addObject:cityView];
            [weathScroView addSubview:cityView];
        }
        
        [weathScroView  setContentOffset:CGPointMake(0,0)]; //设置起始偏移值
        [self addSubview:weathScroView];
    }
    
    return self;
}

-(void)reloadScrollViewWithCountArr:(NSMutableArray *)array
{
    pageCtl.numberOfPages = [array count];
    dataArray = array;
    weathScroView.contentSize = CGSizeMake(320*[array count],viewsize.size.height-30);
    [curCityArr removeAllObjects];
    for (int i =0; i<[dataArray count];i++) {
        
        sqlvalue = [dataArray objectAtIndex:i];
        cityView = [[MetercityWeathView alloc] initWithFrame:CGRectMake(320*i,20,viewsize.size.width,viewsize.size.height-20) andwithCode:sqlvalue.countyId andareaName:sqlvalue.countyName andcityid:sqlvalue.cityId];
        [curCityArr addObject:cityView];
        [weathScroView addSubview:cityView];
    }
    pageCtl.currentPage = 0;
    [weathScroView  setContentOffset:CGPointMake(0,0)]; //设置起始偏移值
}

#pragma  --Mark ScrollerVIewDelegate Method --
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = weathScroView.frame.size.width;
    int page = floor((weathScroView.contentOffset.x - pageWidth / 2) / pageWidth)+1;
    currentpageindex = page+1;
    sqlvalue = [dataArray objectAtIndex:page];
    pageCtl.currentPage = page;
    curCityView = [curCityArr objectAtIndex:page];
    [curCityView  sendRequestWithCode:sqlvalue.countyId andareaName:sqlvalue.countyName andcityid:sqlvalue.cityId];
    if ([delegate respondsToSelector:@selector(EScrollerCountychanged:andareacode:)]) {
        [delegate EScrollerCountychanged:sqlvalue.countyName andareacode:sqlvalue.countyId];
    }
}

@end
