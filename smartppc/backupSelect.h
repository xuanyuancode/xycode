//
//  backupSelect.h
//  smartppc
//
//  Created by iMac02 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved. testing
//

#import <UIKit/UIKit.h>

@interface backupSelect : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mytable;
    NSArray *content;
    UIActivityIndicatorView *indicator;
    UILabel *mynumber;
    int number;
    int count2;
    NSTimer *mytimer;
    UIAlertView *myalert;
}


@property (nonatomic,retain) UITableView *mytable;
@property (nonatomic,retain) NSArray *content;
@property (nonatomic,retain) UIActivityIndicatorView *indicator;
@property (nonatomic,retain) UILabel *mynumber;
@property (nonatomic,retain) NSTimer *mytimer;
@property (nonatomic,retain) UIAlertView *myalert;
- (NSString*)getusernumber;
- (void)savemem;
- (void)loadmem;
- (NSData*)httppost:(NSString *)xql data:(NSData*)data;
@end
