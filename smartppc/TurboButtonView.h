//
//  TurboButtonView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TurboButtonView : UIView <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain) UILabel * lable1;
@property(nonatomic,retain) UILabel * lable2;
@property(nonatomic,retain) UILabel * lable3;
@property(nonatomic,retain) UIButton* b1;

@property(nonatomic,retain) UISlider * s1;
@property(nonatomic,retain) UISlider * s2;
@property(nonatomic,retain) UILabel * l1;
@property(nonatomic,retain) UILabel * l2;

@property(nonatomic,retain) UITableView * tableview;
@property(nonatomic,retain) NSMutableDictionary * thedata;
@property int state;
@property(nonatomic,retain)UITextField *password;

- (IBAction) send:(id)sender;
@end
