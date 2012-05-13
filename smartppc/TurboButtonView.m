//
//  TurboButtonView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TurboButtonView.h"

@implementation TurboButtonView

@synthesize lable1,lable2,lable3,tableview,state,thedata,b1,s1,s2,l1,l2,password;

static int width = 750;
static int font = 14; 

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255; 
static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    thedata = [[NSMutableDictionary alloc] initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=%@",websv,[self getusernumber],@"tb"]]]mutabilityOption:0 format:NULL errorDescription:Nil]];

    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    lable1.text = @"  TIP";
    lable1.font = [UIFont systemFontOfSize:font+5];
    lable1.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width, 82)];
    lable2.font = [UIFont systemFontOfSize:font+3];
    lable2.text = @"   Subscribe Turbo Button,enjoy max. bandwidth up to 3.6Mbps!";
    lable2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, width, 40)];
    lable3.text = @"  Setting";
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
    return  2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"abc";
    id key_type = @"type";
    id key_value = @"value";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier]autorelease];
    }
    
  
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Volume based turbo button"; 
        cell.textLabel.font = [UIFont systemFontOfSize:font + 2];
        
        cell.detailTextLabel.text =@"0.2$/M";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:font + 3];
        cell.imageView.image = [UIImage imageNamed:@"volume.png"];
        
        s2 = [[UISlider alloc]initWithFrame:CGRectMake(400, 20, 300, 30)];
        s2.value  = 0;
        s2.minimumValue = 0;
        s2.maximumValue = 300; 
        
        [s2 addTarget:self action:@selector(s2change) forControlEvents:UIControlEventValueChanged];
        
        l2 = [[UILabel alloc] initWithFrame:CGRectMake(350, 20, 80, 30)];
        l2.text = @"0";

        if ([[thedata objectForKey:key_type] isEqualToString:@"volume"])
        {
            l2.text = [NSString stringWithFormat:@"%d",[[thedata objectForKey:key_value]intValue]];
            s2.minimumValue = [[thedata objectForKey:key_value] floatValue];
            l2.hidden = NO;  
            s2.hidden = NO;
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:l2];
        [cell.contentView addSubview:s2];
        
    }

     if (indexPath.row == 1) {
         b1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
         b1.frame = CGRectMake(450, 15, 100, 40);
         [b1 setTitle:@"Send" forState:UIControlStateNormal];
         [b1 addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchDown];
         [cell.contentView addSubview:b1];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
     }
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (NSString*)getusernumber
    {
        NSFileManager *fm = [[NSFileManager alloc]init];
        NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
        [fm release];
        id key1 = @"user";
        return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
    }


- (void) s1change
{
    l1.text = [NSString stringWithFormat:@"%0.0f",s1.value];
}

- (void) s2change
{
    l2.text = [NSString stringWithFormat:@"%0.0f",s2.value];   
}

- (IBAction) send:(id)sender
{
    UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    [myAlertView1 addSubview:password];
    [myAlertView1 show];
    [myAlertView1 release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    
    
    if (buttonIndex == 1) {
        if ([password.text isEqualToString:@"1234"]) {
            [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@settb.xql?value=%0.0f&type=%@&userid=%@",websv,s2.value,@"volume",[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil];
            UIAlertView * aout = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Your service has been actived !" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [aout show];
            [aout release];
        }
        
        else {
            UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your password is incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [error show];
            [error release];
        }
    }
}



@end
