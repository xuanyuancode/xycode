//
//  AppDelegate.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CenterVC;
@class flightInfo;
@class flightResult;

#define APPDELEGATE [[UIApplication sharedApplication]delegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    flightInfo *fv; 
    flightResult *resultFlight;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) flightResult *resultFlight;
@property (nonatomic,retain) flightInfo *fv;

- (NSString*)getusernumber;
@end
