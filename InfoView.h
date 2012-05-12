//
//  InfoView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoView_1.h"
#import "InfoView_2.h"
#import "InfoView_3.h"
@interface InfoView : UIView

@property(nonatomic,retain) UIView * theback;
@property(nonatomic,retain) UIView * theinfo;
- (void)loginstep1;
- (void)loginstep2;
- (IBAction)loginstep3:(id)sender;
@end
