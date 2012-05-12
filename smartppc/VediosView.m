//
//  VediosView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VediosView.h"

@implementation VediosView
@synthesize pc,scrollview;

static int width=580;
static int hight=200;
static int intro_hight = 40;
static int vnum = 3;
static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, width, hight)];
        int i;
        for (i = 1; i <= vnum; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"movie%d.png",i]] forState:UIControlStateNormal];
            
            CGRect rect = button.frame;
            rect.size.height = hight;
            rect.size.width = width;
            button.frame = rect;
            button.tag = i;	
           
            switch (i)
            {
                case 1:
                    [button addTarget:nil action:@selector(play:) forControlEvents:UIControlEventTouchDown];
                    break;
                case 2:
                {
                    [button addTarget:nil action:@selector(pushad) forControlEvents:UIControlEventTouchDown];
                    UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(width/2, hight/2, 300, 40)];
                    l1.text = [NSString stringWithFormat:@"xday pass in %@",[[self loaddb] objectAtIndex:0]] ;
                    
                    
                    l1.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
                    [button addSubview:l1];
                    
                }
                    
                    break;
                case 3:
                    [button addTarget:nil action:@selector(pushfly) forControlEvents:UIControlEventTouchDown];
                    break;
                default:
                    break;
            }       

            [scrollview addSubview:button];
        }
        [self layoutScrollImages];
        scrollview.delegate = self;
        scrollview.pagingEnabled =YES;
        [self addSubview:scrollview];
        
        pc = [[UIPageControl alloc] initWithFrame:CGRectMake(width-150, hight-intro_hight, 120, intro_hight)];
        pc.numberOfPages = vnum;
        pc.currentPage = 1;
        [pc addTarget:self action:@selector(changevideo:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:pc];
        // Initialization code
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
            X += width;
        }
    }
    [scrollview setContentSize:CGSizeMake((vnum * width), [scrollview bounds].size.height)];
}

- (IBAction)changevideo:(id)sender 
{
    UIPageControl *thepc = (UIPageControl *)sender;
    CGRect arect = {width * thepc.currentPage,0,width,hight};
    [scrollview scrollRectToVisible:arect animated:YES];   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollview.contentOffset;
    pc.currentPage = offset.x/width;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSArray*)loaddb{
    NSString * as = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@userinfo.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@ %d",as,[[as componentsSeparatedByString:@","] count]);
    return [as componentsSeparatedByString:@","];
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

@end
