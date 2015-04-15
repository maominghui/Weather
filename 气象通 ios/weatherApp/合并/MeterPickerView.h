//
//  MeterPickerView.h
//  Meteorological_app
//
//  Created by zhao on 14-6-22.
//  Copyright (c) 2014年 ZLJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeterBaseTableview.h"

@protocol MeterPickerViewDelegate<NSObject>
-(void)passtableviewCellbyPicker:(NSString *)name andid:(NSString *)theid andtag:(NSInteger)mytag;
@end

@interface MeterPickerView : UIView<UITextFieldDelegate,MeterBaseTableviewDelegate>
@property(nonatomic,strong)id<MeterPickerViewDelegate>delegate;
@property(nonatomic,retain)MeterBaseTableview *viewofTable;
@property(nonatomic,retain)UITextField  *textfield;
@property(nonatomic,strong)NSString  *metertext;
@property(nonatomic,retain)UIView  *subview;
@property(nonatomic)BOOL isopen; //利用bool值判断导航正确pop

- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array andtag:(NSInteger)tag;
-(void)reloadNewdataWith:(NSMutableArray *)dataArr;
-(NSString *)text;
-(UITextField *)textField;
@end
