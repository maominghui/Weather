//
//  MeterBaseTableview.m
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
// 注意：当tableTag为1时 :选择简单的cell，当为2是选择省份cell，当为3时为市，为4时为县tag。当为5时选择生活的自定义cell，当为6时选择未来天气的Cell，通过不同的tag选取不同的cell

#import "MeterBaseTableview.h"

@implementation MeterBaseTableview
@synthesize dataSource,meterTable,tableTag;
@synthesize delegate,proince,sqlvalue,isdisplay,selectRow,selectIndexpath,weekWeath;

- (id)initWithFrame:(CGRect)frame andDataArr:(NSMutableArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        isdisplay = NO;
        selectRow = 0;
        selectIndexpath = 0;
        weekWeath = [[MeterWeekWeath alloc] init];
        dataSource = [[NSMutableArray alloc] initWithArray:array];
        CGRect  frame1 = CGRectMake(frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
        sqlvalue = [[sqltestlist alloc] init];
        meterTable = [[UITableView alloc] initWithFrame:frame1];
        [meterTable setDelegate:self];
        [meterTable setDataSource:self];
        meterTable.autoresizingMask = UIViewAutoresizingFlexibleHeight  |
        UIViewAutoresizingFlexibleWidth   |
        UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleTopMargin;
        meterTable.showsHorizontalScrollIndicator = NO;
        meterTable.showsVerticalScrollIndicator = NO;
        [self addSubview:meterTable];
        [meterTable reloadData];
    }
    
    return self;
}

-(void)setTableviewTag:(NSInteger)tag
{
    tableTag = tag;
}

-(void)relodataWithArray:(NSMutableArray *)array
{
   
    dataSource = array;
    [meterTable reloadData];
}

#pragma --Mark WarnCustomtableview Delegate Method ---
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([dataSource count]>0) {
        
        return  [dataSource count];
    }
    return 10;
}

//绘制Cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger  row = [indexPath row];
    static NSString *cellIdentifier = @"cell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (tableTag) {
            
        case 1:               //城市选择
        {
            static  NSString  *Identifier = @"MeterCityCell";
            MeterCityCell  *cell = [tableView  dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeterCityCell" owner:self options:nil] lastObject];
            }
            
            cell.deleteBtn.hidden = YES;
            cell.modifyBtn.hidden = YES;
            cell.delegate = self;
            if ([dataSource count]>0) {
                sqlvalue = [dataSource objectAtIndex:row];
                cell.countyLabel.text = sqlvalue.countyName;
            }
            
            return cell;
        }
            
            break;
            
        case 2:            //省份选择
        case 3:           //市选择
        case 4:          //县选择
        {
            
            static  NSString  *Identifier = @"menuCell";
            UITableViewCell  *cell = [tableView  dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            if ([dataSource count]>0) {
                proince = [dataSource objectAtIndex:row];
                cell.textLabel.text = proince.provinceName;

            }
            return cell;
        }
            break;
        case 5:             //生活选择
        {
        
        }
            break;
        case 6:             //未来天气选择
        {
            
            static  NSString  *Identifier = @"MeterWeekWeathCell";
            MeterWeekWeathCell  *cell = [tableView  dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MeterWeekWeathCell" owner:self options:nil] lastObject];
                if ([dataSource count]>0) {
                    
                     weekWeath = [dataSource objectAtIndex:row];
                }
               
                cell.weekDateLabel.text = weekWeath.weekWeathDate;
                [cell.WeathStateImgView  setImage:[UIImage imageNamed:weekWeath.weekWeathImgname]];
                cell.weekTempLabel.text = weekWeath.weekWeathTemp;
            
            }

            return cell;
            
        }
            break;
    }
    
     return cell;
}

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (tableTag) {
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            
            return 70;
            break;
        default:
            break;
    }
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger  row = [indexPath row];
    selectRow = row;
    selectIndexpath = indexPath;
    NSString  *tempname = [[NSString alloc] init];
    NSString  *tempid = [[NSString alloc] init];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([dataSource count]>0) {
        
        switch (tableTag) {
            case 1:
            {
                
                tempname = [dataSource objectAtIndex:row];
                tempid = nil;
                NSIndexPath  *indexpath1 = [NSIndexPath indexPathForItem:row inSection:0];
                MeterCityCell  *cell = [meterTable cellForRowAtIndexPath:indexpath1];
                
                if (isdisplay) {
                    cell.deleteBtn.hidden = YES;
                    cell.modifyBtn.hidden = YES;
                }else {
                    
                    cell.deleteBtn.hidden = NO;
                    cell.modifyBtn.hidden = NO;
                
                }
                
                isdisplay = !isdisplay;
            }
                
                break;
            case 2:
            case 3:
            case 4:
            {
                proince = [dataSource objectAtIndex:row];
                tempid = proince.provinceId;
                tempname = proince.provinceName;
            }
                break;
            case 5:
            {
                
            }
                
                break;
            case 6:
            {
                
            }
                
                break;
            default:
                break;
        }
        
    } else {
     
        tempid = nil;
        tempname = nil;
    }
    
    if ([delegate  respondsToSelector:@selector(tableviewCellClickedatindex: andid: andtag:)]) {
        [delegate tableviewCellClickedatindex:tempname andid:tempid andtag:tableTag];
    }
}

#pragma --Mark  MeterCityCellDelegateMethod---
-(void)deleteActionBtnClicked
{
    NSLog(@"*******************%d",selectRow);
    sqlvalue = [dataSource objectAtIndex:selectRow];
    [[MeterSQLMag shareinstance] deleterecord:sqlvalue];
    [dataSource removeObjectAtIndex:selectRow];
    [meterTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:selectIndexpath] withRowAnimation:UITableViewRowAnimationRight];
    [meterTable reloadData];
}

#pragma --Mark 此处只是在通过tabtag值在MeterCitySelectViewController去调用push方法 --
-(void)modifyActionBtnClicked
{
   
    if ([delegate respondsToSelector:@selector(cellBtnofmodifyClicked)]) {
        [delegate cellBtnofmodifyClicked];
    }
}

@end
