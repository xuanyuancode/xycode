//
//  flightCityList.m
//  smartppc
//
//  Created by iMac02 on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "flightCityList.h"

@interface flightCityList ()

@end

@implementation flightCityList
@synthesize citylist,cityTable;


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
    [super viewDidLoad];
    cityTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    citylist = [[NSMutableArray alloc]initWithObjects:@"shanghai",@"beijing",@"nanjing",@"guangzhou",@"shenzhen", nil];

    cityTable.delegate = self;
    cityTable.dataSource = self;
    [self.view addSubview:cityTable];
    
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [citylist count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"abc";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
   
       cell.textLabel.text =[citylist objectAtIndex:indexPath.row]; 
    
    }
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [((AppDelegate *)APPDELEGATE).fv.cityButton setTitle:[citylist objectAtIndex:indexPath.row]forState:UIControlStateNormal];
   
    [((AppDelegate *)APPDELEGATE).fv.cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    ((AppDelegate *)APPDELEGATE).fv.indexing = indexPath.row;
    
    
    
    
    [((AppDelegate *)APPDELEGATE).fv.popover dismissPopoverAnimated:YES];
}



@end
