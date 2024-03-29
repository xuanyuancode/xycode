//
//  videoController.m
//  genie effect
//
//  Created by iMac02 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "videoController.h"
@interface videoController ()

@end
@implementation videoController
@synthesize moviePlayerController,autoTimer,myIndicator,thedict,timer;
@synthesize vc1;
@synthesize customAlertView;
static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";
static int timelong = 1;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializatio
        pushstatus = NO;
    }
    return self;
}

- (NSString*)getusernumber
{
   NSFileManager *fm = [[NSFileManager alloc]init];
   NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    [fm release];
   id key1 = @"user";
   return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}


-(void)play
{
    
   //NSLog(@"final value %@",[thedict objectForKey:@"value"]);
   
   
   if ([[thedict objectForKey:@"value"] intValue] > 0)
   {
      comfirm = NO;
   }
    
   else {
       comfirm = YES;
       
       autoTimer = [NSTimer scheduledTimerWithTimeInterval:(4.0)
                                                    target:self 
                                                  selector:@selector(lagEffect) 
                                                  userInfo:nil 
                                                   repeats:YES];
       
   }

    if (comfirm) {
       
       NSLog(@"comfirm,,,,, status");
      
       NSLog(@"autotimer:%@,",autoTimer);
      
       
        NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"testvideo.m4v"];
        NSURL    *fileURL    =   [NSURL fileURLWithPath:path];
        moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlaybackComplete:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayerController];
        
        
        [moviePlayerController.view setFrame:CGRectMake(0, 
                                                        40, 
                                                        self.view.frame.size.width, 
                                                        self.view.frame.size.height-100)];
        
        [self.view addSubview:moviePlayerController.view];
        [moviePlayerController play];
        [moviePlayerController.view addSubview:myIndicator];
        [myIndicator stopAnimating];
        [[[UIApplication sharedApplication] keyWindow] addSubview:myIndicator]; 
        [self performSelector:@selector(lagEffect) withObject:nil afterDelay:1.0];
    }
    
    else {
        
       NSLog(@"else status");
        NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"testvideo.m4v"];
        NSURL    *fileURL    =   [NSURL fileURLWithPath:path];
        moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlaybackComplete:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:moviePlayerController];
        
        [moviePlayerController.view setFrame:CGRectMake(0, 
                                                        40, 
                                                        self.view.frame.size.width, 
                                                        self.view.frame.size.height-100)];
        
      
        [self.view addSubview:moviePlayerController.view];
        
        [moviePlayerController play];
     
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if(buttonIndex == 0)
    {
        
        alertStatus = YES;
    }
    
    else if (buttonIndex == 1)
    {
        pushstatus = YES;
       [myIndicator stopAnimating];
       SmartPpcVC *smart = [[SmartPpcVC alloc]init];
       smart.state = 1000;
       alertStatus = YES;
       [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playagain) object: nil];
       [self.navigationController pushViewController:smart animated:YES];
        [smart release];
        
         
        
   }
    
}
UIAlertView *customAlertView;
-(void)showalert
{
    if (alertStatus) {
        customAlertView = [[UIAlertView alloc]initWithTitle:@"Information"
                                                            message:@"Subscribe Turbo Button,enjoy max. bandwidth up to 3.6Mbps!"
                                                            delegate:self
                                                            cancelButtonTitle:@"NO"
                                                            otherButtonTitles:@"YES",nil];
        [customAlertView show];
        [customAlertView release];
        alertStatus = NO;
    }

}

-(void)lagEffect
{
    count++;
      [myIndicator startAnimating];
    NSLog(@"count %d",count);
    
    if (count == 4) {
        [self showalert];
        count = 0;
    }
    
  
    [moviePlayerController pause];
    [self performSelector:@selector(playagain) withObject:nil afterDelay:2.0];

    //[self playagain];
}

 

-(void)playagain
{
   [myIndicator stopAnimating];
   [moviePlayerController play];
   //[self play];
}


- (void)moviePlaybackComplete:(NSNotification *)notification
{
    if ([autoTimer isValid]) {
        [autoTimer invalidate];
         autoTimer = nil;
    }
    
    if([timer isValid])
    {
        [timer invalidate];
        timer = nil;
    }
 
    if (!alertStatus) {
        
        if (customAlertView) {
            
            [customAlertView dismissWithClickedButtonIndex:0 animated:NO];
        }  
    }
   
    moviePlayerController = [notification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:moviePlayerController];
    [moviePlayerController.view removeFromSuperview];
    [moviePlayerController release];
    playStatus = NO;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playagain) object: nil];
    
     
    
    
    if (!pushstatus) {
         // [customAlertView removeFromSuperview];
      
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}

-(void)viewWillDisappear:(BOOL)animated
{
    if(playStatus)
    {
        [moviePlayerController stop];
    }
    
    if ([timer isValid]) {
        [timer invalidate];
        timer = nil;
        [timer release];
    }
    
    if ([autoTimer isValid]) {
        [autoTimer invalidate];
        autoTimer = nil;
       [autoTimer release];
    }
   pushstatus = NO;
    [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@setspeed.xql?userid=%@&speed=0",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
    

    //[customAlertView removeFromSuperview];
   //  [customAlertView dissmissWithClickedButtonIndex:-1 animated:YES]; 
    [myIndicator stopAnimating];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playagain) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(lagEffect) object:nil];
    
    
}
-(IBAction)cancel:(id)sender
{
    [autoTimer invalidate];
    autoTimer = nil;
    [self dismissModalViewControllerAnimated:YES];
    [moviePlayerController pause];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    checkagain = NO;
     
    
myIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    myIndicator.center = CGPointMake(250, 450);
    myIndicator.hidesWhenStopped = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    thedict = [[NSMutableDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=tb",websv,[self getusernumber]]]] mutabilityOption:0 format:NULL errorDescription:nil]]; 
    
    timer = [NSTimer scheduledTimerWithTimeInterval:timelong target:self selector:@selector(showspeed) userInfo:nil repeats:YES];
    alertStatus = YES;
   playStatus = YES;
  
    [self play];
}

-(void)showspeed
{
    id key2 = @"value";
    
    NSString * info = @"";
    int  speed;
    float checkvalue;
    
    if ([[thedict objectForKey:key2]intValue] == 0) {
        speed = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getspeed.xql?mode=vedio&userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];   
    }else {
         speed = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getspeed.xql?mode=turbo&userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue]; 
    }
    
   
    float value = [[thedict objectForKey:key2] floatValue];
    value = value - (timelong*speed/1024/8.0);
    if (value < 1) {
        value = 0;
    }
    [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@settb.xql?value=%f&type=%@&userid=%@",websv,value,@"volume",[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
    
    NSString *a=[[NSString alloc]initWithString:[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getxdporder.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil]];
  if ([a intValue] > 0)
  {
    [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@subvolume.xql?mode=nopackageV&userid=%@&volume=%f",websv,[self getusernumber],(timelong*speed/1024.0/8.0)]] encoding:NSUTF8StringEncoding error:nil];
  }else {
      [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@subvolume.xql?mode=chargeV&userid=%@&volume=%f",websv,[self getusernumber],(timelong*speed/1024.0/8.0)]] encoding:NSUTF8StringEncoding error:nil];
  }
    [a release];
    
    
    info = [NSString stringWithFormat:@"%0.0fM free",value];
    
    checkvalue = value;
    
    int r = arc4random() % 120;
    NSLog(@"%d",r);
    
    if (speed -r > 0) {
        self.title = [NSString stringWithFormat:@"%dKb/S  %@",speed-r,info];
    }else {
        self.title = [NSString stringWithFormat:@"%dKb/S  %@",0,info];
    }
    
    
    thedict = [[NSMutableDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=tb",websv,[self getusernumber]]]] mutabilityOption:0 format:NULL errorDescription:nil]]; 
    

    
    NSLog(@"checkvalue%f",checkvalue);
    int checkvalue2;
    checkvalue2 = (int)roundf(checkvalue);
    
    if(checkvalue2 == 0)
    {
        if ([autoTimer isValid]) {
            
            if (!checkagain) {
                [moviePlayerController.view addSubview:myIndicator];
                [myIndicator stopAnimating];
                [[[UIApplication sharedApplication] keyWindow] addSubview:myIndicator]; 
                checkagain = YES;
            }
            
        }
        else {
            NSLog(@"SET UP ");
            [self lagtimer];
        }        
    }
    
    
    } 

-(void)lagtimer
{
    [myIndicator startAnimating];
    autoTimer = [NSTimer scheduledTimerWithTimeInterval:(4.0)
                                                 target:self 
                                               selector:@selector(lagEffect) 
                                               userInfo:nil 
                                                repeats:YES];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
   
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
      return YES;
   
   return NO;
}

- (void) viewDidAppear:(BOOL)animated
{
    [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@useronline.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
}


- (void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
