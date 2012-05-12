//
//  CloundView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CloundView.h"

@implementation CloundView
@synthesize image,button,title;

static int width = 356;
static int title_hight = 40;

static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255;

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"disk.png"]];
        image.frame = CGRectMake(25, 65, 88, 80);
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(135, 125, 190, 30);
        [button setTitle:@"Backup Now" forState:UIControlStateNormal];
        [button addTarget:nil action:@selector(backuppop:) forControlEvents:UIControlEventTouchDown];
        
        title = [[UILabel alloc]initWithFrame:CGRectMake(0,0, width, title_hight)];
        title.backgroundColor=[UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.9];
        title.text = @"   Cloud Backup";

        [self addSubview:image];
        [self addSubview:button];
        [self addSubview:title];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef cn = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor (cn, 0, 0, 0, 1);    
    NSString * s1 = @"Back up contacts to cloud\n copy contacts to a new\n device with a single click!";
    [s1 drawInRect:CGRectMake(140,60, 190, 55) withFont:[UIFont systemFontOfSize:14]];    

}


@end
