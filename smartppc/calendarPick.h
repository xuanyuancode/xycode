//
//  calendarPick.h
//  smartppc
//
//  Created by iMac02 on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "flightInfo.h"

@interface calendarPick : UIViewController
{
    UIDatePicker *flightdate;
}

@property (nonatomic,retain) UIDatePicker *flightdate;

@end
