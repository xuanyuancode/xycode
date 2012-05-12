//
//  cityTolist.h
//  smartppc
//
//  Created by iMac02 on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "flightInfo.h"
@interface cityTolist : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *citytotable;
    
    NSMutableArray *tocitylist;
}

@property (nonatomic,retain) UITableView *citytotable;
@property (nonatomic,retain) NSMutableArray *tocitylist;
@end
