//
//  QuotaQueryView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuotaQueryView : UIView 
@property (nonatomic,retain) NSArray *thedic;
@property (nonatomic,retain) UILabel * title1;
@property (nonatomic,retain) UILabel * title2;

@property (nonatomic,retain) UIImageView * img1;
@property (nonatomic,retain) UIImageView * img2;
@property (nonatomic,retain) UIImageView * img3;
@property (nonatomic,retain) UIImageView * img4;
@property (nonatomic,retain) UIImageView * img5;

@property(nonatomic,retain) NSDictionary *qqdata;
@property(nonatomic,retain) NSDictionary *tbdata;
@property(nonatomic,retain) NSDictionary *pcdata;
@property(nonatomic,retain) NSDictionary *qsdata;

@property(nonatomic,retain) UIScrollView * scrollview;

-(void) drawchart:(CGContextRef)cn;
@end
