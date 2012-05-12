//
//  ChartView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChartView.h"

@implementation ChartView

@synthesize total,used,button,package,img;

static int width = 580;
static int title_hight = 40;

static int img_width = 216;
static int img_hight = 70;
static int img_x = 50;
static int img_y = 70;

static int font = 14;

static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255;

static float green_R = 131.0/255;
static float green_G = 200.0/255;
static float green_B = 10.0/255;

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        button.frame = CGRectMake(450, 100, 110, 35);
        //[button setTitle:@"See Details" forState:UIControlStateNormal];
        button.tag = 1005;
        [button addTarget:nil action:@selector(tomenu:) forControlEvents:UIControlEventTouchDown];
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        [self addSubview:button];
        img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"newvolume.png"]];
        img.frame = CGRectMake(img_x, img_y, img_width, img_hight);
        [self addSubview:img];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
      UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(300,50,190,60)];
    alable.numberOfLines = 0;
      alable.text = package;
      alable.backgroundColor = [UIColor clearColor];
      CGContextRef cn = UIGraphicsGetCurrentContext();
    [self addSubview:alable];
      [self drawfirst:cn];
      [self drawimg:used :total :cn];
}

-(void) drawimg:(int)theused:(int)thetotal:(CGContextRef)cn
{
    NSString * s1 = [NSString stringWithFormat:@" Used: %dMB",theused];
    NSString * s2 = [NSString stringWithFormat:@" Total:%dMB",thetotal]; 
    
    CGContextSetLineWidth(cn, 2.0);
    
    
    CGContextSetRGBFillColor (cn, 1, 1, 1, 1);
    CGContextSetRGBStrokeColor(cn, 0.7, 0.7, 0.7, 1);
    
    /*
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(img_x,img_y)];
    [path1 addLineToPoint:CGPointMake(img_x + img_width, + img_y)];
    [path1 addLineToPoint:CGPointMake(img_x + img_width, img_y + img_hight)];
    [path1 addLineToPoint:CGPointMake(img_x, img_y + img_hight)];
    [path1 closePath];
    [path1 stroke];
     */
    
    CGContextSetRGBFillColor (cn,green_R,green_G,green_B,1);
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(img_x+4, img_y+4)];
    [path2 addLineToPoint:CGPointMake(img_x+4 + ((img_width-9) * theused/thetotal), img_y+4)];
    [path2 addLineToPoint:CGPointMake(img_x+4 + ((img_width-9) * theused/thetotal), img_y + 60)];
    [path2 addLineToPoint:CGPointMake(img_x+4, img_y + 60)];
    [path2 fill];
    
    CGContextSetRGBFillColor (cn, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(cn, 0, 0, 0, 1);

    [s1 drawInRect:CGRectMake(img_x+245, img_y + img_hight -40 , 150, 40) withFont:[UIFont systemFontOfSize:font+3]];
    [s2 drawInRect:CGRectMake(img_x + 245, img_y + img_hight -10 , 200, 40) withFont:[UIFont systemFontOfSize:font+3]];
}

-(void) drawfirst:(CGContextRef)cn
{
    CGContextSetRGBFillColor(cn, blue_R, blue_G, blue_B, 0.8);
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0, 0)];
    [path1 addLineToPoint:CGPointMake(width, 0)];
    [path1 addLineToPoint:CGPointMake(width,title_hight)];
    [path1 addLineToPoint:CGPointMake(0,title_hight)];
    [path1 closePath]; 
    [path1 fill];
    
    CGContextSetRGBFillColor (cn, 1, 1, 1, 1); 
    NSString * s3 = @"Bandwidth Management";
    [s3 drawInRect:CGRectMake(5, 8, 400, title_hight) withFont:[UIFont systemFontOfSize:font + 7]];
}

@end
