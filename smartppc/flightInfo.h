//
//  flightInfo.h
//  smartppc
//
//  Created by iMac02 on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class flightCityList;
@class cityTolist;
@class CalendarController;
@class flightDetails;
@class flightResult;
@class calendarPick;
#import "pickdatetime.h"

@interface flightInfo : UIViewController
{
    UIButton *cityButton,*toButton,*dateButton,*searchButton,*order;
    UIPopoverController *popover,*popover2,*popover3;
    flightCityList *flight;
    cityTolist *cityto;
    CalendarController *picktime;
    flightDetails *flightinfoDetails;
    UITextField *password;
    NSArray *myarray;
    BOOL pushStatus;
    NSString *departtime;
    NSString *departcity;
    NSString *arrive;
    int indexing;
    int indexing2;
    calendarPick *calendarObj;
}
@property (nonatomic,retain) calendarPick *calendarObj;
@property (nonatomic,retain) UIButton *cityButton,*toButton,*dateButton,*order;
@property (nonatomic,retain) UIPopoverController *popover,*popover2,*popover3;
@property (nonatomic,retain) flightCityList *flight;
@property (nonatomic,retain) cityTolist *cityto;
@property (nonatomic,retain) CalendarController *picktime;
@property (nonatomic,retain) UIButton *searchButton;
@property (nonatomic,retain) flightDetails *flightinfoDetails;
@property (nonatomic,retain) UITextField *password;
@property (nonatomic,retain) NSArray *myarray;
@property (nonatomic,retain) NSString *departtime;
@property (nonatomic,retain) NSString *departcity;
@property (nonatomic,retain) NSString *arrive;
@property (nonatomic,assign) int indexing;
@property (nonatomic,assign) int indexing2;
@end

