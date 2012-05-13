//
//  WebVC.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVC : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>
{
    BOOL alertStatus;
}
@property(nonatomic,retain)UIWebView * webview;
@property(nonatomic,retain) NSString * url;
@property(nonatomic,retain)NSTimer * timer;
//@property(nonatomic,retain)NSTimer * timer2;
@property(nonatomic,retain)NSMutableArray * thefind;
@property int speed; 
@property int free;
@property Boolean limited;
@property int oldbyte;
@property(nonatomic,retain) UIButton * bbt;
@property(nonatomic,retain) UIButton * fbt;

- (void)showspeed;
- (NSString*)getusernumber;
- (void) addlike:(NSString*) like;
- (int)truevolume;
@end
