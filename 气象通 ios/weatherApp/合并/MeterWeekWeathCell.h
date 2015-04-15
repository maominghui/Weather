//
//  MeterWeekWeathCell.h
//  Meteorological_app
//
//  Created by NyistMacBook on 14-6-24.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeterWeekWeathCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *WeathStateImgView;
@property (weak, nonatomic) IBOutlet UILabel *weekDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekTempLabel;

@end
