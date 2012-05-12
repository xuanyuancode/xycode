//
//  flightInfo.m
//  smartppc
//
//  Created by iMac02 on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "flightInfo.h"
#import "flightCityList.h"
#import "cityTolist.h"
#import "flightDetails.h"
#import "flightResult.h"
#import "calendarPick.h"
#import "AppDelegate.h"
@interface flightInfo ()

@end

@implementation flightInfo
@synthesize cityButton,toButton,popover;
@synthesize flight;
@synthesize cityto;
@synthesize dateButton;
@synthesize popover2;
@synthesize popover3;
@synthesize picktime;
@synthesize searchButton;
@synthesize flightinfoDetails;
@synthesize order;
@synthesize password;
@synthesize myarray;
@synthesize departtime;
@synthesize departcity;
@synthesize arrive;
@synthesize indexing;
@synthesize indexing2;
@synthesize calendarObj;

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
   
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel *city = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 100, 50)];
    city.text = @"City:";
    city.backgroundColor= [UIColor clearColor];
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 150, 100, 50)];
    dateLabel.text = @"Date:";
    dateLabel.backgroundColor= [UIColor clearColor];
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 100, 100, 50)];
    fromLabel.text = @"From";
    fromLabel.backgroundColor= [UIColor clearColor];
    UILabel *toLabel = [[UILabel alloc]initWithFrame:CGRectMake(450, 100, 100, 50)];
    toLabel.text = @"To";
    toLabel.backgroundColor= [UIColor clearColor];
    
    UIImage *buttonImageNormal = [UIImage imageNamed:@"input.png"];
     UIImage *buttonSearch = [UIImage imageNamed:@"bt_search.png"];
    
    cityButton =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
 
    cityButton.frame = CGRectMake(250, 110,130, 30);
    [cityButton setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
    [cityButton addTarget:self action:@selector(chooseCity:) forControlEvents:UIControlEventTouchUpInside];
    
    toButton = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    toButton.frame = CGRectMake(500, 110, 130, 30);
    [toButton setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
    [toButton addTarget:self action:@selector(tocity:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    dateButton = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    dateButton.frame = CGRectMake(250, 160, 130, 30);
    [dateButton setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
    [dateButton addTarget:self action:@selector(choosedate:) forControlEvents:UIControlEventTouchUpInside];
    
    searchButton = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton.frame = CGRectMake(750, 160, 100, 30);
    [searchButton setBackgroundImage:buttonSearch forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchMethod:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:@"search" forState:UIControlStateNormal];
    
    UIImage *titlebg = [UIImage imageNamed:@"tittle_bg.png"];
    UIImageView *titleimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, titlebg.size.width+90, titlebg.size.height)];
    titleimageview.image = titlebg;
    
    UIImage *bgresult = [UIImage imageNamed:@"bg_detail.png"];
    UIImageView *bgresultview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 90, bgresult.size.width+340, bgresult.size.height)];
    bgresultview.image = bgresult;
    
    [self.view addSubview:bgresultview];[bgresultview release];
    [self.view addSubview:titleimageview];[titleimageview release];
    [self.view addSubview:searchButton];
    [self.view addSubview:dateButton];
    [self.view addSubview:toButton];
    [self.view addSubview:cityButton];
    [self.view addSubview:fromLabel];[fromLabel release]; 
    [self.view addSubview:toLabel];
    [toLabel release];
    [self.view addSubview:city];
    [city release];
    [self.view addSubview:dateLabel];
    [dateLabel release];
}

-(IBAction)searchMethod:(id)sender
{
    

    
    flightinfoDetails = [[flightDetails alloc]init];
    
    if ( [cityButton.currentTitle length] > 0 && [toButton.currentTitle length] > 0  )
    {
        if ([cityButton.currentTitle isEqualToString:[NSString stringWithString:toButton.currentTitle]]) 
        {
            UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Check your From city and To city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];

            [myalert show];
            [myalert release];
            
        }
        else {
            
            myarray  = [[NSArray alloc]initWithObjects:@"sdf",@"fffvvv",@"ffweewf", nil];
            flightinfoDetails.line1 =myarray;
            [self.view addSubview:flightinfoDetails];

        }
      
        
    }
    
    else {
         
        
        UIAlertView *myalert2 = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Select for the city" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [myalert2 show];
        [myalert2 release];
        
    }    
}

-(IBAction)order:(id)sender
{
  UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Credit Card last 4 digit" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    departtime = [((AppDelegate *)APPDELEGATE).fv.flightinfoDetails.line2 objectAtIndex:[sender tag]];

    arrive = [((AppDelegate *)APPDELEGATE).fv.flightinfoDetails.line1 objectAtIndex:[sender tag]];
    [myAlertView addSubview:password];
    [myAlertView show];
    [myAlertView release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    

    if (buttonIndex == 0) {
        if(pushStatus)
        {
          [self.navigationController pushViewController:((AppDelegate *)APPDELEGATE).resultFlight animated:YES];
        }
    }
    else if(buttonIndex == 1 && [password.text isEqualToString:@"1234"]) 
    {
        
       
        UIAlertView *myalertview2 = [[UIAlertView alloc]initWithTitle:@"Congratulations" message:@"You have booked the ticket successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myalertview2 show];
        [myalertview2 release];
        pushStatus = YES;
    }
    
    
}
-(IBAction)choosedate:(id)sender
{

    if (self.calendarObj == nil)
    {
        self.calendarObj = [[calendarPick alloc] init];
        self.popover3 = [[UIPopoverController alloc] initWithContentViewController:calendarObj]; 
        [self.popover3 setPopoverContentSize:CGSizeMake(300.0f, 230.0f)];
    }
    
    [self.popover3 presentPopoverFromRect:CGRectMake(390,170,1,1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}


-(IBAction)tocity:(id)sender
{
  
    if (self.cityto == nil)
    {
        self.cityto = [[cityTolist alloc] init];
        self.popover2 = [[UIPopoverController alloc] initWithContentViewController:cityto]; 
        [self.popover2 setPopoverContentSize:CGSizeMake(250.0f, 220.0f)];
    }
    [self.popover2 presentPopoverFromRect:CGRectMake(330,18 , 300, 200) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

-(IBAction)chooseCity:(id)sender
{
    
    
    if (self.flight == nil)
    {
        self.flight= [[flightCityList alloc] init];
        self.popover = [[UIPopoverController alloc] initWithContentViewController:flight]; 
        [self.popover setPopoverContentSize:CGSizeMake(250.0f, 220.0f)];
    }
    [self.popover presentPopoverFromRect:CGRectMake(80,18 , 300, 200) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self setTitle:@"Flight Reservation"];
    pushStatus = NO;
   
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
