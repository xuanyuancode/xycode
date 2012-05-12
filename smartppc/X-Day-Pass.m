//
//  X-Day-Pass.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "X-Day-Pass.h"

@implementation X_Day_Pass

@synthesize lable1,lable2,lable3,tableview,list,ordername,password,alertid;

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
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    lable1.text = @"  TIP";
    lable1.font = [UIFont systemFontOfSize:font+5];
    lable1.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width, 82)];
    lable2.font = [UIFont systemFontOfSize:font+3];
    lable2.text = @"   To enjoy the most cost-efficient roaming,activate Day Pass!";
    lable2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, width, 40)];
    lable3.text = @"  X-day Pass";
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
    }
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
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

- (IBAction)buy:(id)sender
{
    UIButton * bt = (UIButton*)sender;
    id key = @"price";
    
    UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    
    if ([bt.titleLabel.text isEqualToString:@"Buy"]) {
        ordername = [[list objectAtIndex:bt.tag] objectForKey:key];
        alertid=100;
        
    }else {
        ordername =@"";
        alertid = 101;
    }
    
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
           [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@setxdporder.xql?userid=%@&name=%@",websv,[self getusernumber],ordername]] encoding:NSUTF8StringEncoding error:nil]; 
            [tableview reloadData]; 
            switch (alertid)
            {
                case 100:
                {
                    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"ok" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [aout show];
                    [aout release];
                }
                    break;
                case 101:
                {
                    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"cencel" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [aout show];
                    [aout release];
                }
                    break;
                default:
                    break;
            }
            
            alertid = 0;
        }
    }}


@end
