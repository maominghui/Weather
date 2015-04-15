//
//  MeterCitySelectViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
#import "MeterCitySelectViewController.h"

@interface MeterCitySelectViewController ()

@end

@implementation MeterCitySelectViewController
@synthesize leftButton,rightButton,cityTableview,sqlvalue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sqlvalue = [[sqltestlist alloc] init];
    cityTableview = [[MeterBaseTableview alloc] initWithFrame:CGRectMake(0,0,320,iphone5?480:370) andDataArr:[[MeterSQLMag shareinstance] displayData]];
    cityTableview.delegate = self;
    [cityTableview setTableTag:1];
    [self.view addSubview:cityTableview];
    [self createNavitems];
}

#pragma --Mark MeterBaseTableViewDelegate Method --
-(void)cellBtnofmodifyClicked
{
   
     [self performSelector:@selector(addNewCitybtnClicked) withObject:nil afterDelay:0];

}

-(void)tableviewCellClickedatindex:(NSString *)name andid:(NSString *)theid andtag:(NSInteger)mytag
{

}

-(void)createNavitems
{

    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame: CGRectMake(0,0, 35, 35)];
    [leftButton setImage:[UIImage imageNamed:@"arraw_left.png"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"arraw_left.png"] forState:UIControlStateSelected];
    [leftButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    UIBarButtonItem   *LeftBarbutton = [[UIBarButtonItem  alloc] initWithCustomView:leftButton];
    [self.navigationItem   setLeftBarButtonItem:LeftBarbutton];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightButton  setFrame:CGRectMake(0,0,40,40)];
    [rightButton  addTarget:self action:@selector(addNewCitybtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateSelected];
    UIBarButtonItem   *rightBarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem  setRightBarButtonItem:rightBarbtn];
   
}

-(void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [cityTableview relodataWithArray:[[MeterSQLMag shareinstance] displayData]];
}

-(void)addNewCitybtnClicked
{
    MeterAddcityViewController  *addcityVC = [[MeterAddcityViewController alloc] init];
    [self.navigationController pushViewController:addcityVC animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
