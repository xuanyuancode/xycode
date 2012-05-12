//
//  QuoteSharingView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface QuoteSharingView :UIView <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *myarray;
    UITextField *number1;
    UITextField *number2;
    UITextField *name1;
    UITextField *name2;
    UITextField *quote;
    UITextField *quote2;
    
    NSMutableArray *nameArray;
    NSMutableArray *limitArray;
    NSMutableArray *telArray;
    int countAdd;
    NSMutableArray *addtofile;
    BOOL saveStatus;
    BOOL filestatus;
    NSMutableArray *addFavour;
    UITextField *password;
    
    UIButton *minusButton;
    
    BOOL tipstatus;
    BOOL tipstatus2;
    BOOL noralstatus;
    BOOL passwordStatus;
    
    NSString *getNumber2;
    NSString *getName2;
    NSString *getQuote2;
    
    
    UILabel *name22,*quoteLabel22,*number22;
    
    UILabel *lable1;
}

@property (nonatomic,retain) NSString *getNumber2,*getName2,*getQuote2;
@property (nonatomic,retain) NSMutableArray *nameArray,*limitArray,*telArray;
@property (nonatomic,retain) UIButton *minusButton;
@property (nonatomic,retain) UITextField *password;
@property(nonatomic,retain)NSArray * list;
@property(nonatomic,retain)UITableView * tableview;
@property(nonatomic,retain) UIButton * b1;
@property(nonatomic,retain) UILabel * lable1;
@property(nonatomic,retain) UILabel * lable2;
@property(nonatomic,retain) UILabel * lable3;
@property (nonatomic,retain) NSMutableArray *myarray;
@property (nonatomic,retain) UITextField *number1,*number2,*name1,*name2;
@property (nonatomic,retain) UITextField *quote,*quote2;
@property (nonatomic,retain)    UILabel *name22,*quoteLabel22,*number22;
@property (nonatomic,retain) NSMutableArray *addtofile;
@property (nonatomic,retain) NSMutableArray *addFavour;
- (IBAction)buy:(id)sender;
@end
