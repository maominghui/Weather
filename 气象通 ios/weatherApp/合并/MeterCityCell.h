//
//  MeterCityCell.h
//  Meteorological_app
//
//  Created by zhao on 14-6-24.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  MeterCityCellDelegate<NSObject>
-(void)deleteActionBtnClicked;
-(void)modifyActionBtnClicked;
@end

@interface MeterCityCell : UITableViewCell
@property(nonatomic,retain)id<MeterCityCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *countyLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;
- (IBAction)deleteAction:(id)sender;
- (IBAction)modifyAction:(id)sender;

@end
