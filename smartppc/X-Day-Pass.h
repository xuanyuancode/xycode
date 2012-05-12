//
//  X-Day-Pass.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface X_Day_Pass : UIView <UITableViewDelegate,UITableViewDataSource>
{
    UITextField *password;
    int buttonTag;
    BOOL infostatus;
    int countButton;
    BOOL buttonStatus;
    BOOL cancelStatus;
}

@property(nonatomic,retain) UILabel * lable1;
@property(nonatomic,retain) UILabel * lable2;
@property(nonatomic,retain) UILabel * lable3;
@property(nonatomic,retain) UITableView * tableview;
@property(nonatomic,retain) NSArray * list;
@property(nonatomic,retain) NSString * ordername;
@property (nonatomic,retain)UITextField *password;
- (IBAction)buy:(id)sender;
- (NSString*)getusernumber;
@end
