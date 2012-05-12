//
//  OrderView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OrderView.h"


@implementation OrderView

@synthesize tableview,scrollview,button1,button2,list1,list2,orderlist,qqdata,orderid,alertid,password,selectline;

static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

static float blue_R = 13.0/255;
static float blue_G = 143.0/255;
static float blue_B = 241.0/255;

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

static int font = 13;
static int width = 356;
static int hight = 424;
static int scroll_width = 290;
static int scroll_hight = 100;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        NSURL * aurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@orderitem.xql",websv]];
        orderlist = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:aurl]mutabilityOption:0 format:NULL errorDescription:Nil]];
        NSLog(@"%@",orderlist.description);
        orderid = [[[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getorderid.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
        
        
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, width, 260) style:UITableViewStylePlain];
        tableview.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        tableview.delegate = self;
        tableview.dataSource = self;
        [self addSubview:tableview];
     
            
        button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0, hight-scroll_hight-30, (width-scroll_width)/2,scroll_hight);
        [button1 setTitle:@"<" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:1] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
        [button1 addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button1];
        
        button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(width-(width-scroll_width)/2, hight-scroll_hight-30, (width-scroll_width)/2,scroll_hight);
        [button2 setTitle:@">" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:1] forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateHighlighted];
        [button2 addTarget:self action:@selector(goforward) forControlEvents:UIControlEventTouchDown];
        [self addSubview:button2];
        
        // Initialization code
        status = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    id key1 = @"img";
    id key2 = @"name";
    id key3 = @"intro";
    
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"turbo button.png",key1,@"Turbo button",key2,@"Subscribe Turbo Button,enjoy max. bandwidth up to 3.6Mbps!",key3,nil]; 
    
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"share.png",key1,@"Quota share",key2,@"With quate sharing,you can share the internet with other subscribers!",key3,nil]; 
    
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"parent.png",key1,@"Parental Control",key2,@"Help protect your kids  from inappropriate websites",key3,nil]; 
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"facebook.png",key1,@"Facebook Zero",key2,@"Subscribe \"Facebook Zero\" to access  Facebook with unlimited traffic!",key3,nil]; 
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"x-day-pass.png",key1,@"X-day Pass",key2,@"To enjoy the most cost-efficient roaming,activate Day Pass!",key3,nil]; 
    
     list1 = [[NSArray alloc] initWithObjects:dict1,dict3,dict2,dict4,dict5,nil];
    
    scrollview =[[UIScrollView alloc] initWithFrame:CGRectMake((width-scroll_width)/2, hight-110, scroll_width, scroll_hight)]; 
    
    scrollview.pagingEnabled=YES;  
    int i;
    for (i = 1; i <= [list1 count]; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; 
        [button setBackgroundImage:[UIImage imageNamed:[[list1 objectAtIndex:i-1] objectForKey:key1]] forState:UIControlStateNormal];
        button.frame = CGRectMake(10, 20, 60, 60);
        button.tag = 1000+i -1;
        [button addTarget:nil action:@selector(tomenu:) forControlEvents:UIControlEventTouchDown];
        
        
        UILabel *thelable1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 100, 30)];
        thelable1.text = [[list1 objectAtIndex:i-1] objectForKey:key2];
        thelable1.font = [UIFont systemFontOfSize:font + 3];
        thelable1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        thelable1.numberOfLines = 0;
        
        UILabel *thelable2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 25, 180, 60)];
        thelable2.text =[[list1 objectAtIndex:i-1] objectForKey:key3];
        thelable2.font = [UIFont systemFontOfSize:font];
        thelable2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        thelable2.numberOfLines = 0;
        
        UIView * aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, scroll_width, scroll_hight)];
        aview.tag = i;	
        aview.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        [aview addSubview:button];
        [aview addSubview:thelable1];
        [thelable1 release];
        [aview addSubview:thelable2];
        [thelable2 release];
        [scrollview addSubview:aview];
        [aview release];
        
    }
    [self layoutScrollImages];
    [self addSubview:scrollview];

    CGContextRef cn = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor (cn, blue_R, blue_G, blue_B, 1);   
    CGContextSetRGBStrokeColor(cn, 0.7, 0.7, 0.7, 1);
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(0,0)];
    [path1 addLineToPoint:CGPointMake(width,0)];
    [path1 addLineToPoint:CGPointMake(width,40)];
    [path1 addLineToPoint:CGPointMake(0,40)];
    [path1 closePath];
    [path1 stroke];
    [path1 fill];
    CGContextSetRGBFillColor (cn, 1, 1,1, 1);
    NSString * s1 = @"Data Package Management";
    [s1 drawInRect:CGRectMake(30, 10, width, 30) withFont:[UIFont systemFontOfSize:font+6]]; 
    
}

- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = scrollview.subviews;
    int X=0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(X, 0);
            view.frame = frame;
            X += scroll_width;
        }
    }
    [scrollview setContentSize:CGSizeMake((([list1 count]-1) * width), [scrollview bounds].size.height)];
}

- (void)goback
{
    CGPoint offset = scrollview.contentOffset;
    if (offset.x>0) {
        CGRect arect = {offset.x-scroll_width,0,scroll_width,scroll_hight};
        [scrollview scrollRectToVisible:(CGRect)arect animated:YES];    
    }
}

- (void)goforward
{
    CGPoint offset = scrollview.contentOffset;
    if (offset.x/scroll_width < [list1 count]-1) {
        CGRect arect = {offset.x+scroll_width,0,scroll_width,scroll_hight};
        [scrollview scrollRectToVisible:(CGRect)arect animated:YES];  
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return  7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"abc";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
       
        
        
    }
        
    
        id key1 = @"price";
        id key2 = @"volume";
    
    
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"Package";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                [cell.imageView setImage:nil];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
                break;
            case 1:
            { 
                 [cell.imageView setImage:[UIImage imageNamed:@"arrow_choosed.png"]];
                NSDictionary * adict = [orderlist objectAtIndex:0];
                cell.textLabel.text = [NSString stringWithFormat:@"%@$ package%@ MB/month", [adict objectForKey:key1],[adict objectForKey:key2]];
                cell.textLabel.font = [UIFont systemFontOfSize:font + 3]; 
                if (orderid == 1001) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                } 
            }
                break;
            case 2:
            { NSDictionary * adict = [orderlist objectAtIndex:1];
                 [cell.imageView setImage:[UIImage imageNamed:@"arrow_choosed.png"]];
                cell.textLabel.text = [NSString stringWithFormat:@"%@$ package%@ MB/month", [adict objectForKey:key1],[adict objectForKey:key2]];
                cell.textLabel.font = [UIFont systemFontOfSize:font + 3]; 
                
                if (orderid == 1002) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                } 
            }
                break;
            case 3:
            { NSDictionary * adict = [orderlist objectAtIndex:2];
                 [cell.imageView setImage:[UIImage imageNamed:@"arrow_choosed.png"]];
                cell.textLabel.text = [NSString stringWithFormat:@"%@$ package%@ MB/month", [adict objectForKey:key1],[adict objectForKey:key2]];
                cell.textLabel.font = [UIFont systemFontOfSize:font + 3]; 
                
                if (orderid == 1003) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                } 
            }
                break;
            case 4:
            {[cell.imageView setImage:nil];
                cell.textLabel.text = @"Top Up"; 
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
                break;
            case 5:
            { NSDictionary * adict = [orderlist objectAtIndex:3];
                 [cell.imageView setImage:[UIImage imageNamed:@"arrow_choosed.png"]];
                cell.textLabel.text = [NSString stringWithFormat:@"%@$ package%@ MB/month", [adict objectForKey:key1],[adict objectForKey:key2]];
                cell.textLabel.font = [UIFont systemFontOfSize:font + 3]; 
                
            }
                break;
            case 6:
            { NSDictionary * adict = [orderlist objectAtIndex:4];
                 [cell.imageView setImage:[UIImage imageNamed:@"arrow_choosed.png"]];
                cell.textLabel.text = [NSString stringWithFormat:@"%@$ package%@ MB/month", [adict objectForKey:key1],[adict objectForKey:key2]];
                cell.textLabel.font = [UIFont systemFontOfSize:font + 3]; 
                
            }
                break;
            default:
                break;
        
    }
     
        
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectline = indexPath.row;
    switch (indexPath.row) {
        case 1:
        {
            if (orderid != 1001) {
            UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:[[NSString alloc]initWithFormat:@"You order %@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
            alertid = 100;
            [av1 show];
            [av1 release];
                  }
        }
            break;
            
        case 2:
        {
            if (orderid != 1002) {
            UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:[[NSString alloc]initWithFormat:@"You order %@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
                 alertid = 100;
            [av1 show];
            [av1 release];
            }
        }
            break;
        case 3:
        {
            if (orderid != 1003) {
            UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:[[NSString alloc]initWithFormat:@"You order %@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
            alertid = 100;
            [av1 show];
            [av1 release];
            }
        }
            break;
        case 5:
        {
            if (orderid != 0) {
            UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:[[NSString alloc]initWithFormat:@"You order %@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
            alertid = 100;
            [av1 show];
            [av1 release];
            }else {
                UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"please select package first!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
                [av1 show];
                [av1 release];
            }
        }
            break;
        case 6:
        {
            if (orderid != 0) {
                UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:[[NSString alloc]initWithFormat:@"You order %@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send",nil];
                alertid = 100;
                [av1 show];
                [av1 release];
            }else {
                UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"please select package first!" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
                [av1 show];
                [av1 release];
            }
           
            
        }
            break;
            
        default:
            break;
    }

       
     [tableView reloadData];
   
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;   
}

- (void)loadqqdata
{   
    
    NSString * urlstring = [NSString stringWithFormat:@"%@qqdata.xql?user=%@",websv,[self getusernumber]];
    
    NSURL * aurl = [NSURL URLWithString:urlstring];
    qqdata = [[NSMutableDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:aurl]mutabilityOption:0 format:NULL errorDescription:Nil]];                 
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
        switch (alertid) {
            case 100:
            {
                UIAlertView *myAlertView1 = [[UIAlertView alloc] initWithTitle:@"Please Enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
                [password setBackgroundColor:[UIColor whiteColor]];
                password.secureTextEntry = YES;
                switch (selectline) {
                    case 1:
                    {
                        if (orderid ==0 ) {
                            alertid = 102;
                        }else {
                            alertid = 101;
                        }
                        
                    }
                        break;
                    case 2:
                    {
                        if (orderid ==0 ) {
                            alertid = 102;
                        }else {
                            alertid = 101;
                        }
                    }
                        break;
                    case 3:
                    {
                        if (orderid ==0 ) {
                            alertid = 102;
                        }else {
                            alertid = 101;
                        }
                    }
                        break;
                    case 5:
                    {
                        alertid = 102;
                    }
                        break;
                    case 6:
                    {
                        alertid = 102;
                    }
                        break;
                        
                    default:
                        break;
                }
                [myAlertView1 addSubview:password];
                [myAlertView1 show];
                [myAlertView1 release];
            }
                break;
            case 101: {
                if ([password.text isEqualToString:@"1234"]) {
                    UIAlertView *av1 = [[UIAlertView alloc]initWithTitle:@"infomation" message:@"You order apply in nest month" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil,nil];
                    [av1 show];
                    [av1 release]; 
                }
            }
                break;
            case 102:{
                if ([password.text isEqualToString:@"1234"]){  
                    int i;
                    switch (selectline) {
                        case 1:
                        {
                            i=1001;
                        }
                            break;
                        case 2:
                        {
                            i=1002;
                        }
                            break;
                        case 3:
                        {
                            i=1003;
                        }
                            break;
                        case 5:
                        {
                            i=1004;
                        }
                            break;
                        case 6:
                        {
                            i=1005;
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    
                    int result = [[NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@addorder.xql?orderid=%d&userid=%@",websv,i,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
                    if (result==1) {
                        NSLog(@"ok %d",result);
                        orderid = [[[NSString alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getorderid.xql?userid=%@",websv,[self getusernumber]]] encoding:NSUTF8StringEncoding error:nil] intValue];
                        [self loadqqdata];
                        [self.tableview reloadData];
                    }
                }
            }
                break;
            case 103:
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
                break;
            default:
                break;
        }
    }
}

@end
