//
//  FacebookZeroView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FacebookZeroView.h"

@implementation FacebookZeroView

@synthesize state,lable1,lable2,lable3,b1,on,password,alertid;
static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

static int width = 750;
static int font = 14; 

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255; 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    on = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@webisfree.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    lable1.text = @"  TIP";
    lable1.textColor = [UIColor whiteColor];
    lable1.font = [UIFont systemFontOfSize:font+5];
    lable1.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width, 40)];
    lable2.font = [UIFont systemFontOfSize:font+3];
    lable2.text = @"     To access Facebook with unlimited traffic";
    lable2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    
    [self addSubview:lable1];
    [self addSubview:lable2];
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(20,80, 700, 80)];
    aview.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    UIImageView * aimgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebook.png"]];
    aimgview.frame= CGRectMake(10, 10, 60, 60);
    
    UILabel * alable1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 150, 25)];
    alable1.text = @"  Facebook Zero";
    alable1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    UILabel * alable2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 150, 25)];
    alable2.text = @"  5 $/Month";
    alable2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b1.frame = CGRectMake(500, 40, 110, 35);
    if (on == 0) {
        [b1 setTitle:@"Buy" forState:UIControlStateNormal];
    }else {
        [b1 setTitle:@"Cancel" forState:UIControlStateNormal];
    }
    [b1 addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchDown];
    
    [aview addSubview:alable1];[alable1 release];
    [aview addSubview:alable2];[alable2 release];
    [aview addSubview:b1];
    [aview addSubview:aimgview];[aimgview release];
    
    [self addSubview:aview];[aview release];
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    [fm release];
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

- (IBAction)buy:(id)sender
{
    UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    [myAlertView1 addSubview:password];
    
    on = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@webisfree.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
    if (on == 0){alertid = 100;}else {
        alertid = 101;
    }
    
    [myAlertView1 show];
    [myAlertView1 release];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
    }

    if (buttonIndex == 1) {
    if ([password.text isEqualToString:@"1234"]) {
        [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@fbonoff.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
        switch (alertid)
        {
            case 100:
            {
                [b1 setTitle:@"Cancel" forState:UIControlStateNormal];
                UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your service has been actived successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aout show];
                [aout release];
            }
                break;
            case 101:
            {
                 [b1 setTitle:@"Buy" forState:UIControlStateNormal];  
                UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your service has been cancel" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aout show];
                [aout release];
            }
                break;
            default:
                break;
        }
        
        alertid = 0;
    }
    else {
        UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your password is incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [error show];
        [error release];
    }
    }}

@end
