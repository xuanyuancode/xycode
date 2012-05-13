//
//  QuoteSharingView.m
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuoteSharingView.h"


@implementation QuoteSharingView
@synthesize lable1,lable2,lable3, b1,list,tableview;
@synthesize name1,name2,number1,number2,quote,quote2;
@synthesize myarray;
@synthesize name22,quoteLabel22,number22;
@synthesize addtofile;
@synthesize addFavour;
@synthesize password;
@synthesize minusButton;
@synthesize nameArray;
@synthesize telArray;
@synthesize limitArray;

@synthesize getNumber2,getName2,getQuote2;
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
        
        myarray = [[NSMutableArray alloc]init];
        countAdd = 0;
        saveStatus = NO;
        tipstatus = NO;
        filestatus  =NO;
        noralstatus = NO;
        tipstatus2 = NO;
        passwordStatus = NO;
        
        countstatus = NO;
        NSData *adata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qsdata.xql?userid=%@",websv,[self getusernumber]]]];
        NSArray *list1 = [NSPropertyListSerialization propertyListFromData:adata mutabilityOption:0 format:NULL errorDescription:nil];
        
        NSLog(@"listttt:%@",list1);
        
        nameArray = [[NSMutableArray alloc]init];
        limitArray = [[NSMutableArray alloc]init];
        telArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<[list1 count]; i++) 
        {
            
            NSDictionary *dict = [list1 objectAtIndex:i];
            NSString *name = [dict objectForKey:@"name"];
            NSString *limit = [dict objectForKey:@"limit"];
            NSString *tel = [dict objectForKey:@"tel"];

          [nameArray addObject:name];
          [limitArray addObject:limit];
          [telArray addObject:tel];

        }
      
    }
    return self;
}


- (NSString*)getusernumber
{
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
    
    id key1 = @"user";
    return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
    
}



- (void)drawRect:(CGRect)rect
{
    
    lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 40)];
    lable1.text = @"  TIP";
    lable1.font = [UIFont systemFontOfSize:font+5];
    lable1.textColor = [UIColor whiteColor];
    lable1.backgroundColor = [UIColor colorWithRed:blue_R green:blue_G blue:blue_B alpha:0.7];
    lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, width, 40)];
    lable2.font = [UIFont systemFontOfSize:font+3];
    lable2.text = @"     With quate sharing,you can share the internet with other subscribers!";
    lable2.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
    lable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 178, width, 40)];
    lable3.text = @"  Quota Sharing";
    lable3.textColor = [UIColor whiteColor];
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
    
    
    id key1 = @"name";
    id key2 = @"tel";
    id key3 = @"volume";
    id key4 = @"on";
    
    //NSDictionary * member1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Dad",key1,@"123456781",key2,[NSNumber numberWithFloat:30] ,key3,[NSNumber numberWithInt:1],key4,nil];
    
    NSDictionary * member2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Mam",key1,@"123456782",key2,[NSNumber numberWithFloat:20],key3,[NSNumber numberWithInt:0],key4,nil];
    
    NSDictionary * member3 = [NSDictionary dictionaryWithObjectsAndKeys:@"Andie",key1,@"123456783",key2,[NSNumber numberWithFloat:20],key3,[NSNumber numberWithInt:1],key4, nil];
    
    list = [[NSMutableArray alloc] initWithObjects:member2,member3,nil];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 220, width, 350) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self addSubview:tableview];
    
    if (list == nil) {
        [b1 setTitle:@"Buy" forState:UIControlStateNormal];
        tableview.hidden = YES;
    }else {
        [b1 setTitle:@"Cancel" forState:UIControlStateNormal];
    }
    
    NSString *checking = [NSString stringWithFormat:@"%@",[nameArray objectAtIndex:0]];
    
    
    if (checking.length <1) {
        tableview.hidden = YES;
        [b1 setTitle:@"Buy" forState:UIControlStateNormal];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
   //     NSDictionary * thedict = [list objectAtIndex:indexPath.row];
        
      //  CustomCellView2 * theview = [[CustomCellView2 alloc] initWithFrame:CGRectMake(0,0, width, 80)];
      //  theview.dict = [[NSMutableDictionary alloc] initWithDictionary:thedict];
        
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
        
        
    
        
        
        if (indexPath.row == 0) {
            
            
            
            
            UIButton *addButton = [[UIButton buttonWithType:UIButtonTypeContactAdd] retain];
            addButton.frame = CGRectMake(700, 30, 200, 30.0);
            [addButton setTitle:@"Base Station Monitor" forState:UIControlStateNormal];
            addButton.backgroundColor = [UIColor clearColor];
        
            [addButton addTarget:self action:@selector(addMethod:) forControlEvents:UIControlEventTouchUpInside];
             [cell.contentView addSubview:addButton];
            
            
            number1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 25, 120, 30)];
     
            number1.borderStyle = UITextBorderStyleRoundedRect;
            
            
            name1 = [[UITextField alloc]initWithFrame:CGRectMake(330, 25, 120, 30)];
      
            name1.borderStyle = UITextBorderStyleRoundedRect;
            
            quote = [[UITextField alloc]initWithFrame:CGRectMake(550, 25, 120, 30)];
           
            quote.borderStyle = UITextBorderStyleRoundedRect;
            
            name1.text = [nameArray objectAtIndex:indexPath.row];
            number1.text = [telArray objectAtIndex:indexPath.row];
            quote.text = [limitArray objectAtIndex:indexPath.row];
            
            /*
            if (filestatus) {
                name1.text = [addFavour objectAtIndex:0];
                number1.text= [addFavour objectAtIndex:1];
                quote.text = [addFavour objectAtIndex:2];
            }
            
            */
            
            [cell.contentView addSubview:name1];
            [cell.contentView addSubview:number1];
            [cell.contentView addSubview:name];
            [cell.contentView addSubview:quote];
            [cell.contentView addSubview:quoteLabel];
            [cell.contentView addSubview:number];
        }
        
        
        if (indexPath.row == 1) {
            
            
            UIImage *minusImg = [UIImage imageNamed:@"minus.png"];
            minusButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
            minusButton.frame = CGRectMake(700, 30, minusImg.size.width, minusImg.size.height);
            minusButton.backgroundColor = [UIColor clearColor];
            [minusButton setBackgroundImage:minusImg forState:UIControlStateNormal];
            [minusButton addTarget:self action:@selector(minusMethod:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:minusButton];
            
            
            number22 = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 30)];
            number22.textColor = [UIColor blackColor];
            number22.backgroundColor = [UIColor clearColor];
            number22.text = @"Number:";
            
            name22 = [[UILabel alloc]initWithFrame:CGRectMake(270, 20, 100, 30)];
            name22.textColor = [UIColor blackColor];
            name22.backgroundColor = [UIColor clearColor];
            name22.text = @"Name:";
            
            quoteLabel22 = [[UILabel alloc]initWithFrame:CGRectMake(470, 20, 100, 30)];
            quoteLabel22.textColor = [UIColor blackColor];
            quoteLabel22.backgroundColor = [UIColor clearColor];
            quoteLabel22.text = @"Quote:";
            
            number2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 25, 120, 30)];
            number2.borderStyle = UITextBorderStyleRoundedRect;
            name2 = [[UITextField alloc]initWithFrame:CGRectMake(330, 25, 120, 30)];
      
            name2.borderStyle = UITextBorderStyleRoundedRect;
            
            quote2 = [[UITextField alloc]initWithFrame:CGRectMake(550, 25, 120, 30)];
       
            quote2.borderStyle = UITextBorderStyleRoundedRect;
            
         
            
           // NSString *checkname = [NSString stringWithFormat:@"%@",[nameArray objectAtIndex:1]];
            if ([nameArray count] >1) {
                name2.text = [nameArray objectAtIndex:indexPath.row];
                number2.text = [telArray objectAtIndex:indexPath.row];
                quote2.text = [limitArray objectAtIndex:indexPath.row];
            }
            
            else {
                [number2 setHidden:YES];
                [name2 setHidden:YES];
                [quote2 setHidden:YES];
                [quoteLabel22 setHidden:YES];
                [number22 setHidden:YES];
                [name22 setHidden:YES];
                [minusButton setHidden:YES];
            }
            
            
            
            /*
            if ([addFavour count] == 6) {
                
                name2.text = [addFavour objectAtIndex:3];
                number2.text = [addFavour objectAtIndex:4];
                quote2.text = [addFavour objectAtIndex:5];
            }
             */
        
            
            [cell.contentView addSubview:number2];
          
            [cell.contentView addSubview:name2];
            [cell.contentView addSubview:quote2];
            [cell.contentView addSubview:name22];
            [cell.contentView addSubview:quoteLabel22];
            [cell.contentView addSubview:number22];
        }
        
        if (indexPath.row == 2) {
            
            UIButton *submitButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
            submitButton.frame = CGRectMake(600, 30, 100, 30.0);
            [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
            submitButton.backgroundColor = [UIColor clearColor];
            
            [submitButton addTarget:self action:@selector(submitQuote:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:submitButton];
            
            
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    //
      // cell.textLabel.text = @"ffds";
    }
    
    return cell;
}

-(IBAction)minusMethod:(id)sender
{
    
    [number2 setHidden:YES];
    [name2 setHidden:YES];
    [quote2 setHidden:YES];
    [quoteLabel22 setHidden:YES];
    [number22 setHidden:YES];
    [name22 setHidden:YES];
    [minusButton setHidden:YES];
    countAdd = 0;
    countstatus = YES;
    
   // tipstatus2 = YES;

}

-(IBAction)addMethod:(id)sender
{
    countAdd++;
    [tableview reloadData];
    if (countAdd == 1) {
       
        NSLog(@"countadd%d",countAdd);
        [number2 setHidden:NO];
        [name2 setHidden:NO];
        [quote2 setHidden:NO];
        [quoteLabel22 setHidden:NO];
        [number22 setHidden:NO];
        [name22 setHidden:NO];
        [minusButton setHidden:NO];
    }

    if (countAdd > 1) {
        UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Current version is only suppor for two users" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myalert show];
        [myalert release];
    }
    
}

-(IBAction)submitQuote:(id)sender
{
    
    NSString *getNumber1 = number1.text;
    NSString *getName1 =name1.text;
    NSString *getQuote1 = quote.text;
    
    getNumber2 = number2.text;
    getName2 = name2.text;
    getQuote2 = quote2.text;
    addtofile = [[NSMutableArray alloc]init];
    
    NSDictionary *qqdata = [[NSDictionary alloc]initWithDictionary:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qqdata.xql?user=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]];    
    
    
    id key_topV =@"topV";
    int total = [[qqdata valueForKey:key_topV] intValue];

    if (total < [getQuote1 intValue] || total < [getQuote2 intValue]) {
        
        UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:@"Information" message:@"You share quote can't be more than total" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [myalert show];
        [myalert release];
        
     
    }
    
    
    else {
         NSLog(@"333");
        if (countAdd >0) {
        
            if ([getName1 length]< 1 || [getNumber1 length] < 1 || [getQuote1 length] < 1 || [getName2 length]< 1 || [getNumber2 length] < 1 || [getQuote2 length] < 1) 
            {
                
                UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please fill up blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [myalert show];
                [myalert release];
                
            }
            else {
                
           
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Please enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
                [password setBackgroundColor:[UIColor whiteColor]];
                password.secureTextEntry = YES;
                [myAlertView addSubview:password];
                [myAlertView show];
                [myAlertView release];
                noralstatus = YES;
                passwordStatus = YES;
                saveStatus =YES;
            }
            
            
            
        }
        
        else {
            
            if ([getName1 length]< 1 || [getNumber1 length] < 1 || [getQuote1 length] < 1) 
            {
                UIAlertView *myalert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please fill up blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [myalert show];
                [myalert release];
                
            }
            else 
            {
                
                
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Please enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
                [password setBackgroundColor:[UIColor whiteColor]];
                password.secureTextEntry = YES;
                [myAlertView addSubview:password];
                [myAlertView show];
                [myAlertView release];
                
                saveStatus = YES;
                noralstatus = YES;
                passwordStatus = YES;
            }
            
        }
        
        
    }
    
    

 
    
    
    
    ///Remove
    /*
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    
    NSString *databaseFile = [documentsDirectoryPath stringByAppendingPathComponent:@"text.txt"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:databaseFile error:NULL];
    */
    ///
    
    
    
    //[NSKeyedArchiver archiveRootObject:((My4DResultAppDelegate *)APPDELEGATE).storeAllImportant
                               // toFile:[NSString stringWithFormat:@"%@/messageImportant.txt",DOCUMENT]];
    /*
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/messages.txt",DOC]]) {
		//exists
		addFavour=[[NSMutableArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/messages.txt",DOC]]];
		for (int i=0; i<[addFavour count]; i++) {
			NSLog(@"message:%@",[addFavour objectAtIndex:i]);
		}
	}
     */
    
   //
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


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"string entered=%@",password.text);
    if (buttonIndex == 0) {
        tipstatus = NO;
        tipstatus2 = NO;
        noralstatus = NO;
        passwordStatus = NO;
    }
    
    if (buttonIndex == 1) {
        
        
        if (tipstatus2 && [password.text isEqualToString:@"1234"])
        {
            [b1 setTitle:@"Buy" forState:UIControlStateNormal];
            id key1 = @"tel";
            id key2 = @"name";
            id key3 = @"limit";
            
            NSDictionary *dict1= [[NSDictionary alloc]initWithObjectsAndKeys:@"",key1,@"",key2,@"",key3,nil];
            NSArray * alist = [[NSArray alloc]initWithObjects:dict1, nil];
            
            [self httppost:[NSString stringWithFormat:@"%@updataqs.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:alist format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
            
            list = [[NSMutableArray alloc]initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@qsdata.xql?userid=%@",websv,[self getusernumber]]]]mutabilityOption:0 format:NULL errorDescription:Nil]]; 
            
            number1.text = @"";
            name1.text = @"";
            quote.text = @"";
            
            number2.text = @"";
            name2.text = @"";
            quote2.text = @"";
            
            [tableview reloadData];
            tableview.hidden = YES;
            tipstatus2 = NO;
            
            UIAlertView *cancelalert = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your service has been cancel" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
            [cancelalert show];
            [cancelalert release];
            
        }
        
       
        
         if(noralstatus && [password.text isEqualToString:@"1234"]) 
        {
            
            NSString *getNumber1 = number1.text;
            NSString *getName1 =name1.text;
            NSString *getQuote1 = quote.text;
            
            
            getNumber2 = number2.text;
            getName2 = name2.text;
            getQuote2 = quote2.text;
            
            if (countstatus) {
                getNumber2 = @"";
                getName2 = @"";
                getQuote2 = @"";
            }
            // if savestatus is true then means it has two users
            if (saveStatus) {
                
                id key1 = @"name";
                id key2 = @"tel";
                id key3 = @"limit";
                
                NSDictionary * dict1 = [NSDictionary dictionaryWithObjectsAndKeys:getName1,key1,getNumber1,key2,getQuote1,key3,nil];
                NSDictionary * dict2 = [NSDictionary dictionaryWithObjectsAndKeys:getName2,key1,getNumber2,key2,getQuote2,key3,nil];
                
                NSLog(@"dict2:%@",dict2);
                NSArray * alist = [NSArray arrayWithObjects:dict1,dict2, nil];
                
                
                [self httppost:[NSString stringWithFormat:@"%@updataqs.xql?userid=%@",websv,[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:alist format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
                
                UIAlertView *myalertview2 = [[UIAlertView alloc]initWithTitle:@"Congratulations" message:@"You have subscribe the package successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myalertview2 show];
                [myalertview2 release];
                noralstatus = NO;
                countstatus  =NO;
                
            }
            
            else {
                id key1 = @"name";
                id key2 = @"tel";
                id key3 = @"limit";
                
                NSDictionary * dict1 = [NSDictionary dictionaryWithObjectsAndKeys:getName1,key1,getNumber1,key2,getQuote1,key3,nil];
                
                
                NSArray * alist = [NSArray arrayWithObjects:dict1,dict1, nil];
                
                
                [addtofile addObject:getName1];
                [addtofile addObject:getNumber1];
                [addtofile addObject:getQuote1];
                
                [self httppost:[NSString stringWithFormat:@"updataqs.xql?userid=%@",[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:alist format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
                
                UIAlertView *myalertview2 = [[UIAlertView alloc]initWithTitle:@"Congratulations" message:@"You have subscribe the package successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myalertview2 show];
                [myalertview2 release];
                
            }
            
        }
        
        
        
         if(buttonIndex == 1 && tipstatus)
        {
            
            
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Please enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
            [password setBackgroundColor:[UIColor whiteColor]];
            password.secureTextEntry = YES;
            [myAlertView addSubview:password];
            [myAlertView show];
            [myAlertView release];
            passwordStatus = YES;
            tipstatus2 = YES;
            
        }
        
    if (![password.text isEqualToString:@"1234"] && passwordStatus) {
       
        UIAlertView *error = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Your password is incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [error show];
        [error release];
        passwordStatus = NO;
        
    }   
        
}
    
       
    
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;   
}

- (IBAction)buy:(id)sender
{
    UIButton * abutton = (UIButton*) sender;
    if (abutton.titleLabel.text == @"Cancel") {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Please enter for the password" message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        password= [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
        [password setBackgroundColor:[UIColor whiteColor]];
        password.secureTextEntry = YES;
        [myAlertView addSubview:password];
        [myAlertView show];
        [myAlertView release];

        passwordStatus = YES;
        tipstatus2 = YES;
      
    }else {
        [b1 setTitle:@"Cancel" forState:UIControlStateNormal];
        tableview.hidden = NO; 
       
    }
}


@end
