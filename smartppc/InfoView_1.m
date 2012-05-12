//
//  InfoView_1.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfoView_1.h"

@implementation InfoView_1
@synthesize img,b1,b2,b3,agree,l1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        agree = 0;
        img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"info1.png"]];
        img.frame = CGRectMake(0, 0, 799 , 415);
        
        l1 = [[UILabel alloc]initWithFrame:CGRectMake(140,420,500 ,25)];
        l1.text = @"I have read and agree to the terms and privacy policy";
        l1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        l1.font = [UIFont systemFontOfSize:17];
        
        
        b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b1 setTitle:@"Cancel" forState:UIControlStateNormal];
        b1.frame = CGRectMake(self.frame.size.width * 0.2, self.frame.size.height * 0.9, self.frame.size.width * 0.15 , self.frame.size.height * 0.08);
        
        
        b2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b2 setTitle:@"Continue" forState:UIControlStateNormal];
        b2.frame = CGRectMake(self.frame.size.width * 0.6, self.frame.size.height * 0.9, self.frame.size.width * 0.15 , self.frame.size.height * 0.08);
        [b2 addTarget:nil action:@selector(loginstep2) forControlEvents:UIControlEventTouchDown];
        b2.enabled = NO;
        
        b3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [b3 setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        b3.frame = CGRectMake(self.frame.size.width * 0.2 - 50, self.frame.size.height * 0.85, 30,30);
        [b3 addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
        
        
        [self addSubview:img];
        [self addSubview:b1];
        [self addSubview:b2];
        [self addSubview:b3];
        [self addSubview:l1];
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

- (void)change
{
    if (agree == 0) {
        agree = 1;
        [b3 setImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];
        b2.enabled = YES;
    }else {
        agree = 0;
        [b3 setImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
        b2.enabled = NO;
    } 
}

@end
