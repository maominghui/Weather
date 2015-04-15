//
//  LifeTableViewCell.h
//  WeatherApp
//
//  Created by 1_7 on 14-6-25.
//  Copyright (c) 2014年 TuringTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cellImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;
@property (strong, nonatomic) IBOutlet UILabel *desLabel;

@end
