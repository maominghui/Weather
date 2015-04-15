//
//  MeterNetAlert.m
//  Meteorological_app
//
//  Created by zhao on 14-6-23.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterNetAlert.h"

@implementation MeterNetAlert
+(MeterNetAlert *)shareinstance
{
    static MeterNetAlert *shareinstance_ = nil;
    static dispatch_once_t Token;
    dispatch_once(&Token,^{
        shareinstance_ = [[MeterNetAlert alloc] init];
    
    });
    
    return shareinstance_;
}

-(void)showNetalert
{

    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"网络状态不好，请检查您的网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    alert.cancelButtonIndex = 0;
    [alert show];
    [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:2];
}

-(void)dismissAlert:(UIAlertView *)alert
{

    if (alert.visible) {
        
        [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:YES];
    }

}

@end
