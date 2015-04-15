//
//  MeterPickerView.m
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.

#import "MeterPickerView.h"

@implementation MeterPickerView
@synthesize viewofTable,textfield,metertext,subview,delegate,isopen;

-(NSString *)text
{
    return metertext;
}

-(UITextField *)textField
{
    return textfield;
}

- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array andtag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        
        isopen = NO;
        subview = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,iphone5?480:370)];
        subview.backgroundColor = [UIColor grayColor];
        subview.tag = 0;
        
        viewofTable = [[MeterBaseTableview alloc] initWithFrame:CGRectMake(0,0,320,iphone5?480:370) andDataArr:array];
        viewofTable.delegate =self;
        [viewofTable  setTableTag:tag];
        [subview addSubview:viewofTable];
        
        textfield = [[UITextField alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        textfield.delegate = self;
        textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self addSubview:textfield];
        
    }
    
    return self;
}

-(void)reloadNewdataWith:(NSMutableArray *)dataArr
{
   
    if ([dataArr count]>0) {
        
        viewofTable.dataSource = dataArr;
        [viewofTable.meterTable  reloadData];
    }
}

#pragma --Mark MeterBaseTableviewDelegateMethod --
-(void)tableviewCellClickedatindex:(NSString *)name andid:(NSString *)theid andtag:(NSInteger)mytag
{
    if ([delegate respondsToSelector:@selector(passtableviewCellbyPicker: andid: andtag:)]) {
        [delegate passtableviewCellbyPicker:name andid:theid andtag:mytag];
    }
    
    textfield.text = name;
    if (subview!=nil) {
        
        subview.tag = 0;
        isopen = NO;
        [subview removeFromSuperview];
    }
}

#pragma --Mark TextFieldDelagate Method --
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (subview.tag == 0) {
        
        subview.tag = 1;
        isopen = YES;
        [self.superview addSubview:subview];
    }
    
    return NO;
}


@end
