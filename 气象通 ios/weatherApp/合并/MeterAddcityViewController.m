//
//  MeterAddcityViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MeterAddcityViewController.h"

@interface MeterAddcityViewController ()
@end

@implementation MeterAddcityViewController
@synthesize leftButton,rightButton,meterBackImg;
@synthesize provincesLabel,cityLabel,countryLabel;
@synthesize provincesTextfield,cityTextfield,countryTextfield;
@synthesize provicenPicker,cityPicker,countryPicker,tempArr,sqlValue,addcityAlert,currCityCode;

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
    currCityCode = [[NSString alloc] init];
    [[MeterNetAlert shareinstance] showNetalert];
    sqlValue = [[sqltestlist alloc] init];
    [self myinit];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    provicenPicker = [[MeterPickerView alloc] initWithFrame:provincesTextfield.frame withArray:data andtag:2];
    provicenPicker.delegate = self;
    [self.view addSubview:provicenPicker];
    
    cityPicker = [[MeterPickerView alloc] initWithFrame:cityTextfield.frame withArray:data andtag:3];
    cityPicker.delegate= self;
    [self.view addSubview:cityPicker];
    
    countryPicker = [[MeterPickerView alloc] initWithFrame:countryTextfield.frame withArray:data andtag:4];
    countryPicker.delegate = self;
    [self.view addSubview:countryPicker];
    [self createNaviitems];
    [[AFNYClient sharedClient] postPath:PROVICENADDRESS parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"*****:%@",operation.responseString);
        NSLog(@"list=====***====data:%@",operation.responseString);
        NSMutableArray  *dataArr = [[MeterTools shareInstance] getproince:operation.responseString];
        [provicenPicker reloadNewdataWith:dataArr];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[MeterNetAlert shareinstance] showNetalert];
    }];
}

-(void)myinit
{
    meterBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,iphone5?480:370)];
    if (iphone5) {
        [meterBackImg setImage:[UIImage imageNamed:@"地区界面1.png"]];
    }
    [meterBackImg setImage:[UIImage imageNamed:@"地区界面2.png"]];
    [self.view addSubview:meterBackImg];
    
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,40,40)];
    [imgview setImage:[UIImage imageNamed:@"spinner_img.png"]];
    provincesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,iphone5?180:140,100,20)];
    provincesLabel.textAlignment = NSTextAlignmentLeft;
    provincesLabel.font = [UIFont systemFontOfSize:15];
    provincesLabel.text = @"省份/直辖市";
    provincesLabel.textColor = [UIColor blackColor];
    [self.view addSubview:provincesLabel];
    
    provincesTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20,iphone5?212:162,280,40)];
    provincesTextfield.font = [UIFont fontWithName:@"Courer-Bold" size:17];
    provincesTextfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
    provincesTextfield.rightView = imgview;
    provincesTextfield.rightViewMode = UITextFieldViewModeUnlessEditing;
    
    [self.view addSubview:provincesTextfield];
    
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,40,40)];
    [imgview setImage:[UIImage imageNamed:@"spinner_img.png"]];
    cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,iphone5?260:210,100,20)];
    cityLabel.textAlignment = NSTextAlignmentLeft;
    cityLabel.font = [UIFont systemFontOfSize:15];
    cityLabel.text = @"市";
    cityLabel.textColor = [UIColor blackColor];
    [self.view addSubview:cityLabel];
    cityTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20,iphone5?282:232,280,40)];
    cityTextfield.font = [UIFont fontWithName:@"Courer-Bold" size:17];
    cityTextfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cityTextfield.rightView = imgview;
    cityTextfield.rightViewMode = UITextFieldViewModeUnlessEditing;
    
    [self.view addSubview:cityTextfield];
    
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,40,40)];
    [imgview setImage:[UIImage imageNamed:@"spinner_img.png"]];
    countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,iphone5?340:282,100,20)];
    countryLabel.textAlignment = NSTextAlignmentLeft;
    countryLabel.font = [UIFont systemFontOfSize:15];
    countryLabel.text = @"县";
    countryLabel.textColor = [UIColor blackColor];
    [self.view addSubview:countryLabel];
    
    countryTextfield = [[UITextField alloc] initWithFrame:CGRectMake(20,iphone5?372:304,280,40)];
    countryTextfield.font = [UIFont fontWithName:@"Courer-Bold" size:17];
    countryTextfield.backgroundColor = [UIColor groupTableViewBackgroundColor];
    countryTextfield.rightView = imgview;
    countryTextfield.rightViewMode = UITextFieldViewModeUnlessEditing;
    [self.view addSubview:countryTextfield];
}

-(void)createNaviitems
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
    [rightButton  addTarget:self action:@selector(addNewCitySurebtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateSelected];
    UIBarButtonItem   *rightBarbtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem  setRightBarButtonItem:rightBarbtn];
    
}

#pragma --Mark MeterPickerDelegate Method --

-(void)passtableviewCellbyPicker:(NSString *)name andid:(NSString *)theid andtag:(NSInteger)mytag
{
    switch (mytag) {
        case 1:
            
            break;
        case 2:
        {
            if (theid !=nil) {
                
                NSString  *urlStr = [NSString stringWithFormat:@"%@%@",CITYADDRESS,theid];
                [[AFNYClient sharedClient] postPath:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSLog(@"list=====***====data:%@",operation.responseString);
                    NSMutableArray  *dataArr = [[MeterTools shareInstance] getproince:operation.responseString];
                    [cityPicker  reloadNewdataWith:dataArr];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            }
        }
            break;
        case 3:
        {
        
            if (theid !=nil) {
                
                currCityCode = theid;
                NSString  *urlStr = [NSString stringWithFormat:@"%@%@",COUNTRYADDRESS,theid];
                NSLog(@"HHHHHHHHHH:%@",theid);
                [[AFNYClient sharedClient] postPath:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSLog(@"list=====***====data:%@",operation.responseString);
                    NSMutableArray  *dataArr = [[MeterTools shareInstance] getproince:operation.responseString];
                    [countryPicker  reloadNewdataWith:dataArr];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            }
        }
            
            break;
        case 4:
        {
            if (name!=nil && theid!=nil) {
                
                sqlValue.cityId = currCityCode;
                sqlValue.countyName = name;
                sqlValue.countyId = theid;
            }
        }
            break;
        case 5:
            
            break;
        case 6:
            
            break;
            
        default:
            break;
    }
}

-(void)backButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)addNewCitySurebtnClicked
{
    
    if ([self istextfielsEmpty]) {
        
        NSLog(@"&&&&&&&:%@",sqlValue.countyId);
        [[MeterSQLMag shareinstance] insertrecord:sqlValue];
        addcityAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"天气城市添加成功，是否继续添加" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        addcityAlert.delegate = self;
        [addcityAlert show];
        
    }else {
    
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"选择省份或市不完整，请选择完整" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)istextfielsEmpty
{
    if ([provicenPicker.textField.text length]>0 && [cityPicker.textField.text length]>0
        && [countryPicker.textField.text length]>0) {
        
        return  YES;
    }
    
    return NO;
}

#pragma --Mark UIALertViewDelegateMethod --
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (alertView == addcityAlert) {
        
        if (buttonIndex ==alertView.cancelButtonIndex) {
            
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
