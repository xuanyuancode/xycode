//
//  QuoteSharingView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuoteSharingView :UIView <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,retain)NSMutableArray * list;
@property(nonatomic,retain)UITableView * tableview;
@property(nonatomic,retain) UIButton * b1;
@property(nonatomic,retain) UILabel * lable1;
@property(nonatomic,retain) UILabel * lable2;
@property(nonatomic,retain) UILabel * lable3;

@property(nonatomic,retain)UITextField * t11;
@property(nonatomic,retain)UITextField * t12;
@property(nonatomic,retain)UITextField * t13;
@property(nonatomic,retain)UITextField * t1;
@property(nonatomic,retain)UITextField * t2;
@property(nonatomic,retain)UITextField * t3;
@property(nonatomic,retain)UITextField * password;
@property int lines;
@property int alertid;

- (IBAction)buy:(id)sender;
- (void)sendorder;
-(IBAction)subrow:(id)sender;
-(IBAction)addrow:(id)sender;
- (NSData*)httppost:(NSString *)xql data:(NSData*)data;
- (NSString*)getusernumber;

@end
