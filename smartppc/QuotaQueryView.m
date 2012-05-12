//
//  QuotaQueryView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuotaQueryView.h"
#import "ChartView2.h"
#import "ChartView3.h"
#import "ChartView4.h"

@implementation QuotaQueryView

@synthesize thedic,title1,title2,img1,img2,img3,img4,img5,scrollview,qqdata,pcdata,qsdata,tbdata;

static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

static int radius_center_x = 130;
static int radius_center_y = 110;
static int radius_max = 55;
static int radius_min = 23;
static float pai = 3.1415926;
static int width = 738;
static int title_hight = 40;
static int font = 14;
static int list_x = 260;


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
        
        title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, title_hight)];
        title1.text = @"Detail Volume";
        title1.backgroundColor=[UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.9];
        title1.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        title1.font = [UIFont systemFontOfSize:font+7];
        title1.textAlignment=UITextAlignmentCenter;
        [self addSubview:title1];
        
        title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 212, width, title_hight)];
        title2.text = @"Service";
        title2.backgroundColor=[UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.9];
        title2.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        title2.font = [UIFont systemFontOfSize:font+7];
        title2.textAlignment=UITextAlignmentCenter;
        [self addSubview:title2];
        
        img1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x.png"]];
        img1.frame = CGRectMake(list_x, 54, 20, 20);
        [self addSubview:img1];
        
        img2 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x.png"]];
        img2.frame = CGRectMake(list_x, 54+30, 20, 20);
        [self addSubview:img2];
        
        img3 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x.png"]];
        img3.frame = CGRectMake(list_x, 54+60, 20, 20);
        [self addSubview:img3];
        
        img4 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x.png"]];
        img4.frame = CGRectMake(list_x, 54+90, 20, 20);
        [self addSubview:img4];
        

       qqdata = [[NSDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qqdata.xql?user=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]];    
        
        //[self haha];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
   CGContextRef cn = UIGraphicsGetCurrentContext();
    [self drawchart:cn]; 
}

-(void) drawchart:(CGContextRef)cn
{
    id key_topV = @"topV";
    id key_package = @"package";
    id key_actualV = @"actualV";
    id key_chargeV = @"chargeV";
    id key_nopackageV = @"nopackageV";
    id key_speed = @"speed";
 
    
 int total = [[qqdata valueForKey:key_topV] intValue];
 int used = [[qqdata valueForKey:key_chargeV] intValue];
 int speed = [[qqdata valueForKey:key_speed] intValue];
 int package = [[qqdata valueForKey:key_package] intValue];
 int actualV = [[qqdata valueForKey:key_actualV] intValue];
 int chargeV = [[qqdata valueForKey:key_chargeV] intValue];
 int NpackageV = [[qqdata valueForKey:key_nopackageV] intValue];
    
    NSURL * aurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@orderitem.xql",websv]];
    NSArray *orderlist = [[NSArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:aurl]mutabilityOption:0 format:NULL errorDescription:Nil]];
    
    id key_volume =@"volume";
    NSString * as = [[orderlist objectAtIndex:(package-1001)] objectForKey:key_volume];    
    package = [as intValue];
    
    CGContextSetLineWidth(cn, 2.0);
    
    CGContextSetRGBStrokeColor(cn, 0.7, 0.7, 0.7, 1);
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:CGPointMake(radius_center_x,radius_center_y) radius:radius_max startAngle:0 endAngle:7 clockwise:YES];
    [path1 stroke];
    
    CGContextSetRGBFillColor(cn, blue_R, blue_G, blue_B, 0.9);
    
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(radius_center_x,radius_center_y)];
    [path2 addArcWithCenter:CGPointMake(radius_center_x,radius_center_y) radius:radius_max startAngle:-pai/2 endAngle:pai*2*used/total - pai/2 clockwise:YES];
    [path2 closePath];
    [path2 fill];
    
    CGContextSetRGBFillColor (cn, yellow_R,yellow_G,yellow_B, 1);
    UIBezierPath * path3 = [UIBezierPath bezierPath];
    [path3 addArcWithCenter:CGPointMake(radius_center_x, radius_center_y) radius:radius_min startAngle:0 endAngle:7 clockwise:YES];
    [path3 fill];
    [path3 stroke];
    
    
    CGContextSetRGBFillColor (cn, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(cn, 0, 0, 0, 1);
    
    NSString * s1 = [NSString stringWithFormat:@"%dMB",used];
     NSString * s2 = [NSString stringWithFormat:@"%dMB",total];
     NSString * s3 = [NSString stringWithFormat:@"%d％%",used*100/total];
     NSString * s4 = [NSString stringWithFormat:@"%dKB/S",speed];
     NSString * s5 = [NSString stringWithFormat:@"Your package: %dM/month",package];
     NSString * s6 = [NSString stringWithFormat:@"Actual Volume: %dM",actualV];
     NSString * s7 = [NSString stringWithFormat:@"Charge Volume: %dM",chargeV];
     NSString * s8 = [NSString stringWithFormat:@"Non-package Volume %dM",NpackageV];
     NSString * s10 = [NSString stringWithFormat:@"%dMB",NpackageV];
     NSString * s11 = @"The Volume saved";
    

    [s1 drawInRect:CGRectMake(60, 47, 60, 30) withFont:[UIFont systemFontOfSize:font]];
    [s2 drawInRect:CGRectMake(170, 47, 60.0, 30.0) withFont:[UIFont systemFontOfSize:font]];
    [s3 drawInRect:CGRectMake(radius_center_x - 13, radius_center_y -10, 40, 30) withFont:[UIFont systemFontOfSize:font]];
    [s4 drawInRect:CGRectMake(103, 172, 100.0, 30.0) withFont:[UIFont systemFontOfSize:font+4]];
    [s5 drawInRect:CGRectMake(list_x + 30 , 54, 210.0, 20.0) withFont:[UIFont systemFontOfSize:font]];
    [s6 drawInRect:CGRectMake(list_x + 30 , 54+30, 210.0, 20.0) withFont:[UIFont systemFontOfSize:font]];
    [s7 drawInRect:CGRectMake(list_x + 30 , 54+60, 210.0, 20.0) withFont:[UIFont systemFontOfSize:font]];
    [s8 drawInRect:CGRectMake(list_x + 30 , 54+90, 210.0, 20.0) withFont:[UIFont systemFontOfSize:font]];
    [s10 drawInRect:CGRectMake(570 , 130, 100.0, 50.0) withFont:[UIFont systemFontOfSize:font+6]];
    [s11 drawInRect:CGRectMake(520 , 75, 200.0, 60.0) withFont:[UIFont systemFontOfSize:font+2]];
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 262, 690,300)];
    [scrollview addSubview:[[ChartView2 alloc]initWithFrame:CGRectMake(0, 0, 690,130)]];
    [scrollview addSubview:[[ChartView3 alloc]initWithFrame:CGRectMake(0, 130, 690,130)]];
    [scrollview addSubview:[[ChartView4 alloc]initWithFrame:CGRectMake(0, 260, 690,130)]];
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0,520,690,130)];
    aview.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, title_hight)]; 
    title.text = @"  X-Day-Pass";
    title.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [aview addSubview:title];
    UILabel *showsv = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 400, 30)]; 
    
    showsv.text = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getxdaypassname.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
    showsv.font = [UIFont systemFontOfSize:font];
    showsv.backgroundColor=[UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    [aview addSubview:showsv];
    
    
    [scrollview addSubview:aview];
    
    
    UIView *aview2 = [[UIView alloc]initWithFrame:CGRectMake(0,390,690,130)];
    aview2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    UILabel *title21 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, title_hight)]; 
    title21.text = @"  FaceBook Zero";
    title21.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [aview2 addSubview:title21];
    UILabel *showsv2 = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 400, 30)]; 
    
    if ([[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@webisfree.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue] == 1) 
    {
        showsv2.text = @"ON";}else {
            showsv2.text = @"Off";
        }
    
    showsv2.font = [UIFont systemFontOfSize:font];
    showsv2.backgroundColor=[UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    [aview2 addSubview:showsv2];
    [scrollview addSubview:aview2];

    [scrollview setContentSize:CGSizeMake(690,130*5)];
    [self addSubview:scrollview];
    
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

@end
