//
//  backupSelect.m
//  smartppc
//
//  Created by iMac02 on 12-5-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "backupSelect.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface backupSelect ()

@end

@implementation backupSelect
@synthesize mytable;
@synthesize content;
@synthesize indicator;
@synthesize mynumber;
@synthesize mytimer;
@synthesize myalert;

static NSString * websv = @"http://192.168.1.104:8080/exist/rest//db/smartpcc/xql/";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
        
        
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    number = 0;
    count2 = 0;
    content = [[NSArray alloc]initWithObjects:@"dd",@"ff",nil];
    
    mytable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
        mytable.dataSource = self;
        mytable.delegate = self;

    
    [self.view addSubview:mytable];
    
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70; 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [content count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"abc";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    
        if (indexPath.row == 0) 
        {
            UIImage *backupimg = [UIImage imageNamed:@"bakcup.png"];
            UIImageView *backupimgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, backupimg.size.width, backupimg.size.height)];
            backupimgview.image = backupimg;
            [cell.contentView addSubview:backupimgview];
            [backupimgview release];
            UILabel *backup = [[UILabel alloc]initWithFrame:CGRectMake(80, 17, 200, 30 )];
            backup.text = @"Back up contacts";
            backup.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:backup];
            [backup release];
        }
        
        else 
        {
        
            UIImage *restoreimg = [UIImage imageNamed:@"restore.png"];
            UIImageView *restoreimgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, restoreimg.size.width, restoreimg.size.height)];
            
            restoreimgview.image = restoreimg;
            
            [cell.contentView addSubview:restoreimgview];
            [restoreimgview release];
            UILabel *restore = [[UILabel alloc]initWithFrame:CGRectMake(80, 17, 200, 30 )];
            restore.text = @"Restore contacts";
            restore.backgroundColor =  [UIColor clearColor];
            
            [cell.contentView addSubview:restore];
            [restore release];
        }
        
        
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	if (indexPath.row == 0) {
       //
        count2 = 0;
        myalert = [[UIAlertView alloc]initWithTitle:@"Back up contacts" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.center = CGPointMake(20, 20);
        indicator.hidesWhenStopped = YES;
        indicator.frame = CGRectMake(120, 48, indicator.frame.size.width, indicator.frame.size.height);
       
        
        mynumber = [[UILabel alloc]initWithFrame:CGRectMake(170, 53, 100, 30)];
        mynumber.backgroundColor = [UIColor clearColor];
        mynumber.textColor = [UIColor whiteColor];
        [mynumber setFont:[UIFont systemFontOfSize:20]];
        mynumber.text = @"0%";
        [myalert addSubview:mynumber];
        [myalert addSubview:indicator];
        [myalert show];
        [self savemem]; 
        [indicator startAnimating];
        
        
        
        
       mytimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(addnumbers:)
                                       userInfo:nil
                                        repeats:YES];
    }
    
    if(indexPath.row == 1)
    {
        count2 = 0;
        myalert = [[UIAlertView alloc]initWithTitle:@"Restore contacts" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.center = CGPointMake(20, 20);
        indicator.hidesWhenStopped = YES;
        indicator.frame = CGRectMake(120, 48, indicator.frame.size.width, indicator.frame.size.height);
        
        
        mynumber = [[UILabel alloc]initWithFrame:CGRectMake(170, 53, 100, 30)];
        mynumber.backgroundColor = [UIColor clearColor];
        mynumber.textColor = [UIColor whiteColor];
        [mynumber setFont:[UIFont systemFontOfSize:20]];
        mynumber.text = @"0%";
        [myalert addSubview:mynumber];
        [myalert addSubview:indicator];
        [myalert show];
        [self loadmem]; 
        [indicator startAnimating];
        
        
        
        
        mytimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                   target:self
                                                 selector:@selector(addnumbers:)
                                                 userInfo:nil
                                                  repeats:YES];

        
    }
    
    
}

-(IBAction)addnumbers:(id)sender
{
    
    NSLog(@"hello ");
    number += 33;
    
    if (count2 == 0) {
        mynumber.text = [NSString stringWithFormat:@"%d%%",33];
    }
    
    else if(count2 == 1) {
        mynumber.text = [NSString stringWithFormat:@"%d%%",50];
    }
    
    else if(count2 == 2) {
       
        
        mynumber.text = [NSString stringWithFormat:@"%d%%",74];
    }
    

    
    else if(count2 == 3) {
        mynumber.text = [NSString stringWithFormat:@"%d%%",100];
        [mytimer invalidate];
        
        
        UIAlertView *successAlert = [[UIAlertView alloc]initWithTitle:@"Information" message:@"Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [successAlert show];
        [successAlert release];
         [self.myalert dismissWithClickedButtonIndex:-1 animated:YES];
    }
    count2++;
    
    
    
        
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
      
       
    }
    
}

-(NSMutableArray *)backup
{    
    NSMutableArray * list = [[NSMutableArray alloc]init];
    
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    
    for(int i = 0; i < CFArrayGetCount(results); i++)
    {
        NSString * tel = [[NSString alloc] initWithString:@""];
        NSString * fname = [[NSString alloc] initWithString:@""];
        NSString * lname = [[NSString alloc] initWithString:@""];
        NSString * city = [[NSString alloc] initWithString:@""];
        
        id key1 = [[NSString alloc]initWithString:@"tel"];
        id key2 = [[NSString alloc]initWithString:@"fname"];
        id key3 = [[NSString alloc]initWithString:@"lname"];
        id key4 = [[NSString alloc]initWithString:@"city"];
        
        NSLog(@"%d",i);
        
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        
        CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUnicode);
        CFStringRef s1 = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        
        CFShow(s1);
        if (s1 != NULL) {
            fname = (NSString*)s1;
        }
        
        NSLog(@"fname:%@",fname);
        
        CFStringRef s2 = ABRecordCopyValue(person, kABPersonLastNameProperty);
        if (s2 != NULL) {
            lname = (NSString*)s2;
        }
        
        NSLog(@"lname:%@",lname);
        
        
        
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        if (ABMultiValueGetCount(address)>0) {
            NSDictionary* pa =(NSDictionary*) ABMultiValueCopyValueAtIndex(address, 0); 
            
            CFStringRef s3 = (CFStringRef)[pa objectForKey:(NSString *)kABPersonAddressCityKey];
            if (s3 != NULL) {
                city = (NSString*)s3;
            }
        }
        
        
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        if (ABMultiValueGetCount(phones)>0) 
        {
            CFStringRef s4 = ABMultiValueCopyValueAtIndex(phones, 0);
            if (s4 != NULL) {
                tel = (NSString*)s4;
            }
            
        }
        
        NSDictionary *thedict = [[NSDictionary alloc]initWithObjectsAndKeys:tel,key1,fname,key2,lname,key3,city,key4,nil];
        [list addObject:thedict];
    }
    
    CFRelease(results);
    CFRelease(addressBook);
    return list;
}

- (void)savemem
{
    NSLog(@"savemem");
    
    NSData * d1 = [self httppost:[NSString stringWithFormat:@"setmem.xql?userid=%@",[self getusernumber]] data:[NSPropertyListSerialization dataFromPropertyList:[self backup] format:NSPropertyListXMLFormat_v1_0 errorDescription:nil]];
    
    /*
     NSData * adata = [NSPropertyListSerialization dataFromPropertyList:[self backup] format:NSPropertyListXMLFormat_v1_0 errorDescription:nil];
     */
    
    NSLog(@"%@",[[NSString alloc] initWithData:d1 encoding:NSUTF8StringEncoding]);
    /*
    UIAlertView * aout = [[UIAlertView alloc] initWithTitle:@"infomation" message:@"backup success !" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [aout show];
     */
}

- (void)loadmem
{
    NSLog(@"loadmem");
    id city = @"city";
    id fname = @"fname";
    id lname = @"lname";
    id tel = @"tel";
    
    NSArray * list = [[NSArray alloc] initWithArray:[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@getmem.xql?userid=%@",websv,[self getusernumber]]]] mutabilityOption:0 format:NULL errorDescription:Nil]];
    NSLog(@"%@",list.description);
    
    ABAddressBookRef addressBook;
    addressBook = ABAddressBookCreate();
    
    bool wantToSaveChanges = YES;
    bool didSave;
    CFErrorRef error = NULL;
    
 
    for(int i = 0; i < [list count]; i++)
    {
        
        NSString * fnamebbb = [[list objectAtIndex:i] objectForKey:fname];
        NSString * lnamebbb = [[list objectAtIndex:i] objectForKey:lname];
        NSString * thename = [NSString stringWithFormat:@"%@ %@",lnamebbb,fnamebbb];
        
     
        CFArrayRef cfa= ABAddressBookCopyPeopleWithName(addressBook,(CFStringRef)thename);
        if (cfa) {
            if (CFArrayGetCount(cfa)==0) {
                ABRecordRef record = ABPersonCreate();
                ABRecordSetValue(record, kABPersonFirstNameProperty,(CFStringRef)[[list objectAtIndex:i] objectForKey:fname], &error);
                ABRecordSetValue(record, kABPersonLastNameProperty,(CFStringRef)[[list objectAtIndex:i] objectForKey:lname], &error);
                
                ABMutableMultiValueRef address = ABMultiValueCreateMutable(kABDictionaryPropertyType);
                
                CFStringRef keys[0];
                CFStringRef values[0];
                keys[0] = kABPersonAddressCityKey;
                values[0] = (CFStringRef)[[list objectAtIndex:i] objectForKey:city];
                
                CFDictionaryRef aDict = CFDictionaryCreate(
                                                           kCFAllocatorDefault,
                                                           (void *)keys,
                                                           (void *)values,
                                                           1,
                                                           &kCFCopyStringDictionaryKeyCallBacks,
                                                           &kCFTypeDictionaryValueCallBacks
                                                           );
                
                ABMultiValueIdentifier identifier;
                bool didAdd;
                didAdd = ABMultiValueAddValueAndLabel(address, aDict, kABPersonAddressCityKey, &identifier);
                if (!didAdd) {NSLog(@"multiv error");}
                CFRelease(aDict);
                ABRecordSetValue(record, kABPersonAddressProperty,address,&error);
                
                
                
                ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
                ABMultiValueIdentifier multivalueIdentifier;
                bool didAdd2, didSet2;
                
                didAdd2 = ABMultiValueAddValueAndLabel(multi, (CFStringRef)[[list objectAtIndex:i] objectForKey:tel],
                                                       kABPersonPhoneMobileLabel, &multivalueIdentifier);
                if (!didAdd2) {NSLog(@"add error");}
                
                
                didSet2 = ABRecordSetValue(record, kABPersonPhoneProperty, multi, &error);
                if (!didSet2)
                    CFRelease(multi);
                
                
                
                ABAddressBookAddRecord(addressBook, record, &error);
                
                CFRelease(address);

            }
            
        }
  
        
    }
    
    if (ABAddressBookHasUnsavedChanges(addressBook)) {
        if (wantToSaveChanges) {
            didSave = ABAddressBookSave(addressBook, &error);
            if (!didSave) {NSLog(@"save error");
            } else {
                ABAddressBookRevert(addressBook);
            }
    }
    }
    CFRelease(addressBook);
}

- (NSString*)getusernumber
    {
        NSFileManager *fm = [[NSFileManager alloc]init];
        NSString* rootpath = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] path];
        
        id key1 = @"user";
        return [[NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[rootpath stringByAppendingPathComponent:@"user.xml"]] mutabilityOption:0 format:NULL errorDescription:Nil] objectForKey:key1];
    }

- (NSData*)httppost:(NSString *)xql data:(NSData*)data
{
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",websv,xql]]]; 
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",websv,xql]);
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [req addValue:contentType forHTTPHeaderField: @"Content-Type"];  
    [req setHTTPMethod:@"POST"];   
    [req setHTTPBody:data];   
    NSURLResponse * response = nil;
    return [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
}

@end
