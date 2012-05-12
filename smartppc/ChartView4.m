//
//  ChartView4.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChartView4.h"

@implementation ChartView4
@synthesize title,list;

static int width = 690;
static int title_hight = 35;
static int font = 15; 

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;
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
    list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=pc",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]]; 
    
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, title_hight)]; 
    title.text = @"  Parents Control";
    title.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self addSubview:title];
    
    id tel_key = @"tel";
    id game_key = @"game";
    id shop_key = @"shop";
    id sn_key = @"sn";
    
    int i;
    for (i = 0; i <[list count]; i++)
    {
        if (![[[list objectAtIndex:i] objectForKey:tel_key] isEqualToString:@""]) {
            UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 50+i*40, 120, 20)];
            lable1.backgroundColor =[UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
            lable1.font = [UIFont systemFontOfSize:font];  
            lable1.text = [[list objectAtIndex:i] objectForKey:tel_key];
            
            UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(170, 50+i*40, 120, 20)]; 
            lable2.backgroundColor =[UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
            lable2.font = [UIFont systemFontOfSize:font];
            if ([[[list objectAtIndex:i] objectForKey:game_key] intValue] ==0) {
                lable2.text = @"game";
            }else {
                lable2.text = @"*game";
            }
            
            
            UILabel *lable3 = [[UILabel alloc]initWithFrame:CGRectMake(320, 50+i*40, 120, 20)];
            lable3.backgroundColor =[UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
            lable3.font = [UIFont systemFontOfSize:font];  
            if ([[[list objectAtIndex:i] objectForKey:shop_key] intValue] ==0) {
                lable3.text = @"shoping";
            }else {
                lable3.text = @"*shoping";
            }
            
            UILabel *lable4 = [[UILabel alloc]initWithFrame:CGRectMake(470, 50+i*40, 120, 20)]; 
            lable4.backgroundColor =[UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
            lable4.font = [UIFont systemFontOfSize:font];
            if ([[[list objectAtIndex:i] objectForKey:sn_key] intValue] ==0) {
                lable4.text = @"sn";
            }else {
                lable4.text = @"*sn";
            }
            
            [self addSubview:lable1];[lable1 release];
            [self addSubview:lable2];[lable2 release];
            [self addSubview:lable3];[lable3 release];
            [self addSubview:lable4];[lable4 release];
        }
        
    }
}
        

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    [fm release];
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

                          
@end
