//
//  videoController.h
//  genie effect
//
//  Created by iMac02 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h> 
#import "SmartPpcVC.h"
#import "AppDelegate.h"
@interface videoController : UIViewController<UIAlertViewDelegate>
{
    BOOL comfirm;
    MPMoviePlayerController *moviePlayerController;
    NSTimer *autoTimer;
    UIActivityIndicatorView *myIndicator;
    BOOL alertStatus;
    BOOL playStatus;
    SmartPpcVC *vc1;
    int count;
    BOOL checkagain;
    BOOL pushstatus;
}
-(IBAction)cancel:(id)sender;
-(void)play;
-(void)lagEffect;
-(void)showspeed;

@property (nonatomic,retain) MPMoviePlayerController *moviePlayerController;
@property (nonatomic,retain) NSTimer *autoTimer;
@property (nonatomic,retain) UIActivityIndicatorView *myIndicator;
@property (nonatomic,retain) SmartPpcVC *vc1;
@property (nonatomic,retain) NSMutableDictionary * thedict;
@property (nonatomic,retain)NSTimer * timer;
@end
