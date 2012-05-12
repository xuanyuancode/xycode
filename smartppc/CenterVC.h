//
//  CenterVC.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartView.h"
#import "OrderView.h"
#import "VediosView.h"
#import "CloundView.h"
#import "WebsiteView.h"
#import "SmartPpcVC.h"
#import "WebVC.h"
#import "videoController.h"
#import "InfoView.h"
#import "backupSelect.h"
#import "flightInfo.h"


@interface CenterVC : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>
@property(nonatomic,retain) ChartView *chartview;
@property(nonatomic,retain) OrderView *orderview;
@property(nonatomic,retain) VediosView *vedioview;
@property(nonatomic,retain) CloundView * cloudview;
@property(nonatomic,retain) WebsiteView * websiteview;
@property(nonatomic,retain) NSMutableDictionary * qqdata;
@property(nonatomic,retain) InfoView * infoview;
@property int orderid;
@property(nonatomic,retain) NSString * number;
@property(nonatomic,retain) NSString * pw;
@property Boolean pass;
@property(nonatomic,retain)NSString* alertmsg;
@property(nonatomic,retain)NSTimer * timer;
@property (nonatomic,retain) backupSelect *backupObj;
@property (nonatomic,retain) UIPopoverController *backupPicker;
@property (nonatomic,retain) NSString * package; 



/////////////
@property (nonatomic,retain) UILabel *usernameLabel,*totalSaving;
@property int oldbyte;
@property int speed;
@property Boolean limited;
- (IBAction)topage:(id)sender;
- (IBAction)tomenu:(id)sender;
- (IBAction)play:(id)sender;
-(UIImage *)addText:(UIImage *)img text:(NSString *)text1;
- (void)loadtheview;
- (IBAction)login:(id)sender;
- (IBAction)setpw:(id)sender;
- (IBAction)setnumber:(id)sender;
- (void)loginsim;
- (void)loadqqdata;
- (void)sendorder;
- (NSData*)httppost:(NSString *)xql data:(NSData*)data;
- (NSString*)getusernumber;
- (void)showchartview;
- (void)pushad;
@end
