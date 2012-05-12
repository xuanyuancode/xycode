//
//  ParentalControlView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ParentalControlView.h"

@implementation ParentalControlView

@synthesize list,tableview,lable1,lable2,lable3,b1,on,state,alertid;
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
         self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        // Initialization code
        on = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pcison.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
        
        if (on == 0) {
            [b1 setTitle:@"buy" forState:UIControlStateNormal];
            tableview.hidden = YES;
        }
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    on = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pcison.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
    

    list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=pc",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]];  
    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    lable1.text = @"  TIP";
    //lable1.textColor = [UIColor colorWithWhite];
    lable1.font = [UIFont systemFontOfSize:font+5];
    lable1.textColor = [UIColor whiteColor];

    lable1.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width, 40)];
    lable2.font = [UIFont systemFontOfSize:font+3];
    lable2.text = @"     Help protect your kids from inappropriate websites.";
    lable2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 178, width, 40)];
    lable3.text = @"  Parental Control";
    lable3.font = [UIFont systemFontOfSize:font+6];
    lable3.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable3.textColor = [UIColor whiteColor];
    [self addSubview:lable1];
    [self addSubview:lable2];
    [self addSubview:lable3];
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(20,80, 700, 80)];
    aview.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    UIImageView * aimgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share.png"]];
    aimgview.frame= CGRectMake(10, 10, 60, 60);
    
    UILabel * alable1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 150, 25)];
    alable1.text = @"  Parental Control";
    alable1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    UILabel * alable2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 150, 25)];
    alable2.text = @"  5 $/Month";
    alable2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    
    b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b1.frame = CGRectMake(500, 40, 110, 35);
    [b1 addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    
    [aview addSubview:alable1];
    [alable1 release];
    [aview addSubview:alable2];
    [alable2 release];
    [aview addSubview:b1];
    [aview addSubview:aimgview];
    [aimgview release];
    [self addSubview:aview];
    [aview release];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 182, width, 340) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview setBounces:NO];
    on = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pcison.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
 
    if (on == 0) {
        [b1 setTitle:@"buy" forState:UIControlStateNormal];
        tableview.hidden = YES;
    }else {
        [b1 setTitle:@"cancel" forState:UIControlStateNormal];
        tableview.hidden = NO;
    }
    
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
    
    int rownum = indexPath.row *10;
    static NSString *CellIdentifier = @"abc";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    NSDictionary * thedict = [list objectAtIndex:indexPath.row];
    
    id game=@"game";
    id shop=@"shop";
    id sn=@"sn";
    id tel=@"tel";
    
    
    UILabel *l4 = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 90, 30)];
    l4.text=@"Number";
    [cell.contentView addSubview:l4];
    [l4 release];
    UITextField *t4 = [[UITextField alloc]initWithFrame:CGRectMake(140, 10, 200, 30)];
    t4.text = [thedict objectForKey:tel];
    t4.borderStyle = UITextBorderStyleRoundedRect;
    t4.tag = indexPath.row +1;
    [t4 addTarget:self action:@selector(change1:) forControlEvents:UIControlEventEditingDidEnd];
    [cell.contentView addSubview:t4];
    [t4 release];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(40, 75, 20, 20);
    button1.tag = 1+rownum;
    if ([[thedict objectForKey:game]intValue] == 1) {
        [button1 setBackgroundImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];   
    }else {
        [button1 setBackgroundImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
    }
    
    [button1 addTarget:self action:@selector(change2:) forControlEvents:UIControlEventTouchDown];
    [cell.contentView addSubview:button1];

    UILabel *l1 = [[UILabel alloc]initWithFrame:CGRectMake(70, 70, 100, 30)];
    l1.text=@"Games";
    [cell.contentView addSubview:l1];
    [l1 release];
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(40+180, 75, 20, 20);
    button2.tag = 2+rownum;
    if ([[thedict objectForKey:shop]intValue] == 1) {
        [button2 setBackgroundImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];   
    }else {
        [button2 setBackgroundImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
    }
    [button2 addTarget:self action:@selector(change2:) forControlEvents:UIControlEventTouchDown];
    [cell.contentView addSubview:button2];
    
    UILabel *l2 = [[UILabel alloc]initWithFrame:CGRectMake(70+180, 70, 100, 30)];
    l2.text=@"Shopping";
    [cell.contentView addSubview:l2];
    [l2 release];
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(40+180*2, 75, 20, 20);
    button3.tag = 3+rownum;
    if ([[thedict objectForKey:sn]intValue] == 1) {
        [button3 setBackgroundImage:[UIImage imageNamed:@"checkbox_on_background.png"] forState:UIControlStateNormal];   
    }else {
        [button3 setBackgroundImage:[UIImage imageNamed:@"checkbox_off_background.png"] forState:UIControlStateNormal];
    }
    [button3 addTarget:self action:@selector(change2:) forControlEvents:UIControlEventTouchDown];
    [cell.contentView addSubview:button3];
    
    UILabel *l3 = [[UILabel alloc]initWithFrame:CGRectMake(70+180*2, 70, 180, 30)];
    l3.text=@"Social networking";
    [cell.contentView addSubview:l3];
    [l3 release];
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button4 setTitle:@"Send" forState:UIControlStateNormal];
    button4.frame = CGRectMake(550, 35, 110, 35);
    button4.tag = indexPath.row + 1;
    [button4 addTarget:self action:@selector(sendorder:) forControlEvents:UIControlEventTouchDown];
    [cell.contentView addSubview:button4];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;   
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
}
*/

- (IBAction)buy:(id)sender
{
    
    
    on = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pcison.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
    
    if (on == 0) {

        [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pconoff.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
        [b1 setTitle:@"cancel" forState:UIControlStateNormal];
        tableview.hidden = NO;
        [tableview reloadData];
        
    }else {
        
        UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        [password setBackgroundColor:[UIColor whiteColor]];
        password.secureTextEntry = YES;
        alertid = 102;
        
        [myAlertView1 addSubview:password];
        [myAlertView1 show];
        [myAlertView1 release];
    
    }
    
    
    
    
    list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=pc",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]]; 
    //[self.tableview reloadData];
     
}

- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    [fm release];
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
}

- (IBAction)change1:(id)sender
{
    UITextField *t = (UITextField *)sender;
    id tel=@"tel";
    NSMutableDictionary * thedict = [[NSMutableDictionary alloc] initWithDictionary:[list objectAtIndex:t.tag - 1]];

    [thedict setObject:t.text forKey:tel];
    [list replaceObjectAtIndex:t.tag - 1 withObject:thedict];
    [thedict release];
    [tableview reloadData];
    /*
    [self httppost:[NSString stringWithFormat:@"%@pcupdata.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:list format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
    [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@addparental.xql?userid=%@&id=%@",websv,[self getusernumber],tf.text]] encoding:NSUTF8StringEncoding error:nil] intValue];
     */
}

- (IBAction)change2:(id)sender
{
    UIButton * bt = (UIButton *)sender;
    int rownum = bt.tag/10;
    NSMutableDictionary * thedict = [[NSMutableDictionary alloc] initWithDictionary:[list objectAtIndex:rownum]];
    
    id game=@"game";
    id shop=@"shop";
    id sn=@"sn";
    
    if (bt.tag == 1+rownum*10) {
        int i = [[thedict objectForKey:game] intValue];
        NSString * s1 = @"0";
        if (i==0) {
            s1=@"1";
        }else {
            s1=@"0";
        }
        [thedict setObject:s1 forKey:game];
    }
    
    if (bt.tag == 2+rownum*10) {
        int i = [[thedict objectForKey:shop] intValue];
        NSString * s1 = @"0";
        if (i==0) {
            s1=@"1";
        }else {
            s1=@"0";
        }
        [thedict setObject:s1 forKey:shop];
    }
    
    if (bt.tag == 3+rownum*10) {
        int i = [[thedict objectForKey:sn] intValue];
        NSString * s1 = @"0";
        if (i==0) {
            s1=@"1";
        }else {
            s1=@"0";
        }
        [thedict setObject:s1 forKey:sn];
    }
    
    [list replaceObjectAtIndex:rownum withObject:thedict];
    [thedict release];
    [tableview reloadData];
    /*
    [self httppost:[NSString stringWithFormat:@"%@pcupdata.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:list format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
     */
}

- (IBAction)sendorder:(id)sender
{ 
    id tel=@"tel";
    NSString * s1 = [[list objectAtIndex:0] objectForKey:tel];
    NSString * s2 = [[list objectAtIndex:1] objectForKey:tel];
    if ([s1 isEqualToString:s2]){
        return;
    }
    
    UIButton * bt = (UIButton *)sender; 
    NSMutableDictionary * thedict = [[NSMutableDictionary alloc] initWithDictionary:[list objectAtIndex:bt.tag-1]];
    NSLog(@"%@",list.description);
    list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getplist.xql?userid=%@&data=pc",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]];  
    [list replaceObjectAtIndex:bt.tag-1 withObject:thedict];
    [thedict release];
    state = bt.tag;
    [self sendinfo];
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

- (void)sendinfo
{
    UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    alertid = 100;
    [myAlertView1 addSubview:password];
    [myAlertView1 show];
    [myAlertView1 release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"tag %d",state);
    
    if (buttonIndex == 0) {
        
    }
    
    
    if (buttonIndex == 1) {
        if ([password.text isEqualToString:@"1234"]) {
           
            switch (alertid)
            {
                case 100:
                {
                    id key = @"tel";
                    [self httppost:[NSString stringWithFormat:@"%@pcupdata.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:list format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
                    [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@addparental.xql?userid=%@&id=%@",websv,[self getusernumber],[[list objectAtIndex:state-1] objectForKey:key]]] encoding:NSUTF8StringEncoding error:nil] intValue];
                    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"ok" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [aout show];
                    [aout release];
                }
                    break;
                case 102:
                {
                    [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@pconoff.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
                    [b1 setTitle:@"buy" forState:UIControlStateNormal];
                    tableview.hidden = YES;
                    UIAlertView * aout = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"canceled" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                    [aout show];
                    [aout release];
                }
                    break;
                default:
                    break;
           }
   
            alertid = 0;
        }
        else {
            UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your password is incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [error show];
            [error release];
        }
        
}
}
@end
