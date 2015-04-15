//
//  MeterViewController.m
//  WeatherApp
//
//  Created by 520 on 14-6-23.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import "MeterViewController.h"

@interface MeterViewController ()<RDVTabBarControllerDelegate>

@end

@implementation MeterViewController
{
    RDVTabBarController *tabbar;


}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title=@"服务";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tabbar = [[RDVTabBarController alloc] init];
    NSLog(@"dsa%@",tabbar);
    [tabbar setTabBarHidden:YES animated:YES];
    [tabbar setDelegate:self];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    

    [tabbar setTabBarHidden:YES animated:YES];
    [super viewWillAppear:animated];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
