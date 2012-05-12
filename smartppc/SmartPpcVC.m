//
//  SmartPpcVC.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SmartPpcVC.h"
#import "SmartppcMenu.h"
#import "QuotaQueryView.h"
#import "X-Day-Pass.h"
#import "TurboButtonView.h"
#import "ParentalControlView.h"
#import "FacebookZeroView.h"
#import "HistoryView.h"
#import "QuoteSharingView.h"

@interface SmartPpcVC ()

@end

@implementation SmartPpcVC

@synthesize menu,state;

static int width = 740;
static int hight = 560;
static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;
  static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    menu = [[SmartppcMenu alloc] initWithFrame:CGRectMake(0, 20, 1024, 645)];
    menu.state = self.state;
    
    [self.view addSubview:menu];
    self.view.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    [self.menu addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:NULL];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)show4
{
    [self setValue:[NSNumber numberWithInt:4] forKey:@"state"];
    [menu.theview removeFromSuperview];
    menu.theview = [[UIView alloc]initWithFrame:CGRectMake(250, 60, 750, 580)];
    menu.theview.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    [menu addSubview:menu.theview];
    [menu.theview addSubview:[[X_Day_Pass alloc]initWithFrame:CGRectMake(0, 0, width,hight)]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (keyPath == @"state") {
        
        UIButton * button = nil;
        for (button in menu.subviews)
        {
            if ([button isKindOfClass:[UIButton class]] && button.tag == menu.oldstate)
            {
                button.enabled = YES;
            }
            if ([button isKindOfClass:[UIButton class]] && button.tag == menu.state)
            {
                button.enabled = NO;
            }
        }
 
        [menu.theview removeFromSuperview];
        menu.theview = [[UIView alloc]initWithFrame:CGRectMake(250, 60, 750, 580)];
        menu.theview.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        [menu addSubview:menu.theview];

    switch (menu.state)
    {
        case 1000:
            [menu.theview addSubview:[[TurboButtonView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1001:
            [menu.theview addSubview:[[ParentalControlView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1002:
            [menu.theview addSubview:[[QuoteSharingView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1003:
            [menu.theview addSubview:[[FacebookZeroView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1004: 
            [menu.theview addSubview:[[X_Day_Pass alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1005:
            [menu.theview addSubview:[[QuotaQueryView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        case 1006:
            [menu.theview addSubview:[[HistoryView alloc]initWithFrame:CGRectMake(0, 0, width, hight)]];
            break;
        default:
            break;
    }
        } 
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@useronline.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

@end
