//
//  flightResult.h
//  smartppc
//
//  Created by iMac02 on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "flightInfo.h"
@interface flightResult : UIViewController
{
    UILabel *testLabel;
    UILabel *departtimelabel1,*departtimelabel2,*departtimelabel,*departtimelabel3;
    BOOL departstatus;
    UILabel *pushDetails;
    UILabel *pushDetails2;
}
@property (nonatomic,retain) UILabel *departtimelabel1,*departtimelabel2,*departtimelabel,*departtimelabel3;
@property (nonatomic,retain) UILabel *testLabel;
@property (nonatomic,retain) UILabel *pushDetails,*pushDetails2;
@end
