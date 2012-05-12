//
//  cityTolist.m
//  smartppc
//
//  Created by iMac02 on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "cityTolist.h"

@interface cityTolist ()

@end

@implementation cityTolist
@synthesize citytotable,tocitylist;
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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    citytotable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    citytotable.delegate = self;
    citytotable.dataSource = self;
    
    tocitylist = [[NSMutableArray alloc]initWithObjects:@"shanghai",@"beijing",@"nanjing",@"guangzhou",@"shenzhen",nil];
    
    [self.view addSubview:citytotable];
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




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tocitylist count];
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
    }
    cell.textLabel.text =[tocitylist objectAtIndex:indexPath.row]; 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [((AppDelegate *)APPDELEGATE).fv.toButton setTitle:[tocitylist objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    ((AppDelegate *)APPDELEGATE).fv.indexing2 = indexPath.row;
    
     [((AppDelegate *)APPDELEGATE).fv.toButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [((AppDelegate *)APPDELEGATE).fv.popover2 dismissPopoverAnimated:YES];
    
}


@end
