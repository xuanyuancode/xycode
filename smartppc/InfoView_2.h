//
//  InfoView_2.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoView_2 : UIView
@property(nonatomic,retain) UILabel * title;
@property(nonatomic,retain) UILabel * l1;
@property(nonatomic,retain) UILabel * l2;
@property(nonatomic,retain) UILabel * l3;
@property(nonatomic,retain) UIButton * b1;
@property(nonatomic,retain) UIButton * b2;
@property(nonatomic,retain) UIButton * b3;
@property(nonatomic,retain) UIButton * b4;
@property int way;


- (void)change:(id)sender;
@end
