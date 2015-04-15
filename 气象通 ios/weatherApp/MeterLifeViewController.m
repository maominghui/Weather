//
//  MeterLifeViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterLifeViewController.h"
#import "WeatherClient.h"
#import "Tool.h"
#import "LifeTableViewCell.h"


@interface MeterLifeViewController ()
@end

@implementation MeterLifeViewController
{
    UITableView *lifeTableView;
    NSDictionary *lifeArray;


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
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(200, 0, 100, 44)];
    label.text=@"生活指数";
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:18];
    label.textColor=[UIColor blackColor];
    label.backgroundColor=[UIColor clearColor];
    self.navigationItem.titleView=label;

    lifeArray = [NSDictionary new];
    lifeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,iphone5 ? self.view.frame.size.height-45:self.view.frame.size.height-200) style:UITableViewStylePlain];
    [lifeTableView setDelegate:self];
    [lifeTableView setDataSource:self];
    
    [self.view addSubview:lifeTableView];

    [[WeatherClient sharedClient] getPath:lifeURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"life %@",operation.responseString);
        lifeArray = [Tool getLifeIndex:operation.responseString];
        NSLog(@"dasdalife%d",lifeArray.count);
        
        [lifeTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"life%d",lifeArray.count);
    
    return   8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return    80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifer =@"NYImageCell";
    LifeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell ==nil) {
        cell =[[[NSBundle mainBundle] loadNibNamed:@"LifeTableViewCell" owner:self options:nil] lastObject];
    }
    
    if (lifeArray.count > 0) {
    
        if(indexPath.row == 0)
        {
            cell.cellImage.image = [UIImage imageNamed:@"ac.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"ac_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"ac_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"ac_des"];
        
        }
        if (indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"be.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"be_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"be_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"be_des"];
        
        }
        if (indexPath.row == 2) {
            cell.imageView.image = [UIImage imageNamed:@"cl.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"cl_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"cl_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"cl_des"];
            
        }
        if (indexPath.row == 3) {
            
            cell.imageView.image = [UIImage imageNamed:@"co.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"co_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"co_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"co_des"];
            
        }
        if (indexPath.row == 4) {
            
            cell.imageView.image = [UIImage imageNamed:@"ct.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"ct_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"ct_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"ct_des"];
            
        }
        if (indexPath.row == 5) {
            
            cell.imageView.image = [UIImage imageNamed:@"dy.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"dy_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"dy_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"dy_des"];
            
        }
        if (indexPath.row == 6) {
            
            cell.imageView.image = [UIImage imageNamed:@"fs.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"fs_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"fs_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"fs_des"];
            
        }
        if (indexPath.row == 7) {
            
            cell.imageView.image = [UIImage imageNamed:@"gj.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"gj_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"gj_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"gj_des"];
            
        }
        if (indexPath.row == 8) {
            
            cell.imageView.image = [UIImage imageNamed:@"gm.gif"];
            cell.nameLabel.text = [lifeArray objectForKey:@"gm_name"];
            cell.hintLabel.text = [lifeArray objectForKey:@"gm_hint"];
            cell.desLabel.text = [lifeArray objectForKey:@"gm_des"];
            
        }
        
        
        
        
    }
    return cell;
}

#pragma maek -tableView Deleagte

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
