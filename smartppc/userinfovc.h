//
//  userinfovc.h
//  smartppc
//
//  Created by 勇 潘 on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userinfovc : UIViewController <UIAlertViewDelegate>
@property(nonatomic,retain) NSArray * names;
@property(nonatomic,retain) NSMutableArray * list;
@property(nonatomic,retain) UIButton * clearbt;
@property(nonatomic,retain) UITextField * password;
@property int alertid;

- (void)clearorder;
- (void)showall;
-(void) pass;
@end
