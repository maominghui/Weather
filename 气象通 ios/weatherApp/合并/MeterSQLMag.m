//
//  MeterSQLMag.m
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterSQLMag.h"

@implementation MeterSQLMag
@synthesize db;

+(MeterSQLMag *)shareinstance
{
    //单例模式
    static MeterSQLMag  *shareinstance_ = nil;
    static dispatch_once_t onetoken;
    dispatch_once(&onetoken,^{
        
        shareinstance_ = [[MeterSQLMag alloc] init];
    });
    return shareinstance_;
}

-(NSString *)FilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDir  = [path objectAtIndex:0];
    NSLog(@"=======%@",documentDir);
    return [documentDir stringByAppendingPathComponent:@"data.db"];
}

-(BOOL)openDB{
    
    NSString  *path = [self FilePath];
    NSLog(@"%@",path);
    NSFileManager  *fm = [NSFileManager defaultManager];
    BOOL isfind = [fm fileExistsAtPath:path];
    if (isfind) {
        //数据库路径存在去打开数据库文件
        if (sqlite3_open([path UTF8String],&db)!=SQLITE_OK) {
            sqlite3_close(db);
            return NO;
        }
        //创建一个新表
        [self  creatanewtable:db];
        return YES;
    }
    if (sqlite3_open([path UTF8String],&db)==SQLITE_OK) {
        
        [self  creatanewtable:db];
        return YES;
        
    }else {
        
        sqlite3_close(db);
        return NO;
    }
    return NO;
}

-(BOOL)creatanewtable:(sqlite3 *)database
{
    char *sql = "create table if not exists countyTable(ID INTEGER PRIMARY KEY AUTOINCREMENT, countyname text,countyid text,cityid text)";
    sqlite3_stmt *statement;
    NSInteger sqlreturn = sqlite3_prepare_v2(db,sql,-1,&statement,nil);
    if (sqlreturn!=SQLITE_OK) {
        NSLog(@"建表失败");
        return NO;
    }
    //执行sql语句
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);//释放对象
    if (success !=SQLITE_DONE) {
        
        NSLog(@"failed create table test");
        return NO;
    }
    NSLog(@"Create table succcessed");
    return YES;
}

-(void)insertrecord:(sqltestlist *)insertlist;
{
    
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~:%@",insertlist.cityId);
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~:%@",insertlist.countyId);
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~:%@",insertlist.countyName);
    
    if ([self openDB]) {
        sqlite3_stmt *staement = nil;
        static char *sql = "INSERT INTO countyTable(countyname, countyid, cityid) VALUES(?, ?, ?)";
        int success2 = sqlite3_prepare_v2(db,sql,-1,&staement,NULL);
        if (success2!=SQLITE_OK) {
            
            sqlite3_close(db);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"插入查询语句失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            [alert show];
        }
        
        //利用值绑定写入数据库
        sqlite3_bind_text(staement,1,[insertlist.countyName UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(staement,2,[insertlist.countyId UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(staement,3,[insertlist.cityId UTF8String],-1,SQLITE_TRANSIENT);
        
        success2 = sqlite3_step(staement);
        sqlite3_finalize(staement);
        if (SQLITE_ERROR == success2) {
            sqlite3_close(db);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"添加数据失败...." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            [alert show];
        }
        sqlite3_close(db);
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据库打开失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
    }
}

-(void)modifyRecord:(sqltestlist *)mopdifylist
{
    if ([self openDB]) {
        sqlite3_stmt *statement = nil;
        
        char *sql = "update countyTable set cityid = ? and countyid = ? WHERE countyname = ?";
        int success = sqlite3_prepare_v2(db,sql,-1,&statement,NULL);
        if (success!=SQLITE_OK) {
            
            sqlite3_close(db);
        }
        
        sqlite3_bind_text(statement,3,[mopdifylist.cityId UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,2,[mopdifylist.countyId UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,1,[mopdifylist.countyName UTF8String],-1,SQLITE_TRANSIENT);
        success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success == SQLITE_ERROR) {
            sqlite3_close(db);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据库更新数据失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
            [alert show];
        }
        
        sqlite3_close(db);
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据库打开失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
    }
}

-(void)deleterecord:(sqltestlist *)deletelist
{
    
    if ([self openDB]) {
        sqlite3_stmt  *statement = nil;
        static char *sql = "delete from countyTable  where countyname = ? and countyid = ? and cityid = ?";
        int success = sqlite3_prepare_v2(db,sql,-1,&statement,NULL);
        if (success!=SQLITE_OK) {
            
            sqlite3_close(db);
        }
        sqlite3_bind_text(statement,1,[deletelist.countyName UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,2,[deletelist.countyId UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement,3,[deletelist.cityId UTF8String],-1,SQLITE_TRANSIENT);
        
        success = sqlite3_step(statement);
        sqlite3_finalize(statement);
        if (success == SQLITE_ERROR) {
            
            sqlite3_close(db);
        }
        
        sqlite3_close(db);
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据库打开失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
    }
}

-(NSMutableArray *)displayData
{
    NSMutableArray  *array = [NSMutableArray arrayWithCapacity:10];
    if ([self openDB]) {
        sqlite3_stmt *stament = nil;
        char *sql = "SELECT countyname, countyid, cityid FROM countyTable";
        if (sqlite3_prepare_v2(db,sql,-1,&stament,NULL)!=SQLITE_OK) {
            
            NSLog(@"********************");
            return NO;
        }else {
            
            while (sqlite3_step(stament) == SQLITE_ROW) {
                
                sqltestlist  *sqlist = [[sqltestlist alloc] init];
                char *name = (char *)sqlite3_column_text(stament,0);
                sqlist.countyName = [[NSString alloc] initWithUTF8String:name];
                char *theid =(char *)sqlite3_column_text(stament,1);
                sqlist.countyId = [[NSString alloc]initWithUTF8String:theid];
                
                char *cityCode =(char *)sqlite3_column_text(stament,2);
                sqlist.cityId = [[NSString alloc]initWithUTF8String:cityCode];
                [array addObject:sqlist];
            }
        }
        
        sqlite3_finalize(stament);
        sqlite3_close(db);
        
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"数据库打开失败!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        return NO;
    }
    
    return array;
}

@end

@implementation  sqltestlist
@synthesize countyId,countyName,cityId;

-(id)init
{
    countyName = @"";
    countyId = @"";
    cityId = @"";
    return self;
}

@end