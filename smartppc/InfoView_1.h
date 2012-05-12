//
//  InfoView_1.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoView_1 : UIView
@property(nonatomic,retain) UIImageView * img;
@property(nonatomic,retain) UIButton * b1;
@property(nonatomic,retain) UIButton * b2;
@property(nonatomic,retain) UIButton * b3;
@property(nonatomic,retain) UILabel * l1;
@property int agree;

- (void)change;

@end
