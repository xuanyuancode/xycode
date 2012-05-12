//
//  InfoView_3.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfoView_3.h"

@implementation InfoView_3
@synthesize t1,t2,imgv,l1,l2,b1;

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1]; 
        l1 = [[UILabel alloc]initWithFrame:CGRectMake(40,110, 150,30)];
        l2 = [[UILabel alloc]initWithFrame:CGRectMake(40,150, 150,30)];

        l1.text = @"Mobile Number";
        l2.text = @"Service Password";
        
        l1.font = [UIFont systemFontOfSize:16];
        l2.font = [UIFont systemFontOfSize:16];
        
        l1.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        l2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        
        t1 = [[UITextField alloc]initWithFrame:CGRectMake(200, 110, 150, 30)];
        t1.borderStyle = UITextBorderStyleRoundedRect;
        [t1 addTarget:nil action:@selector(setnumber:) forControlEvents:UIControlEventEditingDidEnd];
        t1.tag=1;
        
        t2 = [[UITextField alloc]initWithFrame:CGRectMake(200, 150, 150, 30)];
        t2.borderStyle = UITextBorderStyleRoundedRect;
         [t2 addTarget:nil action:@selector(setpw:) forControlEvents:UIControlEventEditingDidEnd];
        t2.tag=2;
        
        b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b1 setTitle:@"Login" forState:UIControlStateNormal];
        b1.frame = CGRectMake(260, 220, 100,40);
        [b1 addTarget:self action:@selector(prelogin) forControlEvents:UIControlEventTouchUpInside];
        b1.tag=3;
        
        imgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"n.png"]];
        imgv.frame = CGRectMake(0, 0, 552, 60);
        [self addSubview:l1];
        [self addSubview:l2];
        [self addSubview:b1];
        [self addSubview:t1];
        [self addSubview:t2];
        [self addSubview:imgv];

    }
    return self;
}
-(void)prelogin{
    
    [self.nextResponder.nextResponder.nextResponder performSelector:@selector(login:andString2:) withObject:t1.text withObject:t2.text];
}
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
