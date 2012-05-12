//
//  userinfovc.m
//  smartppc
//
//  Created by 勇 潘 on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "userinfovc.h"

@interface userinfovc ()

@end

@implementation userinfovc
@synthesize list,names,clearbt,password,alertid;

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
    [self pass];
    
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

- (void)showline: (int)i
{
    UILabel * l1 = [[UILabel alloc]initWithFrame:CGRectMake(40, 40 + i*50, 120, 30)];
    l1.text = [names objectAtIndex:i];
    UITextField * t1 = [[UITextField alloc]initWithFrame:CGRectMake(180, 40+i*50, 200, 30)];
    t1.borderStyle = UITextBorderStyleRoundedRect;
    t1.text = [list objectAtIndex:i]; 
    t1.tag = i+100;
    [t1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view  addSubview: l1];
    [self.view  addSubview: t1];
    [t1 release];
    [l1 release];
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    [fm release];
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

- (void) sendinfo
{
    NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:[list objectAtIndex:0],[names objectAtIndex:0],[list objectAtIndex:1],[names objectAtIndex:1],[list objectAtIndex:2],[names objectAtIndex:2],[list objectAtIndex:3],[names objectAtIndex:3],[list objectAtIndex:4],[names objectAtIndex:4],[list objectAtIndex:5],[names objectAtIndex:5],[list objectAtIndex:6],[names objectAtIndex:6],nil];
    
    NSData *ad = [self httppost:[NSString stringWithFormat:@"%@setpersoninfo.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:info format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
    
    NSString * as = [[NSString alloc]initWithData:ad encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@ %@",info.description,as);
    [as release];
}

- (IBAction)change:(id)sender
{
    UITextField * t1 = (UITextField *) sender;
    [list replaceObjectAtIndex:t1.tag -100 withObject:t1.text]; 
}

- (NSData*)httppost:(NSString *)xql data:(NSData*)data
{
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:xql]]; 
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",websv,xql]);
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [req addValue:contentType forHTTPHeaderField: @"Content-Type"];  
    [req setHTTPMethod:@"POST"];   
    [req setHTTPBody:data];   
    NSURLResponse * response = nil;
    return [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];    
}

- (void)clearorder
{
    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"did clear" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
    alertid = 102;
    [aout show];
    [aout release];
}

- (void)pass
{
    UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    alertid = 101;
    
    [myAlertView1 addSubview:password];
    [myAlertView1 show];
    [myAlertView1 release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        if (alertid == 101) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
    
    if (buttonIndex == 1) {
   
            switch (alertid)
            {
                case 101:
                {
                     if ([password.text isEqualToString:@"1234"])
                     {
                         [self showall];
                     }
                }
                    break;
                case 102:
                {
                  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@clear.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] ;  
                }
                    break;
                default:
                    break;
            }
            
            alertid = 0;
        }
}

- (void)showall
{
    NSString * as = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getpersoninfo.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
    list = [[NSMutableArray alloc]initWithArray:[as componentsSeparatedByString:@","]];
    names = [[NSArray alloc]initWithObjects:@"name",@"access",@"location",@"devtype",@"devsz",@"age",@"gender",nil];
    
    for (int i=0; i<[list count]; i++) {
        [self showline:i];
    }
    
    UIButton * b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b1.frame = CGRectMake(200, 450, 100, 30);
    [b1 setTitle:@"ok" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(sendinfo) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:b1];
    
    clearbt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearbt.frame = CGRectMake(400, 50, 180, 40);
    [clearbt setTitle:@"clear order" forState:UIControlStateNormal];
    [clearbt addTarget:self action:@selector(clearorder) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:clearbt];

}

@end
