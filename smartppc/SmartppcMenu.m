//
//  SmartppcMenu.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SmartppcMenu.h"
#import "QuotaQueryView.h"
#import "X-Day-Pass.h"
#import "TurboButtonView.h"
#import "ParentalControlView.h"
#import "FacebookZeroView.h"
#import "HistoryView.h"
#import "QuoteSharingView.h"


@implementation SmartppcMenu

@synthesize title,theview,list,state,oldstate;

static int width = 740;
static int hight = 560;
static int button_width = 230;
static int button_hight = 56;
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
        self.state = 1005;
        self.oldstate = 1005;
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        
        }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    list = [[NSArray alloc] initWithObjects:@"Turbo Button",@"Parental Control",@"Quota Sharing",@"FaceBook Zero",@"X-Day Pass",@"Quota Query",@"History", nil];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1024, title_hight)];
    title.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.9];
    [self addSubview:title];
    
    theview = [[UIView alloc]initWithFrame:CGRectMake(250, 60, 750, 580)];
    theview.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    [self addSubview:theview];
    
    
    int i;
    for (i=0; i<[list count]; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:[list objectAtIndex:i] forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 40 + button_hight*i + 1, button_width, button_hight);
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button];
    }
    
    switch (state)
    {
        case 1000:
            [theview addSubview:[[TurboButtonView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1001:
            [theview addSubview:[[ParentalControlView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1002:
            [theview addSubview:[[QuoteSharingView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1003:
            [theview addSubview:[[FacebookZeroView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1004: 
            [theview addSubview:[[X_Day_Pass alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1005:
            [theview addSubview:[[QuotaQueryView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1006:
            [theview addSubview:[[HistoryView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        default:
            break;
    }

}


- (IBAction)clickbutton:(id)sender
{
    UIButton * thebutton = (UIButton *)sender;
    oldstate = state;
    [self setValue:[NSNumber numberWithInt:thebutton.tag] forKey:@"state"];
}

@end
