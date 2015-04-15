//
//  MeterCityCell.m
//  Meteorological_app
//
//  Created by zhao on 14-6-24.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import "MeterCityCell.h"

@implementation MeterCityCell
@synthesize deleteBtn,modifyBtn,delegate;

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (IBAction)deleteAction:(id)sender {
    
    if ([delegate  respondsToSelector:@selector(deleteActionBtnClicked)]) {
        [delegate  deleteActionBtnClicked];
    }
}

- (IBAction)modifyAction:(id)sender {
    
    if ([delegate  respondsToSelector:@selector(modifyActionBtnClicked)]) {
        [delegate  modifyActionBtnClicked];
    }

}
@end
