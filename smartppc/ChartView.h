//
//  ChartView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView : UIView


@property float total;
@property float used;
@property(nonatomic,retain) NSString * package;
@property(nonatomic,retain) UIButton * button;
@property(nonatomic,retain) UIImageView * img;


-(void) drawimg:(int)theused:(int)thetotal:(CGContextRef)cn;
-(void) drawfirst:(CGContextRef)cn;

@end
