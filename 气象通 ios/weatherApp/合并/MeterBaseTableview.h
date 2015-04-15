//
//  MeterBaseTableview.h
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeterSQLMag.h"
#import "MeterWeekWeath.h"
#import "MeterCityCell.h"
#import "MeterProvicen.h"
#import "MeterWeekWeathCell.h"

@protocol MeterBaseTableviewDelegate<NSObject>
-(void)tableviewCellClickedatindex:(NSString *)name andid:(NSString *)theid andtag:(NSInteger)mytag;
-(void)cellBtnofmodifyClicked;
@end

@interface MeterBaseTableview : UIView<UITableViewDataSource,UITableViewDelegate,MeterCityCellDelegate>
@property(nonatomic,strong)id<MeterBaseTableviewDelegate>delegate;
@property(nonatomic,retain)NSMutableArray  *dataSource;
@property(nonatomic,retain)UITableView  *meterTable;
@property(nonatomic,retain)MeterProvicen *proince;
@property(nonatomic)sqltestlist  *sqlvalue;
@property(nonatomic)NSInteger tableTag;
@property(nonatomic)NSInteger selectRow; //当前选中行
@property(nonatomic)NSIndexPath *selectIndexpath;
@property(nonatomic)BOOL  isdisplay; //点击tar为1 的cell 来回切换按钮的现实与隐藏状态
@property(nonatomic,retain)MeterWeekWeath *weekWeath;//一周天气数据对象

- (id)initWithFrame:(CGRect)frame andDataArr:(NSMutableArray *)array;
-(void)setTableviewTag:(NSInteger)tag;
-(void)relodataWithArray:(NSMutableArray *)array;
@end
