//
//  InfoView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView
@synthesize theback,theinfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        theback = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        theback.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5];
        [self addSubview:theback];
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
- (void)loginstep1 
{
    theinfo = [[InfoView_1 alloc] initWithFrame:CGRectMake(113,106, 799, 495)];
    
    [self addSubview:theinfo]; 
}

- (void)loginstep2 
{
[self.theinfo removeFromSuperview];
    theinfo = [[InfoView_2 alloc]initWithFrame:CGRectMake(259,220, 552, 300)];
    [self addSubview:theinfo];
}

- (IBAction)loginstep3:(id)sender
{
    
    [self.theinfo removeFromSuperview];
    theinfo = [[InfoView_3 alloc]initWithFrame:CGRectMake(259,220, 552, 300)];
    [self addSubview:theinfo];
}

@end
