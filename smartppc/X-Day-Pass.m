//
//  X-Day-Pass.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "X-Day-Pass.h"

@implementation X_Day_Pass

@synthesize lable1,lable2,lable3,tableview,list,ordername;
@synthesize password;

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
    ordername =[[NSString alloc]initWithString:[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getxdporder.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil]];
    list = [[NSArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@xdaypassdata.xql",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]];  
        
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        
        infostatus = NO;
        countButton = 0;
        buttonStatus = NO;
        cancelStatus =NO;
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    lable1.text = @"  TIP";
    lable1.textColor = [UIColor whiteColor];
    lable1.font = [UIFont systemFontOfSize:font+5];
    lable1.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width, 82)];
    lable2.font = [UIFont systemFontOfSize:font+3];
    lable2.text = @"   To enjoy the most cost-efficient roaming,activate Day Pass!";
    lable2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, width, 40)];
    lable3.text = @"  X-day Pass";
    lable3.textColor = [UIColor whiteColor];
    lable3.font = [UIFont systemFontOfSize:font+6];
    lable3.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 182, width, 340) style:UITableViewStylePlain];
    [tableview setBounces:NO];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    [self addSubview:lable1];
    [self addSubview:lable2];
    [self addSubview:lable3];
    [self addSubview:tableview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"abc";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    id key1 = @"name";
    id key2 = @"price";
    cell.textLabel.text =[[list objectAtIndex:indexPath.row] objectForKey:key1]; 
    cell.textLabel.font = [UIFont systemFontOfSize:font + 2];

    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d$/package", [[[list objectAtIndex:indexPath.row] objectForKey:key2] intValue]];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:font + 3];
    cell.imageView.image = [UIImage imageNamed:@"icon.png"];
   UIButton *abutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if ([[[list objectAtIndex:indexPath.row] objectForKey:key2] isEqualToString:ordername]) {
        [abutton setTitle:@"Cancel" forState:UIControlStateNormal];
    }else {
        [abutton setTitle:@"Buy" forState:UIControlStateNormal];
        countButton++;
        
    }
    NSLog(@"countButton:%d",countButton);
    abutton.frame = CGRectMake(400, 10, 100, 40);
    [abutton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchDown];
    abutton.tag = indexPath.row;
    [cell.contentView addSubview:abutton];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    [fm release];
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

- (IBAction)buy:(id)sender
{
    UIButton * bt = (UIButton*)sender;
 
    NSLog(@"bt%@",bt.titleLabel.text);
    
    buttonTag = bt.tag;
    
    NSLog(@"buttontag%d",buttonTag);
   id key = @"price";
   
    if ([bt.titleLabel.text isEqualToString:@"Buy"]) {
        
        if (countButton > 2) {
           
            UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
            [password setBackgroundColor:[UIColor whiteColor]];
            password.secureTextEntry = YES;
            [myAlertView1 addSubview:password];
            [myAlertView1 show];
            [myAlertView1 release];
        
        }
        
        else {
            
            UIAlertView *showinfo = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your previesou X-Day Pass will be cancel,do you want to continous" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            
            [showinfo show];
            [showinfo release];
            buttonStatus = YES;
            
        }
        
        

        
       /* 
        UIAlertView *showinfo = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your previesou X-Day Pass will be cancel,do you want to continou" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
       
        [showinfo show];
        [showinfo release];
        */
        
     //  ordername = [[list objectAtIndex:bt.tag] objectForKey:key];
    //    NSLog(@"%@",[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],ordername]);
      //  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],ordername]] encoding:NSUTF8StringEncoding error:nil];
    }
    else {
        
        UIAlertView *cancelAlert = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your current package will be cancle" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        
        [cancelAlert show];
        [cancelAlert release];
        cancelStatus = YES;
        
        //ordername =@"";
        //[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],@""]] encoding:NSUTF8StringEncoding error:nil];
    }
        
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        buttonStatus = NO;
        cancelStatus = NO;
    }
    if (buttonIndex == 1) {
        
       
        if(buttonIndex == 1 && [password.text isEqualToString:@"1234"]) 
        {
            id key = @"price";
            ordername = [[list objectAtIndex:buttonTag] objectForKey:key];
            NSLog(@"%@",[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],ordername]);
            [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],ordername]] encoding:NSUTF8StringEncoding error:nil];

            UIAlertView *mysuccess = [[UIAlertView alloc]initWithTitle:@"Informatioin" message:@"Your previous X-Day Pass has been cancel " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [mysuccess show];
            [mysuccess release];
            
            countButton = 0;
            password.text = @"";
            
               NSLog(@"%@",[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],ordername]);
              [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],ordername]] encoding:NSUTF8StringEncoding error:nil];
            
            password.text = @"";
            buttonStatus = NO;
            cancelStatus = NO;
            [tableview reloadData]; 
            
        }
        
        else if (buttonIndex == 1 && buttonStatus)
        {
         
            UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
            [password setBackgroundColor:[UIColor whiteColor]];
            password.secureTextEntry = YES;
            [myAlertView1 addSubview:password];
            [myAlertView1 show];
            [myAlertView1 release];
               password.text = @"";
            buttonStatus = NO;
            cancelStatus = NO;
            
        }
        else if(buttonIndex == 1 &&  cancelStatus) 
        {
            ordername =@"";
            [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],@""]] encoding:NSUTF8StringEncoding error:nil];
            [tableview reloadData]; 
            password.text = @"";
            cancelStatus = NO;
            buttonStatus = NO;
            
        }
        else if (buttonIndex == 1 && ![password.text isEqualToString:@"1234"]){
            UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Password is not correct" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [warning show];
            [warning release];
            password.text = @"";
             cancelStatus = NO;
             buttonStatus = NO;
        }
        
        
        else {
            UIAlertView *warning = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Password is not correct" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [warning show];
            [warning release];
            password.text = @"";
            cancelStatus = NO;
            buttonStatus = NO;
        }
        
        
        /*
         UIAlertView *av2 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"You have subscribe successfully" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
         
         [av2 show];
         [av2 release];
         */
    }
}

@end
