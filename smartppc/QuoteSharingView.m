//
//  QuoteSharingView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteSharingView.h"

@implementation QuoteSharingView
@synthesize lable1,lable2,lable3, b1,list,tableview,t1,t2,t3,t11,t12,t13,lines,alertid,password;

static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";
static int width = 750;
static int font = 14; 

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255; 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        lines = 1;
           
        list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qsdata.xql?userid=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]];  
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    lable1.text = @"  TIP";
    lable1.font = [UIFont systemFontOfSize:font+5];
    lable1.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width, 40)];
    lable2.font = [UIFont systemFontOfSize:font+3];
    lable2.text = @"     With quate sharing,you can share the internet with other subscribers!";
    lable2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 178, width, 40)];
    lable3.text = @"  Quota Sharing";
    lable3.font = [UIFont systemFontOfSize:font+6];
    lable3.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    [self addSubview:lable1];
    [self addSubview:lable2];
    [self addSubview:lable3];
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(20,80, 700, 80)];
    aview.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    UIImageView * aimgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share.png"]];
    aimgview.frame= CGRectMake(10, 10, 60, 60);
    
    UILabel * alable1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 150, 25)];
    alable1.text = @"  Quota Sharing";
    alable1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    UILabel * alable2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 150, 25)];
    alable2.text = @"  5 $/Month";
    alable2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b1.frame = CGRectMake(500, 40, 110, 35);
    [b1 addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchDown];
     
    [aview addSubview:alable1];
    [aview addSubview:alable2];
    [aview addSubview:b1];
    [aview addSubview:aimgview];
    
    [self addSubview:aview];
    
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 220, width, 340) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self addSubview:tableview];
    
    id key1 = @"tel";
    
    if ([[[list objectAtIndex:0]objectForKey:key1] isEqualToString:@""] && ([list count] < 2)) {
        [b1 setTitle:@"buy" forState:UIControlStateNormal];
        tableview.hidden = YES;
    }else {
        [b1 setTitle:@"cancel" forState:UIControlStateNormal];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"abc";
    id key1 = @"tel";
    id key2 = @"name";
    id key3 = @"limit";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell =nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        
        
        
        
        if (indexPath.row == 0) {
            UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 30)];
            number.textColor = [UIColor blackColor];
            number.backgroundColor = [UIColor clearColor];
            number.text = @"Number:";
            
            UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(270, 20, 100, 30)];
            name.textColor = [UIColor blackColor];
            name.backgroundColor = [UIColor clearColor];
            name.text = @"Name:";
            
            UILabel *quoteLabel = [[UILabel alloc]initWithFrame:CGRectMake(470, 20, 100, 30)];
            quoteLabel.textColor = [UIColor blackColor];
            quoteLabel.backgroundColor = [UIColor clearColor];
            quoteLabel.text = @"Quote:";
            [cell.contentView addSubview:name];
            [cell.contentView addSubview:number];
            [cell.contentView addSubview:quoteLabel];
            
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            addButton.frame = CGRectMake(700, 30, 200, 30.0);
            [addButton setTitle:@"Base Station Monitor" forState:UIControlStateNormal];
            addButton.backgroundColor = [UIColor clearColor];
            
            [addButton addTarget:self action:@selector(addrow:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:addButton];
            
            
            t1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 25, 120, 30)];
            t1.borderStyle = UITextBorderStyleRoundedRect;
            
            if ([list count]>0) {
                t1.text = [[list objectAtIndex:indexPath.row] objectForKey:key1]; 
            }else {
                t1.text =@"";
            }
            
            
            
            t2 = [[UITextField alloc]initWithFrame:CGRectMake(330, 25, 120, 30)];
            
            t2.borderStyle = UITextBorderStyleRoundedRect;
            if ([list count]>0) {
                t2.text = [[list objectAtIndex:indexPath.row] objectForKey:key2]; 
            }else {
                t2.text =@"";
            }
            
            t3 = [[UITextField alloc]initWithFrame:CGRectMake(550, 25, 120, 30)];
            if ([list count]>0) {
                t3.text = [[list objectAtIndex:indexPath.row] objectForKey:key3]; 
            }else {
                t3.text =@"";
            }
            
            
            t3.borderStyle = UITextBorderStyleRoundedRect;
            t3.text = [[list objectAtIndex:indexPath.row] objectForKey:key3];
            [cell.contentView addSubview:t1];
            [cell.contentView addSubview:t2];
            [cell.contentView addSubview:t3];
            
        }
        
        if (indexPath.row == 1) {
            
            if (lines==2) {
                UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 30)];
                number.textColor = [UIColor blackColor];
                number.backgroundColor = [UIColor clearColor];
                number.text = @"Number:";
                
                UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(270, 20, 100, 30)];
                name.textColor = [UIColor blackColor];
                name.backgroundColor = [UIColor clearColor];
                name.text = @"Name:";
                
                UILabel *quoteLabel = [[UILabel alloc]initWithFrame:CGRectMake(470, 20, 100, 30)];
                quoteLabel.textColor = [UIColor blackColor];
                quoteLabel.backgroundColor = [UIColor clearColor];
                quoteLabel.text = @"Quote:";
                [cell.contentView addSubview:name];
                [cell.contentView addSubview:number];
                [cell.contentView addSubview:quoteLabel];
                
                UIButton *minusButton = [[UIButton buttonWithType:UIButtonTypeContactAdd] retain];
                UIImage *minusImg = [UIImage imageNamed:@"minus.png"];
                minusButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
                minusButton.frame = CGRectMake(700, 30, minusImg.size.width, minusImg.size.height);
                minusButton.backgroundColor = [UIColor clearColor];
                [minusButton setBackgroundImage:minusImg forState:UIControlStateNormal];
                [minusButton addTarget:self action:@selector(subrow:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:minusButton];
                
                
                
                t11 = [[UITextField alloc]initWithFrame:CGRectMake(100, 25, 120, 30)];
                t11.borderStyle = UITextBorderStyleRoundedRect;
                if ([list count]>1) {
                    t11.text = [[list objectAtIndex:indexPath.row] objectForKey:key1]; 
                }else {
                    t11.text =@"";
                }
                
                
                t12 = [[UITextField alloc]initWithFrame:CGRectMake(330, 25, 120, 30)];
                t12.borderStyle = UITextBorderStyleRoundedRect;
                if ([list count]>1) {
                    t12.text = [[list objectAtIndex:indexPath.row] objectForKey:key2]; 
                }else {
                    t12.text =@"";
                }
                
                
                t13 = [[UITextField alloc]initWithFrame:CGRectMake(550, 25, 120, 30)];
                t13.borderStyle = UITextBorderStyleRoundedRect;
                if ([list count]>1) {
                    t13.text = [[list objectAtIndex:indexPath.row] objectForKey:key3]; 
                }else {
                    t13.text =@"";
                }
                
                [cell.contentView addSubview:t11];
                [cell.contentView addSubview:t12];
                [cell.contentView addSubview:t13];
            }else{cell.hidden =YES;}
        }
        
        if (indexPath.row == 2) {
            
            UIButton *submitButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
            submitButton.frame = CGRectMake(600, 30, 100, 30.0);
            [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
            submitButton.backgroundColor = [UIColor clearColor];
            
            [submitButton addTarget:self action:@selector(sendorder) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:submitButton];
            
        }
 
        
        
        
        
        
        
    
    }
    
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;   
}

- (IBAction)buy:(id)sender
{
    UIButton * abutton = (UIButton*) sender;
    if (abutton.titleLabel.text == @"cancel") {
        UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        [password setBackgroundColor:[UIColor whiteColor]];
        password.secureTextEntry = YES;
        alertid = 100;
        
        [myAlertView1 addSubview:password];
        [myAlertView1 show];
        [myAlertView1 release];
    }else {
        
        UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

        password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        [password setBackgroundColor:[UIColor whiteColor]];
        password.secureTextEntry = YES;
        alertid = 101;
        
        [myAlertView1 addSubview:password];
        [myAlertView1 show];
        [myAlertView1 release];
        
    }
}


-(IBAction)subrow:(id)sender
{
    lines = 1;
    [self sendorder];
    [tableview reloadData];
}

-(IBAction)addrow:(id)sender
{
    lines =2;
    [tableview reloadData];
}

- (void)sendorder
{ 
    UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    alertid = 102;
    
    [myAlertView1 addSubview:password];
    [myAlertView1 show];
    [myAlertView1 release];
    
}

- (NSData*)httppost:(NSString *)xql data:(NSData*)data
{
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:xql]]; 
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
    }
    
    
    if (buttonIndex == 1) {
        if ([password.text isEqualToString:@"1234"]) {
            
            switch (alertid)
            {
                case 100:
                {
                    [b1 setTitle:@"buy" forState:UIControlStateNormal];
                    id key1 = @"tel";
                    id key2 = @"name";
                    id key3 = @"limit";
                    NSDictionary *dict1= [[NSDictionary alloc]initWithObjectsAndKeys:@"",key1,@"",key2,@"",key3,nil];
                    NSArray * alist = [[NSArray alloc]initWithObjects:dict1, nil];

                    [self httppost:[NSString stringWithFormat:@"%@updataqs.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:alist format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
                    
                    list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qsdata.xql?userid=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]]; 
                    
                    lines=0;
                    
                    [tableview reloadData];
                    tableview.hidden = YES;
                    
                    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"ok" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];

                    [aout show];
                    [aout release];
                }
                    break;
                case 101:
                {
                    [b1 setTitle:@"cancel" forState:UIControlStateNormal];
                    tableview.hidden = NO; 
                    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"ok" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [aout show];
                    [aout release];
                }
                    break;
                case 102:
                {
                    id key1 = @"tel";
                    id key2 = @"name";
                    id key3 = @"limit";
                    NSArray * alist;
                    if (lines==2) {
                        NSDictionary *dict1= [[NSDictionary alloc]initWithObjectsAndKeys:t1.text,key1,t2.text,key2,t3.text,key3,nil];
                        NSDictionary *dict2= [[NSDictionary alloc]initWithObjectsAndKeys:t11.text,key1,t12.text,key2,t13.text,key3,nil];
                        alist = [[NSArray alloc]initWithObjects:dict1,dict2, nil];
                    }
                    
                    if (lines==1) {
                        NSDictionary *dict1= [[NSDictionary alloc]initWithObjectsAndKeys:t1.text,key1,t2.text,key2,t3.text,key3,nil];
                        alist = [[NSArray alloc]initWithObjects:dict1, nil];
                    }
                    
                    if (lines==0) {
                        NSDictionary *dict1= [[NSDictionary alloc]initWithObjectsAndKeys:@"",key1,@"",key2,@"",key3,nil];
                        alist = [[NSArray alloc]initWithObjects:dict1, nil];
                    }
                    
                    [self httppost:[NSString stringWithFormat:@"%@updataqs.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:alist format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
                    list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qsdata.xql?userid=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]]; 
                    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"ok" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [aout show];
                    [aout release];
                }
                    break;
                    
                default:
                    break;
            }
            
            alertid = 0;
        }
    }
}



@end
