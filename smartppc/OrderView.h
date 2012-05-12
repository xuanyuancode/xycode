//
//  OrderView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    BOOL status;
}
@property(nonatomic,retain) UITableView * tableview;
@property(nonatomic,retain) UIScrollView * scrollview;
@property(nonatomic,retain) UIButton * button1;
@property(nonatomic,retain) UIButton * button2;
@property(nonatomic,retain) NSArray * list1;
@property(nonatomic,retain) NSArray * list2;
@property(nonatomic,retain) NSArray * orderlist;
@property(nonatomic,retain) NSDictionary * qqdata;
@property(nonatomic,retain) UITextField * password;
@property int alertid;
@property int orderid;
@property int selectline;


- (void)layoutScrollImages;
- (void)goback;
- (void)goforward;
@end
