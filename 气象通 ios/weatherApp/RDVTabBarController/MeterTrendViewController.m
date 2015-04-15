//
//  MeterTrendViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterTrendViewController.h"
#import "WTHTTPClient.h"
#import "Tool.h"
@interface MeterTrendViewController ()

@end

@implementation MeterTrendViewController
{
    NSMutableArray *infoMationArray;


}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    infoMationArray = [[NSMutableArray alloc]init];
    
    [[WTHTTPClient sharedClient]POST:treadUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"----%@",operation.responseString);
        infoMationArray = [Tool getWeatherMation:operation.responseString];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    NSLog(@"dasda");
    
}

- (void)treadRequest
{
    





}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
