//
//  flightDetails.h
//  smartppc
//
//  Created by iMac02 on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class flightInfo;
@interface flightDetails : UIView
{
    UILabel *flightModel,*departureTime,*flightTime,*airport,*lowestOffer;
    UILabel *flightModel1,*departureTime1,*flightTime1,*airport1,*lowestOffer1;
    UIButton *order;
    NSArray *line1,*line2,*line3,*line4,*line5;
    BOOL checkstatus;
    NSString *departTime;

}
-(void)firstline;
@property (nonatomic,retain) UILabel *flightModel,*departureTime,*airport,*lowestOffer,*flightTime;
@property (nonatomic,retain) UILabel *flightModel1,*departureTime1,*airport1,*lowestOffer1,*flightTime1;
@property (nonatomic,retain) UIButton *order;
@property (nonatomic,retain) NSArray *line1,*line2,*line3,*line4,*line5;
@property (nonatomic,retain) NSString *departTime;
@end
