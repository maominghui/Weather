//
//  MeterNetAlert.h
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeterNetAlert : NSObject
+(MeterNetAlert *)shareinstance;
-(void)showNetalert;

@end
