//
//  flightResult.m
//  smartppc
//
//  Created by iMac02 on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "flightResult.h"

@interface flightResult ()

@end

@implementation flightResult
@synthesize departtimelabel1,departtimelabel2,departtimelabel,departtimelabel3;
@synthesize testLabel;
@synthesize pushDetails,pushDetails2;
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
    departstatus = NO;
	// Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor blueColor]];
    self.title = @"Flight booked";
    UIImage *titlebg = [UIImage imageNamed:@"tittle_bg.png"];
    UIImageView *titleimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, titlebg.size.width+70, titlebg.size.height)];
    titleimageview.image = titlebg;

    [self.view addSubview:testLabel];
    
    UIImage *bgresult = [UIImage imageNamed:@"framebig.png"];
    UIImageView *bgresultview = [[UIImageView alloc]initWithFrame:CGRectMake(50, 90, bgresult.size.width, bgresult.size.height)];
    bgresultview.image = bgresult;
    
    
    UIImage *notice = [UIImage imageNamed:@"ok.png"];
    UIImageView *noticeview = [[UIImageView alloc]initWithFrame:CGRectMake(60, 110, notice.size.width, notice.size.height)];
    noticeview.image = notice;
    
    UILabel *depart = [[UILabel alloc]initWithFrame:CGRectMake(230, 110, 100, 30)];
    depart.text = @"Departure:";
    depart.backgroundColor = [UIColor clearColor];
    
    UILabel *arrive = [[UILabel alloc]initWithFrame:CGRectMake(230, 150, 100, 30)];
    arrive.text = @"Arrival:";
    arrive.backgroundColor = [UIColor clearColor];
      
    UILabel *departtimelabel44 = [[UILabel alloc]initWithFrame:CGRectMake(230, 180, 200, 30)];
    departtimelabel44.text = @"Departure Time:";
    departtimelabel44.backgroundColor = [UIColor clearColor];
    
    
    UIImage *bgfriend = [UIImage imageNamed:@"shopping.png"];
    UIImageView *bgfriendview = [[UIImageView alloc]initWithFrame:CGRectMake(30, 300, bgfriend.size.width, bgfriend.size.height)];
    
    bgfriendview.image = bgfriend;
    
    
    UIImage *bgfriend2 = [UIImage imageNamed:@"film.png"];
    UIImageView *bgfriendview2 = [[UIImageView alloc]initWithFrame:CGRectMake(530, 300, bgfriend2.size.width, bgfriend2.size.height)];
    
    bgfriendview2.image = bgfriend2;
    [self.view addSubview:bgfriendview2];
    
    UILabel *discount = [[UILabel alloc]initWithFrame:CGRectMake(180, 480, 250, 40)];
    discount.text = @"Shopping Discount";
    discount.backgroundColor = [UIColor clearColor];
    discount.font = [UIFont systemFontOfSize:20.0];
    discount.textColor = [UIColor redColor];
    
    [self.view addSubview:discount];
    
    UILabel *filmdiscount = [[UILabel alloc]initWithFrame:CGRectMake(650, 480, 250, 40)];
    filmdiscount.text = @"Moive Ticket Discount";
    filmdiscount.backgroundColor = [UIColor clearColor];
    filmdiscount.font = [UIFont systemFontOfSize:20.0];
    filmdiscount.textColor = [UIColor redColor];
    
    [self.view addSubview:filmdiscount];
    
    
    
    UILabel *callyou = [[UILabel alloc]initWithFrame:CGRectMake(40, 250, 350, 40)];
    callyou.text = @"";
    callyou.backgroundColor = [UIColor clearColor];
    callyou.font = [UIFont systemFontOfSize:20.0];
    
    
    
    UILabel *youlike = [[UILabel alloc]initWithFrame:CGRectMake(40, 300, 350, 40)];
    youlike.text = @"You may like NBA";
    youlike.backgroundColor = [UIColor clearColor];
    
   
    UIImage *smallframe = [UIImage imageNamed:@"framesmall.png"];
    UIImageView *smallframeview = [[UIImageView alloc]initWithFrame:CGRectMake(640, 90, smallframe.size.width, smallframe.size.height)];
    smallframeview.image = smallframe;
    
    [self.view addSubview:smallframeview];
    
    UIImage *weather = [UIImage imageNamed:@"bg_weather.png"];
    UIImageView *weaterhview = [[UIImageView alloc]initWithFrame:CGRectMake(652, 105, weather.size.width -30, weather.size.height-30)];
    weaterhview.image=weather;
    
    UIImage *weatherpng = [UIImage imageNamed:@"weather.png"];
    UIImageView *weatherpngview = [[UIImageView alloc]initWithFrame:CGRectMake(665, 110, weatherpng.size.width, weatherpng.size.height)];
    weatherpngview.image = weatherpng;
    
    
    UIImage *umbrella = [UIImage imageNamed:@"umbrella.png"];
    UIImageView *umbrellaview = [[UIImageView alloc]initWithFrame:CGRectMake(673, 175, umbrella.size.width, umbrella.size.height)];
    umbrellaview.image = umbrella;
    
    
    UILabel *theWeather = [[UILabel alloc]initWithFrame:CGRectMake(755, 125, 200, 30)];
    theWeather.text = @"The Weather: Rain";
    theWeather.backgroundColor = [UIColor clearColor];
    theWeather.font = [UIFont systemFontOfSize:15];
    UILabel *temperature = [[UILabel alloc]initWithFrame:CGRectMake(755, 175, 200, 30)];
    temperature.text = @"The Temperature:25 C";
    temperature.backgroundColor = [UIColor clearColor];
    temperature.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:weaterhview];
    [self.view addSubview:bgfriendview];
  // [self.view addSubview:titleimageview];
    [self.view addSubview:bgresultview];
    [self.view addSubview:noticeview];
    [self.view addSubview:depart];
    [self.view addSubview:arrive];
    [self.view addSubview:departtimelabel44];
    [self.view addSubview:callyou];
    [self.view addSubview:weatherpngview];
    [self.view addSubview:umbrellaview];
    [self.view addSubview:theWeather];
    [self.view addSubview:temperature];
   // [self.view addSubview:youlike];
    departtimelabel1 = [[UILabel alloc]initWithFrame:CGRectMake(320, 110, 200, 30)];
    departtimelabel1.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:departtimelabel1];
    
    
    departtimelabel2 = [[UILabel alloc]initWithFrame:CGRectMake(320, 150, 200, 30)];
    
    departtimelabel2.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:departtimelabel2];  
    
    departtimelabel = [[UILabel alloc]initWithFrame:CGRectMake(370, 180, 200, 30)];
    //departtimelabel.text = ((AppDelegate *)APPDELEGATE).fv.departtime;
    [self.view addSubview:departtimelabel];
    
    
    departtimelabel = [[UILabel alloc]initWithFrame:CGRectMake(370, 180, 200, 30)];
    departtimelabel.text = ((AppDelegate *)APPDELEGATE).fv.departtime;
    [self.view addSubview:departtimelabel];
    
    
    pushDetails = [[UILabel alloc] initWithFrame:CGRectMake(100, 530, 250, 40 )];
    pushDetails.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pushDetails];
    
    pushDetails2 = [[UILabel alloc] initWithFrame:CGRectMake(600, 530, 250, 40 )];
    pushDetails2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pushDetails2];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];

    departtimelabel2.text =[NSString stringWithFormat:@"%@ Airport",((AppDelegate *)APPDELEGATE).fv.toButton.currentTitle];
    departtimelabel1.text = [NSString stringWithFormat:@"%@ Airport",((AppDelegate *)APPDELEGATE).fv.cityButton.currentTitle];
    departtimelabel.text = [NSString stringWithFormat:@"2012:%@",((AppDelegate *)APPDELEGATE).fv.departtime];
    departtimelabel.backgroundColor = [UIColor clearColor];
    
    departtimelabel2.textColor = [UIColor redColor];
    departtimelabel1.textColor = [UIColor redColor];
    departtimelabel.textColor = [UIColor redColor];
   
    
    pushDetails.text = @"push message about shopping";
    pushDetails2.text = @"push message about moive";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
