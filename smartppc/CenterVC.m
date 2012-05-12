//
//  CenterVC.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CenterVC.h"
#import "ifaddrs.h"
#import "sys/socket.h"
#import "net/if.h"
#import "userinfovc.h"

@interface CenterVC ()

@end

@implementation CenterVC

@synthesize chartview,orderview,vedioview,orderid,cloudview,websiteview,infoview,number,pass,qqdata,pw,alertmsg,timer,backupObj,backupPicker,speed,package;

@synthesize usernameLabel,totalSaving;
@synthesize limited,oldbyte;

static int timelong = 3;
static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [usernameLabel setHidden:NO];  
}

-(void)viewWillDisappear:(BOOL)animated
{
    [usernameLabel setHidden:YES];
   
} 

- (void)viewDidLoad

{    
    pass = YES;
    if (pass)
    {  
        [self loadtheview];
    }else {
        infoview = [[InfoView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [self.view addSubview:infoview];
        [infoview loginstep1];
    }    
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    /*
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
     */
    return YES;
}



- (IBAction)topage:(id)sender;
{ 
    UIButton * button = (UIButton *)sender;
    WebVC * vc = [[WebVC alloc]init];
    vc.url = [[websiteview.webpages objectAtIndex:(button.tag-1)] objectAtIndex:2];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)tomenu:(id)sender;
{ 
    UIButton * button = (UIButton *)sender;
    SmartPpcVC * vc = [[SmartPpcVC alloc]init];
    vc.state = button.tag;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)play:(id)sender;
{ 
    videoController * vc = [[videoController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIImage *)addText:(UIImage *)img text:(NSString *)text1{
    int w = img.size.width;
    int h = img.size.height; 
    //lon = h - lon;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
	
    char* text	= (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];// "05/05/09";
    CGContextSelectFont(context, "Arial", 22, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
	
    
    
    CGContextShowTextAtPoint(context, 0, 0, text, strlen(text));
	
	
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
	
    return [UIImage imageWithCGImage:imageMasked];
}

- (void)loadtheview
{
    NSString *getUsername = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getusername.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
    
     package = [[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getpackagename.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] ;
    
    UILabel *savingLabel = [[UILabel alloc]initWithFrame:CGRectMake(800, 5 ,100, 30)];
    savingLabel.text = @"Total Saving:";
    savingLabel.backgroundColor = [UIColor clearColor];
    savingLabel.textColor =  [UIColor grayColor];
    
    [self.navigationController.navigationBar addSubview:savingLabel];
    
    usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5 ,300, 30)];
    usernameLabel.text = [NSString stringWithFormat:@"%@ ,Welcome",getUsername];
    usernameLabel.backgroundColor = [UIColor clearColor];
    usernameLabel.textColor =  [UIColor grayColor];
    
    [self.navigationController.navigationBar addSubview:usernameLabel];
    
    totalSaving = [[UILabel alloc] initWithFrame:CGRectMake(905, 7, 100, 30)];
    totalSaving.backgroundColor = [UIColor clearColor];
    [totalSaving setFont:[UIFont systemFontOfSize:15]];
    [self.navigationController.navigationBar addSubview:totalSaving];

    UIBarButtonItem *backbar = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backbar;
    
    [self loadqqdata];
    
    chartview = [[ChartView alloc] initWithFrame:CGRectMake(420,250,580,190)];
    id key1 = @"chargeV"; 
    id key2 = @"topV"; 
    id key3 = @"package"; 
    int i = [[qqdata objectForKey:key3] intValue];
    chartview.total = [[qqdata objectForKey:key2] floatValue];
    chartview.used = [[qqdata objectForKey:key1] floatValue];
 
    chartview.package = [NSString stringWithFormat:@"Package:%@MB/month", package];
    if (i==0) {
        chartview.package = @"No package";
    }    
    [self.view addSubview:chartview];
    
    orderview = [[OrderView alloc] initWithFrame:CGRectMake(30, 20, 356, 424)];
    [self.view addSubview:orderview];
    
    vedioview = [[VediosView alloc] initWithFrame:CGRectMake(420, 20, 580, 200)];
    [self.view addSubview:vedioview];
    
    cloudview = [[CloundView alloc]initWithFrame:CGRectMake(30,460,356,175)];
    [self.view addSubview:cloudview];
    
    websiteview = [[WebsiteView alloc]init];
    websiteview.frame = CGRectMake(420, 460, 580, 175);
    [self.view addSubview:websiteview];
    timer = [NSTimer scheduledTimerWithTimeInterval:timelong target:self selector:@selector(showchartview) userInfo:nil repeats:YES];
    
    UIButton * b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    b1.frame = CGRectMake(900, 640, 50, 50);
    [b1 setImage:[UIImage imageNamed:@"bt_setting.png"] forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(touserinfo) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:b1];
}

- (IBAction)login:(id)sender
{
    id key1 = @"user";
    id key2 = @"pw";
    
    NSDictionary * thedict = [NSDictionary dictionaryWithObjectsAndKeys:number,key1,pw,key2,nil];
    
    NSData *thedata = [NSPropertyListSerialization dataFromPropertyList:thedict format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
    
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@login.xql",websv]]]; 
    
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [req addValue:contentType forHTTPHeaderField: @"Content-Type"];  
    [req setHTTPMethod:@"POST"];   
    [req setHTTPBody:thedata];   
    
    NSURLResponse * response = nil;
    NSData *adata = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
    int result = [[[NSString alloc] initWithData:adata encoding:NSUTF8StringEncoding] intValue];
    
    if (result==1) {
        pass = YES;
        NSFileManager *fm = [[NSFileManager alloc]init];
        NSString * rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];

        [thedata writeToFile:[rootpath stringByAppendingPathComponent:@"user.xml"] atomically:YES];
        [infoview removeFromSuperview];
        [self loadtheview];
    }
}

- (IBAction)setnumber:(id)sender
{
    UITextField * thet = (UITextField *)sender;
    number = thet.text;
}

- (IBAction)setpw:(id)sender
{
    UITextField * thet = (UITextField *)sender;
    pw = thet.text;
}

- (void)loginsim
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    NSData *thedata = [NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]];
    int result = [[[NSString alloc] initWithData:[self httppost:@"login.xql" data:thedata] encoding:NSUTF8StringEncoding] intValue];
if (result==1){
  pass = YES;  
 [infoview removeFromSuperview];
 [self loadtheview];
}
    
}

- (void)loadqqdata
{   
    
    NSString * urlstring = [NSString stringWithFormat:@"%@qqdata.xql?user=%@",websv,[self getusernumber]];
    
    NSURL * aurl = [NSURL URLWithString:urlstring];
    qqdata = [[NSMutableDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:aurl]mutabilityOption:0 format:NULL errorDescription:Nil]];                 
}

- (void)sendorder
{

     UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:self.alertmsg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
     [av1 show];
    
    [av1 release];
}

- (NSData*)httppost:(NSString *)xql data:(NSData*)data
{
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",websv,xql]]]; 
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",websv,xql]);
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [req addValue:contentType forHTTPHeaderField: @"Content-Type"];  
    [req setHTTPMethod:@"POST"];   
    [req setHTTPBody:data];   
    NSURLResponse * response = nil;
    return [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];

}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

- (void)showchartview
{
    [self loadqqdata];
    [self.chartview removeFromSuperview];
    id key1 = @"chargeV";
    id key2 = @"topV";
    chartview = [[ChartView alloc] initWithFrame:CGRectMake(420,250,580,190)];
    self.chartview.used = [[qqdata objectForKey:key1] floatValue];
    self.chartview.total = [[qqdata objectForKey:key2] floatValue];
    
    self.chartview.package = [NSString stringWithFormat:@"Package:%@MB/month", package];

    totalSaving.text = [NSString stringWithFormat:@"%0.0fKb",[[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@subvolume.xql?mode=nopackageV&userid=%@&volume=0",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] floatValue]*1024.0];
    
     speed = ([self truevolume] - oldbyte)/1024/timelong;
    
    oldbyte = [self truevolume];
    
    self.title = [NSString stringWithFormat:@"%dKB/S",speed];
    
    
    //self.title
    
    [self.view addSubview:chartview];  
}

- (void)pushad
{
    SmartPpcVC * vc = [[SmartPpcVC alloc]init];
    vc.state = 1004;
    [self.navigationController pushViewController:vc animated:YES]; 
}

- (void)pushfly
{
   // flightInfo * vc = [[flightInfo alloc] init];
   // [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController pushViewController:((AppDelegate *)APPDELEGATE).fv animated:YES];
}

-(IBAction)backuppop:(id)sender
{
    NSLog(@"good man");
    
    if (backupObj == nil)
    {
        backupObj = [[backupSelect alloc] init];
        backupPicker = [[UIPopoverController alloc] initWithContentViewController:backupObj]; 
        [backupPicker setPopoverContentSize:CGSizeMake(300.0f, 145.0f)];
    }
    [backupPicker presentPopoverFromRect:CGRectMake(355,600 , 1, 1) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (int)truevolume
{
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc; 
    
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    
    NSString *name=[[NSString alloc]init];
    
    success = getifaddrs(&addrs) == 0;
    if (success) 
    {
        cursor = addrs;
        while (cursor != NULL) 
        {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            
            if (cursor->ifa_addr->sa_family == AF_LINK) 
            {
                if ([name hasPrefix:@"en"]) 
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                }
                
                if ([name hasPrefix:@"pdp_ip"]) 
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                } 
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }       
    
    return WiFiSent+WiFiReceived+WWANSent+WWANReceived;
}

- (void) touserinfo
{
    userinfovc * vc = [[userinfovc alloc]init];
    [self.navigationController pushViewController:vc animated:YES]; 
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@useronline.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
}



@end
