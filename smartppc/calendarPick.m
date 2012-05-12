//
//  calendarPick.m
//  smartppc
//
//  Created by iMac02 on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "calendarPick.h"
@interface calendarPick ()

@end

@implementation calendarPick
@synthesize flightdate;
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
    
    flightdate = [[UIDatePicker alloc]initWithFrame:CGRectMake(-230, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    flightdate.datePickerMode = UIDatePickerModeDate;
   	
    NSDate *Date=[NSDate date];
    
    flightdate.minimumDate=Date;
    
    
    
    [self.flightdate addTarget:self action:@selector(updateLabelFromPicker:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:flightdate];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MM-dd-yyyy"];    
    NSString *result = [outputFormatter stringFromDate:flightdate.date];
    [((AppDelegate *)APPDELEGATE).fv.dateButton setTitle:result forState:UIControlStateNormal];
    [((AppDelegate *)APPDELEGATE).fv.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [outputFormatter release];
    
    
}

-(IBAction)updateLabelFromPicker:(id)sender
{   NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *result = [outputFormatter stringFromDate:flightdate.date];
    [((AppDelegate *)APPDELEGATE).fv.dateButton setTitle:result forState:UIControlStateNormal];
    [((AppDelegate *)APPDELEGATE).fv.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

@end
