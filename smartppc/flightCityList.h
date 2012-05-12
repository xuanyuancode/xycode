//
//  flightCityList.h
//  smartppc
//
//  Created by iMac02 on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "flightInfo.h"
@interface flightCityList : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *cityTable;
    NSMutableArray *citylist;
    
}
@property (nonatomic,retain) UITableView *cityTable;
@property (nonatomic,retain) NSMutableArray *citylist;


@end
