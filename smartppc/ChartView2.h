//
//  ChartView2.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartView2 : UIView

@property (nonatomic,retain) NSArray * list;
@property (nonatomic,retain) UILabel * title;
-(void) drawimg2:(NSString*)user:(NSString*)number:(float)theused:(float)thetotal:(int)offset:(CGContextRef)cn;
-(void) drawimg3:(NSString*)user:(NSString*)number:(float)theused:(float)thetotal:(int)offset:(CGContextRef)cn;

@end
