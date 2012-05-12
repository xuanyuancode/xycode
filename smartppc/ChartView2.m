//
//  ChartView2.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChartView2.h"

@implementation ChartView2

@synthesize list,title;

static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255;

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

static int width = 690;
static int title_hight = 35;
static int rect_width =150;
static int rect_hight =15;
static int dist_rect = 20;
static int rect_x = 338;
static int rect_y = 14;
static int font = 14;
static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
            }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    id key_topV = @"topV";
    
    list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qsdata.xql?userid=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]];
    
   float total= [[[[NSDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qqdata.xql?user=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]] valueForKey:key_topV] floatValue]; 

    
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, title_hight)]; 
    title.text = @"  Quota Query";
    title.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self addSubview:title];
    

    
    id key1 = @"tel";
    id key2 = @"name";
    id key3 = @"limit"; 
    
    CGContextRef cn = UIGraphicsGetCurrentContext();
    int i;
    for (i=0; i<[list count]; i++) {
        NSDictionary * thedict= [list objectAtIndex:i];
        if ([[thedict objectForKey:key1] length] >0 ) {
             [self drawimg2:[thedict objectForKey:key2] :[thedict objectForKey:key1] :[[thedict objectForKey:key3]floatValue] :total :i :cn];
        }
       
    }  
}

-(void) drawimg2:(NSString*)user:(NSString*)number:(float)theused:(float)thetotal:(int)offset:(CGContextRef)cn
{
    NSString * s1 = [NSString stringWithFormat:@" %0.0fMB",theused];
    NSString * s2 = @"max:";
    CGContextSetLineWidth(cn, 2.0);
    
    
    CGContextSetRGBFillColor (cn, 1, 1, 1, 1);
    CGContextSetRGBStrokeColor(cn, 0.7, 0.7, 0.7, 1);
    
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(rect_x, title_hight+ rect_y + dist_rect *offset)];
    [path1 addLineToPoint:CGPointMake(rect_x + rect_width, title_hight+rect_y+ dist_rect*offset)];
    [path1 addLineToPoint:CGPointMake(rect_x + rect_width, title_hight+rect_y + rect_hight+ dist_rect*offset)];
    [path1 addLineToPoint:CGPointMake(rect_x, title_hight+rect_y + rect_hight+ dist_rect*offset)];
    [path1 closePath];
    [path1 stroke];
    
    CGContextSetRGBFillColor (cn,blue_R,blue_G,blue_B,0.7);
    UIBezierPath * path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(rect_x, title_hight+rect_y + dist_rect*offset)];
    [path2 addLineToPoint:CGPointMake(rect_x + (rect_width * theused/thetotal),title_hight+ rect_y+ dist_rect*offset)];
    [path2 addLineToPoint:CGPointMake(rect_x + (rect_width * theused/thetotal), title_hight+rect_y + rect_hight+ dist_rect*offset)];
    [path2 addLineToPoint:CGPointMake(rect_x,title_hight+ rect_y + rect_hight+ dist_rect*offset)];
    [path2 fill];
    
    CGContextSetRGBFillColor (cn, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(cn, 0, 0, 0, 1);
    [user drawInRect:CGRectMake(30, title_hight+rect_y+ dist_rect*offset, 80, 30) withFont:[UIFont systemFontOfSize:font]];
    [number drawInRect:CGRectMake(140, title_hight+rect_y+ dist_rect*offset, 80, 30) withFont:[UIFont systemFontOfSize:font]];
    
    [s1 drawInRect:CGRectMake(500, title_hight+rect_y+ dist_rect*offset, 80, 30) withFont:[UIFont systemFontOfSize:font]];
    [s2 drawInRect:CGRectMake(290, title_hight+rect_y+ dist_rect*offset, 80, 30) withFont:[UIFont systemFontOfSize:font]];
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

@end
