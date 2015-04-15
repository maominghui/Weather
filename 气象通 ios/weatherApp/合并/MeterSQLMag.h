//
//  MeterSQLMag.h
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class sqltestlist;

@interface MeterSQLMag : NSObject
@property(nonatomic)sqlite3  *db;
+(MeterSQLMag *)shareinstance;

-(void)insertrecord:(sqltestlist *)insertlist;
-(void)modifyRecord:(sqltestlist *)mopdifylist;
-(void)deleterecord:(sqltestlist *)deletelist;
-(NSMutableArray *)displayData;

@end

@interface sqltestlist : NSObject

@property(nonatomic,retain)NSString  *countyName; //县名
@property(nonatomic,retain)NSString  *countyId;  //id
@property(nonatomic,strong)NSString  *cityId; //市id

@end

