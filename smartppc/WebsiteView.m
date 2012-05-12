//
//  WebsiteView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebsiteView.h"

@implementation WebsiteView

@synthesize title,thetext,scrollview,webpages;


static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255;

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

static int font = 13;
static int width = 580;
static int title_hight = 40;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * web1 = [NSArray arrayWithObjects:@"WorldWarcarft", @"web1.png",@"http://us.battle.net",nil];
        NSArray * web2 = [NSArray arrayWithObjects:@"MTV", @"web2.png",@"http://www.mtv.com",nil];
        NSArray * web3 = [NSArray arrayWithObjects:@"ebay", @"web3.png",@"http://www.ebay.com",nil];
        NSArray * web4 = [NSArray arrayWithObjects:@"weibo", @"web4.png",@"http://weibo.com",nil];
        NSArray * web5 = [NSArray arrayWithObjects:@"plus", @"web_add.png",@"",nil];
        webpages = [[NSArray alloc] initWithObjects:web1,web2,web3,web4,web5,nil];
        
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 70, width-20, 70)];
        scrollview.pagingEnabled=YES;
        
        thetext=[[UILabel alloc]initWithFrame:CGRectMake(20, title_hight, width-40, 25)];
        thetext.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        thetext.text = @"Access websites through portal can get 70% off of charge! Enjoy it now!";
        
        title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, title_hight)];
        title.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.9];
        title.text = @" Favorite Website";
        title.font = [UIFont systemFontOfSize:font + 7];
        title.textColor = [UIColor whiteColor];
        
        [self addSubview:scrollview];
        [self addSubview:thetext];
        [self addSubview:title];
        
        int i;
   
        
        for (i = 1; i<=[webpages count]; i++)
        {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setBackgroundImage:[UIImage imageNamed:[[webpages objectAtIndex:i-1]objectAtIndex:1]] forState:UIControlStateNormal];
            
           // [button setImage:[UIImage imageNamed:[[webpages objectAtIndex:i-1]objectAtIndex:1]] forState:UIControlStateNormal];
            [button addTarget:nil action:@selector(topage:) forControlEvents:UIControlEventTouchDown];
            
            CGRect rect = button.frame;
            rect.size.height = 80 ;
            rect.size.width = 80;
            button.frame = rect;
            button.tag = i;	
            
            if (i == [webpages count]) 
            {
                button.userInteractionEnabled = NO;
            }
            
            [scrollview addSubview:button];
             
        }
        
        [self layoutScrollImages];
        
    }
    return self;
}

- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = scrollview.subviews;
    int X=0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIButton class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(X, 0);
            view.frame = frame;
            X += 120;
        }
    }
    [scrollview setContentSize:CGSizeMake(width, [scrollview bounds].size.height)];
}

/*
- (void)drawRect:(CGRect)rect
{

}
*/

@end