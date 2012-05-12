//
//  SmartppcMenu.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartppcMenu : UIView

@property (nonatomic,retain)UILabel * title;
@property (nonatomic,retain)NSArray * list;
@property (nonatomic,retain)UIView * theview;
@property int state;
@property int oldstate;

- (IBAction)clickbutton:(id)sender;

@end
