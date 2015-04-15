//
//  MeterLoginViewController.m
//  Meteorological_app
//
//  Created by zhao on 14-6-21.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterLoginViewController.h"
#import "Tool.h"
#import "WeatherClient.h"
#import "AFHTTPRequestOperation.h"
#import "UserLoginInfoCache.h"
#import "MeterViewController.h"
#import "UserLoginInfo.h"
#import "AFNetworking.h"
#import "NetWorkStateCache.h"
#import "Config.h"
#import "AppDelegate.h"
@interface MeterLoginViewController ()<RDVTabBarControllerDelegate>
{
    int netState;
    int angle;
    int first;
    UserLoginInfo *userLoginInfo;
    RDVTabBarController *tabBarController;
}
@end

@implementation MeterLoginViewController
@synthesize loginButton;
@synthesize IphoneNum;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    IphoneNum.hidden=YES;
    [self checkNetwork];

}

-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    // get a rect for the textView frame
    CGRect btnFrame = self.view.frame;
    btnFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height+ btnFrame.size.height-100 );
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    [UIView setAnimationDelegate:self];
    
    // set views with new info
    self.view.frame = btnFrame;
    // commit animations
    [UIView commitAnimations];
}
-(void)keyboardWillHide:(NSNotification *)note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // get a rect for the textView frame
    CGRect btnFrame = self.view.frame;
    btnFrame.origin.y = self.view.bounds.size.height - btnFrame.size.height;
    
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // set views with new info
    self.view.frame = btnFrame;
    
    // commit animations
    [UIView commitAnimations];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    if(![touch isKindOfClass:[UITextField class]])
    {
        [IphoneNum resignFirstResponder];
    }
}
#pragma mark 监测网络状态
//AFNetworkReachabilityStatusUnknown          = -1,  未知
//AFNetworkReachabilityStatusNotReachable     = 0,   未连接
//AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
//AFNetworkReachabilityStatusReachableViaWiFi = 2,   无线连接
-(void)checkNetwork
{
   __block int netWorkState;
    NSURL *url=[NSURL URLWithString:@"http://www.apple.com"];
    AFHTTPClient *client=[[AFHTTPClient alloc] initWithBaseURL:url];
    [client setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status){
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"无线网络");
                netWorkState=2;
                [[NetWorkStateCache alloc] saveNetWorkState:netWorkState];
                 break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G网络");
                netWorkState=1;
                [[NetWorkStateCache alloc] saveNetWorkState:netWorkState];
                break;
             case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"未连接");
                netWorkState=0;
                [[NetWorkStateCache alloc] saveNetWorkState:netWorkState];
                break;
              case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知错误");
                netWorkState=-1;
                [[NetWorkStateCache alloc] saveNetWorkState:netWorkState];
                break;
        }
    }];
    NSLog(@"netWorkState===%d",netWorkState);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    tabBarController = [[RDVTabBarController alloc]init];
    
    first=0;
    self.view.backgroundColor=[UIColor redColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    loginButton.frame=CGRectMake(self.view.frame.size.width/2-30, self.view.frame.size.height/2-60,80,80);
    loginButton.center=self.view.center;
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:8.0];  //设置矩圆角半径
    [loginButton.layer setBorderWidth:3.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [loginButton.layer setBorderColor:colorref];//边框颜色
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}//13086668835
-(void)getRequest
{
    [[WeatherClient sharedClient] postPath:LOGINAPI parameters:[NSDictionary dictionaryWithObjectsAndKeys:IphoneNum.text,@"phonenumber",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"===operator==%@",operation.responseString);
       userLoginInfo=[Tool getLoginRequest:operation.responseString];
        NSLog(@"===userLoginInfo==%@",userLoginInfo);
        [self isPushView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求是举失败:%@",error);
    }];

}
- (IBAction)loginAction:(id)sender {
    MeterViewController *meterView=[MeterViewController new];
    loginButton.userInteractionEnabled=NO;
    netState=[[NetWorkStateCache alloc] getNetWorkState];
    if(netState>0)
    {
        
       

//        if(netState==2)
//        {
//            [self startAnimation];
//            [[AFNYClient sharedClient] postPath:LOGINAPI parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"15290315091",@"phonenumber",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSLog(@"===operator==%@",operation.responseString);
//                userLoginInfo=[Tool getLoginRequest:operation.responseString];
//                NSLog(@"===userLoginInfo==%@",userLoginInfo.loginCount);
//                if([userLoginInfo.loginCount intValue]==1)
//                {
//                    [self.navigationController pushViewController:meterView animated:YES];
//                }else
//                {
//                    [self startAnimation];
//                }
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                NSLog(@"请求是举失败:%@",error);
//            }];
//
//        }else{
        
         first++;
          if(first==1)//
          {
            NSDictionary *userDic=[[UserLoginInfoCache alloc] getUserLoginInfo];
            if([userDic objectForKey:@"userId"])
            {
                if(netState==1)
                {
                    NSLog(@"netstate===111111==");
                    [self startAnimation];
                    loginButton.userInteractionEnabled=YES;
                    NSLog(@"userDic===%@",[userDic objectForKey:@"userId"]);
                    first=0;
                    [self.navigationController pushViewController:meterView animated:YES];
                }else if(netState==2)
                {
                    NSLog(@"netstate===22222==");
                    [self startAnimation];
                    [[WeatherClient sharedClient] postPath:LOGINAPI parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"15290315091",@"phonenumber",nil] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"===operator==%@",operation.responseString);
                        userLoginInfo=[Tool getLoginRequest:operation.responseString];
                        NSLog(@"===userLoginInfo==%@",userLoginInfo.loginCount);
                        loginButton.userInteractionEnabled=YES;
                       
                        if([userLoginInfo.loginCount intValue]==1)
                        {
                            [self isPushView];
                        }else
                        {
                            [self startAnimation];
                            loginButton.userInteractionEnabled=YES;
                        }
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"请求是举失败:%@",error);
                        loginButton.userInteractionEnabled=YES;
                    }];
                    
                }
              }else{
                 IphoneNum.hidden=NO;
                 }
            }else if(first==2){//网络请求
               [self getRequest];
              }
        }else{
              [self startAnimation];
       }
      
}
-(void)isPushView
{
    MeterViewController *meterView=[MeterViewController new];
    NSLog(@"userid==******=%@",userLoginInfo);
    //if([userLoginInfo.loginCount intValue]==1)
    //{
        first=0;
    
    
        [self.navigationController presentViewController:meterView animated:YES
                                              completion:^{
                                                  
                                              }];
    
    
    

   // }else
    //{
     //   first=0;
    //}
    
    NSLog(@"sada");

}

- (void)viewDidDisappear:(BOOL)animated
{
    

}
-(void)viewDidAppear:(BOOL)animated{
}

-(void)startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    loginButton.transform=CGAffineTransformMakeRotation(angle*(M_PI/180.0));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    angle+=90;
    if(angle==360*10+90)
    {
        angle=90;
        loginButton.userInteractionEnabled=YES;
    }
    else
    {
        loginButton.userInteractionEnabled=NO;
        [self startAnimation];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    loginButton.userInteractionEnabled=YES;
    

}
@end
