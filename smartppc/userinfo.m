//
//  userinfo.m
//  smartppc
//
//  Created by 勇 潘 on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "userinfo.h"

@implementation userinfo
@synthesize names,list;

static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

- (id)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        NSString * as = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@userinfo.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
        list = [as componentsSeparatedByString:@","];
        names = [[NSArray alloc]initWithObjects:@"name",@"access",@"location",@"devtype",@"devsz",@"age",@"gender",nil];
    }
    
    for (int i=0; i<[self.list count]; i++) {
        [self showline:i];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showline: (int)i
{
    UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 40 + i*50, 100, 30)];
    l1.text = [names objectAtIndex:i];
    [l1 release];
    UITextField * t1 = [[UITextField alloc]initWithFrame:CGRectMake(200, 40+i*50, 100, 30)];
    t1.borderStyle = UITextBorderStyleRoundedRect;
    t1.text = [list objectAtIndex:i]; 
    [t1 release];
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
