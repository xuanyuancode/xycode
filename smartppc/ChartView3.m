//
//  ChartView3.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChartView3.h"

@implementation ChartView3
@synthesize title,lable1,lable2,lable3,lable4,lable5,lable6,list;
static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";
static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

static int width = 690;
static int title_hight = 35;
static int font = 14; 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        id type_key = @"svtype";
        id total_key = @"total";
        id rest_key = @"rest";
        list = [NSDictionary dictionaryWithObjectsAndKeys:@"Time based Turbo button",type_key,[NSNumber numberWithFloat:200],total_key,[NSNumber numberWithFloat:80],rest_key, nil]; 
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
   list = [NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=%@",websv,[self getusernumber],@"tb"]]]mutabilityOption:0 format:NULL errorDescription:Nil];
    
    id value_key = @"value";

    
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, title_hight)]; 
    title.text = @"  Tuble button";
    title.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self addSubview:title];
    
    lable1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 250, 30)];;
    lable1.text = @"Service type:Volume based";
    lable1.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable1.font = [UIFont systemFontOfSize:font];

    [self addSubview:lable1];
    
    lable3 = [[UILabel alloc] initWithFrame:CGRectMake(400, 40, 150, 30)];
    lable4 = [[UILabel alloc] initWithFrame:CGRectMake(520, 40, 100, 30)];
    lable3.text = @"Rest Volume:";
   
    lable4.text = [NSString stringWithFormat:@"%dM",[[list objectForKey:value_key]intValue]];
    lable3.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable4.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1]; 
    lable3.font = [UIFont systemFontOfSize:font];
    lable4.font = [UIFont systemFontOfSize:font];
    [self addSubview:lable3];
    [self addSubview:lable4];
}


- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

@end
