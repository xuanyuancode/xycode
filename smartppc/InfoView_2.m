//
//  InfoView_2.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfoView_2.h"

@implementation InfoView_2

@synthesize l1,l2,l3,b1,b2,b3,b4,way,title;

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
        way = 1;
        b1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [b1 setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
        b1.frame = CGRectMake(40, 80,20,20);
        b1.tag = 1;
        [b1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
        
        b2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [b2 setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        b2.frame = CGRectMake(40, 130, 20,20);
        b2.tag = 2;
        [b2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchDown];
        
        b3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b3 setTitle:@"Continue" forState:UIControlStateNormal];
        b3.frame = CGRectMake(380, 240, 100,40);
        [b3 addTarget:nil action:@selector(loginstep3:) forControlEvents:UIControlEventTouchDown];
        
        b4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b4 setTitle:@"Continue" forState:UIControlStateNormal];
        b4.frame = CGRectMake(380, 240, 100,40);
        [b4 addTarget:nil action:@selector(loginsim) forControlEvents:UIControlEventTouchDown];
        [b4 setHidden:YES];
        
        title = [[UILabel alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width,50)];
        l1 = [[UILabel alloc]initWithFrame:CGRectMake(80,80, 200,20)];
        l2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 130, 200,20)];
        l3 = [[UILabel alloc]initWithFrame:CGRectMake(80, 170, 380,50)];
        
        title.text = @"    Plase Choose Login Type";
        l1.text = @"Longin by Accont";
        l2.text = @"Longin by SIM card";
        l3.text = @"Notes: Do not need input any information if authenticating by SIM card automatically";
        
        l3.numberOfLines = 0;
        title.font = [UIFont systemFontOfSize:19];
        l1.font = [UIFont systemFontOfSize:17];
        l2.font = [UIFont systemFontOfSize:17];
        l3.font = [UIFont systemFontOfSize:15];
        
        title.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:1];
        l1.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        l2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        l3.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        
        [self addSubview:title];
        [self addSubview:b1];
        [self addSubview:b2];
        [self addSubview:b3];
        [self addSubview:b4];
        [self addSubview:l1];
        [self addSubview:l2];
        [self addSubview:l3];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
}

- (void)change:(id)sender
{
    UIButton * abutton = (UIButton *) sender;
    way = abutton.tag;
    b3.tag = way;
    if (way==1) {
    [b1 setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
    [b2 setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        [b3 setHidden:NO];
        [b4 setHidden:YES];
    }else {
    [b1 setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
    [b2 setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
    [b3 setHidden:YES];
    [b4 setHidden: NO];
    }
}

@end
