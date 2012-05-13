//
//  WebVC.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WebVC.h"
#import "SmartPpcVC.h"
#import "ifaddrs.h"
#import "sys/socket.h"
#import "net/if.h"

@interface WebVC ()

@end

@implementation WebVC
@synthesize webview,url,timer,speed,free,thefind,limited,oldbyte;//,timer2


static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";
static int timelong = 3;

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
    oldbyte = [self truevolume];
    limited = NO;
    alertStatus = NO;
    thefind = [[NSMutableArray alloc]init];
    webview = [[UIWebView  alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    webview.delegate = self; 

    
    [self.view addSubview:webview];
   // webview.tag=1010;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

- (void)showspeed
{
    
    free = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@webisfree.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
    
    
    speed = ([self truevolume] - oldbyte)/1024/timelong;
    
    
    float volume = ([self truevolume] - oldbyte)/1024.0/1024/8.0;
    
    oldbyte = [self truevolume];
    
    if ([[[NSString alloc]initWithString:[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getxdporder.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil]]intValue] > 0) {
        [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@subvolume.xql?mode=nopackageV&userid=%@&volume=%f",websv,[self getusernumber],volume]] encoding:NSUTF8StringEncoding error:nil];
        self.title = [NSString stringWithFormat:@"%dKb/S",speed];
    }else {
        
        if ([url isEqualToString:[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getgarde.xql",websv]] encoding:NSUTF8StringEncoding error:nil]])
        {
            [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@subvolume.xql?mode=nopackageV&userid=%@&volume=%f",websv,[self getusernumber],volume]] encoding:NSUTF8StringEncoding error:nil];
            self.title = [NSString stringWithFormat:@"%dKb/S garde",speed];
        }
        
        if (free == 1 && [url isEqualToString:@"http://weibo.com"]) {
            [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@subvolume.xql?mode=nopackageV&userid=%@&volume=%f",websv,[self getusernumber],volume]] encoding:NSUTF8StringEncoding error:nil];
            self.title = [NSString stringWithFormat:@"%dKb/S",speed];
            
        } else {
           [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@subvolume.xql?mode=chargeV&userid=%@&volume=%f",websv,[self getusernumber],volume]] encoding:NSUTF8StringEncoding error:nil];
            self.title = [NSString stringWithFormat:@"%dKb/S",speed];
        } 
        
    }

}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    [fm release];
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

- (void)viewWillDisappear:(BOOL)animated
{
       /* while ([timer isValid]) {
           // NSLog(@"isValid");
          //  NSLog(@"2timer %d",[timer retainCount]);
            [timer invalidate];
           // NSLog(@"3timer %d",[timer retainCount]);
            timer=nil;
            break;
        }*/    
     [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showmsg) object: nil];
 
    /*if (!alertStatus) {
        if (av1) {
            [av1 dismissWithClickedButtonIndex:0 animated:YES];
        }
    }*/
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!timer) {
        
        NSLog(@"dsds");
        timer = [NSTimer scheduledTimerWithTimeInterval:timelong target:self selector:@selector(showspeed) userInfo:nil repeats:YES];//retain];
        NSLog(@"1timer %d",[timer retainCount]);
        
    }//timer2 = [NSTimer scheduledTimerWithTimeInterval:timelong2 target:self selector:@selector(showmsg) userInfo:nil repeats:YES];
    if (!alertStatus) {
           [self performSelector:@selector(showmsg) withObject:nil afterDelay:5];
        alertStatus = YES;
    }
 
}
UIAlertView *av1;
- (void)showmsg
{
    
    
    if ([url isEqualToString:@"http://www.mtv.com"]) {
        av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:[NSString stringWithFormat:@"Access to %@ enjoy music and free traffic",[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getgarde.xql",websv]] encoding:NSUTF8StringEncoding error:nil]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"GO" ,nil];
        limited =NO;
        [av1 show];
        [av1 release];
    }

    
    NSString *parental = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getparental.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",parental);
    
    if (![parental isEqualToString:@""]) {
    NSDictionary *limit =  [[NSDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getlimit.xql?userid=%@&parental=%@",websv,[self getusernumber],parental]]]mutabilityOption:0 format:NULL errorDescription:Nil]];
        NSLog(@"%@",limit.description);
        
        id key1 = @"game";
        id key2 = @"shop";
        id key3 = @"sn";
        
        if ([[limit objectForKey:key1] intValue]==1 && [url isEqualToString:@"http://us.battle.net"]) {
            av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"The Site is limited" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
            limited = YES;
            [av1 show];
            [av1 release];
        }else {
            if ([url isEqualToString:@"http://us.battle.net"])  {
                if ([[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pcison.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue] == 0) 
                {
                    
                    av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"Subscribe Parental Control service to make a clean internet for your kids!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"GO",nil];
                    [av1 show];
                    [av1 release];
                } 
            }

        }
        
        if ([[limit objectForKey:key2] intValue]==1 && [url isEqualToString:@"http://www.ebay.com"]) {
            av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"The Site is limited" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
            limited =YES;
            [av1 show];
            [av1 release];
        }
        
        if ([[limit objectForKey:key3] intValue]==1 && [url isEqualToString:@"http://weibo.com"]) {
            av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"The Site is limited" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
            limited =YES;
            [av1 show];
            [av1 release];
        }else {
            if ([url isEqualToString:@"http://weibo.com"])  {
                if ([[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@webisfree.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue] == 0) 
                {
                    av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"Subscribe Facebook Zero service for free traffic of FaceBook." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"GO",nil];
                    [av1 show];
                    [av1 release];  
                } 
            }

        }
    }else {
        if ([url isEqualToString:@"http://weibo.com"])  {
            if ([[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@webisfree.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue] == 0) 
            {
                av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"Subscribe Facebook Zero service for free traffic of FaceBook." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"GO",nil];
                [av1 show];
                [av1 release];  
            } 
        }
        
        
        if ([url isEqualToString:@"http://us.battle.net"])  {
            if ([[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pcison.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue] == 0) 
            {
                
                av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"Subscribe Parental Control service to make a clean internet for your kids!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"GO",nil];
                [av1 show];
                [av1 release];
            } 
        }


    }
       
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (limited) {
             [self.navigationController popViewControllerAnimated:YES];
        }
       
    }

    
    if (buttonIndex == 1) {
        if ([url isEqualToString:@"http://www.mtv.com"]) 
        {
           NSString *as= [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getgarde.xql",websv]] encoding:NSUTF8StringEncoding error:nil]; 
            url = as;
            [webview removeFromSuperview];
            webview = [[UIWebView  alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
            [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
            webview.delegate = self; 
            [self.view addSubview:webview];
        }else {
            SmartPpcVC * vc = [[SmartPpcVC alloc]init];
            if ([url isEqualToString:@"http://us.battle.net"]) 
                vc.state = 1001;
            if ([url isEqualToString:@"http://weibo.com"])
                vc.state = 1003;      
            [self.navigationController pushViewController:vc animated:YES];
        }
 
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

if ([url isEqualToString:@"http://www.ebay.com"]) 
{    
  NSString * find = [webView stringByEvaluatingJavaScriptFromString:@"var i=document.getElementsByTagName(\"div\").length; var xy; var a; for(a=0;a<i;a++){if(document.getElementsByTagName(\"div\")[a].className == 'bbc-in bbc bbc-nav') xy=a;} var i2 = document.getElementsByTagName(\"div\")[xy].getElementsByTagName(\"li\").length;var aaa=\"\"; for(a=0;a<i2;a++) {aaa = aaa  + document.getElementsByTagName(\"div\")[xy].getElementsByTagName(\"li\")[a].getElementsByTagName(\"a\")[0].innerHTML + \",\"} aaa; "];
    
    id key1 = @"class";
    id key2 = @"url";
    id key3 = @"time";
    
    if ([find length] > 0 && [thefind count]==0) {

        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[find componentsSeparatedByString:@","] objectAtIndex:0],key1,[webView.request.mainDocumentURL description],key2,nil]; 
        [thefind addObject:dict];
        NSLog(@"%@",dict.description);
        NSLog(@"%@", [[[find componentsSeparatedByString:@","] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"&amp;" withString:@""]);
        }
    
    if ([find length] > 0 && [thefind count]==1) {
        if (![[webView.request.mainDocumentURL description] isEqualToString:[[thefind objectAtIndex:0] objectForKey:key2]] && [[[find componentsSeparatedByString:@","] objectAtIndex:0] isEqual:[[thefind objectAtIndex:0] objectForKey:key1]]) 
            {
                
               [thefind addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:[[[NSDate alloc]init] timeIntervalSince1970]],key3,[webView.request.mainDocumentURL description],key2,nil]]; 
            }
        }
    
    if ([thefind count]==2) {
        NSLog(@"%f %@",([[[NSDate alloc]init] timeIntervalSince1970] - [[[thefind objectAtIndex:1]objectForKey:key3] floatValue]),thefind.description);
       
        
        if ( [[[NSDate alloc]init] timeIntervalSince1970] - [[[thefind objectAtIndex:1]objectForKey:key3] floatValue] >8) {
            [self addlike:[[thefind objectAtIndex:0] objectForKey:key1]];
            [thefind removeObjectAtIndex:1]; 
            [thefind removeObjectAtIndex:0]; 
        }else {
            [thefind removeObjectAtIndex:1]; 
            [thefind removeObjectAtIndex:0]; 
        }
        }   
    }
     
}

- (void) addlike:(NSString*)like
{
    NSString * as =  [NSString stringWithFormat:@"%@addlike.xql?userid=%@&like=%@",websv,[self getusernumber],[like stringByReplacingOccurrencesOfString:@"&amp;" withString:@""]];
    
    [NSString stringWithContentsOfURL:[NSURL URLWithString:as] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"add like:%@",as);
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

- (void) viewDidAppear:(BOOL)animated
{
   [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@useronline.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil]; 
}


@end
