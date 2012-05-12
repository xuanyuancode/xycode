//
//  ParentalControlView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentalControlView : UIView <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,retain) UITableView * tableview;
@property(nonatomic,retain) NSMutableArray * list;
@property(nonatomic,retain) UILabel * lable1;
@property(nonatomic,retain) UILabel * lable2;
@property(nonatomic,retain) UILabel * lable3;
@property(nonatomic,retain) UIButton * b1;
@property (nonatomic,retain) UITextField *password;
@property int state;
@property int alertid;


@property int on;

- (IBAction)buy:(id)sender;
- (NSString*)getusernumber;
- (IBAction)change1:(id)sender;
- (IBAction)change2:(id)sender;
- (NSData*)httppost:(NSString *)xql data:(NSData*)data;
@end
