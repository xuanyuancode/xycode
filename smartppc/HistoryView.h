//
//  HistoryView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property(nonatomic,retain) NSArray * daylist;
@property(nonatomic,retain) NSArray * monthlist;
@property(nonatomic,retain) UITableView * tableview;


@end
