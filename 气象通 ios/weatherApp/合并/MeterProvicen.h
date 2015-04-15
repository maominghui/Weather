//
//  MeterProvicen.h
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeterProvicen : NSObject
@property(nonatomic,strong)NSString  *provinceName; //省份名字
@property(nonatomic,strong)NSString  *provinceId;  //省份编码

-(id)initWithName:(NSString *)name andId:(NSString *)theid;

@end
