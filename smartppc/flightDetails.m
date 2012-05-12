//
//  flightDetails.m
//  smartppc
//
//  Created by iMac02 on 12-4-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "flightDetails.h"
#import "flightInfo.h"
@implementation flightDetails
@synthesize flightModel,departureTime,airport,lowestOffer,order;
@synthesize flightModel1,departureTime1,airport1,lowestOffer1;
@synthesize line1,line2,line3,line4,line5;
@synthesize flightTime;
@synthesize departTime;
@synthesize flightTime1;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.frame = CGRectMake(20, 300, 970, 400);
        //self.backgroundColor = [UIColor grayColor];
        UIImage *bg = [UIImage imageNamed:@"flightDetails3.png"];
        UIImageView *bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bg.size.width, bg.size.height)];
        bgview.image = bg;
        [self addSubview:bgview];

        
        int compareint1 = ((AppDelegate *)APPDELEGATE).fv.indexing;
        int compareint2 = ((AppDelegate *)APPDELEGATE).fv.indexing2;
        
        
        
        if (compareint1 == 0 && compareint2 == 1 ) {
            
            line1 = [[NSArray alloc]initWithObjects:@"China Airlines CA233 Airbus 300",@"Nanfang Airlines CZ3908 Airbus 300",@"Shanghai Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"12:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"14:40",@"13:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"ShangHai Airport,Building B",@"ShangHai Airport,Building B",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$230",@"$250",@"$270", nil];
            
            [self firstline];
        }
        
        else if(compareint1 == 0 && compareint2 == 2)
        {
            line1 = [[NSArray alloc]initWithObjects:@"China Airlines CA233 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"Shanghai Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"12:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"14:40",@"13:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"ShangHai Airport,Building A",@"ShangHai Airport,Building C",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$130",@"$110",@"$170", nil];
            
            [self firstline];
        }
        
        else if(compareint1 == 0 && compareint2 == 3)
        {
        
            line1 = [[NSArray alloc]initWithObjects:@"Guangzhou Airlines CA233 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"Beijing Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"12:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"14:40",@"13:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"shenzhen Airport,Building A",@"ShangHai Airport,Building C",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$330",@"$310",@"$370", nil];
            
            [self firstline];
            
        }
     
        else if(compareint1 == 0 && compareint2 == 4)
        {
            
            line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"12:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"14:40",@"13:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"shenzhen Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$290",@"$220",@"$210", nil];
            
            [self firstline];
            
        }
        
        
        else if(compareint1 == 1 && compareint2 == 0)
        {
            
            line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"shenzhen Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$290",@"$220",@"$210", nil];
            
            [self firstline];
            
        }

        
        else if(compareint1 == 1 && compareint2 == 2)
        {
            
            line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"shenzhen Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
            
            [self firstline];
            
        }
        
        
        else if(compareint1 == 1 && compareint2 == 3)
        {
            
            line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
            
            [self firstline];
            
        }
        
        else if(compareint1 == 1 && compareint2 == 4)
        {
            
            line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
            
            line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
            
            line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
            
            line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
            
            line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
            
            [self firstline];
            
        }
        
        
    else if(compareint1 == 2 && compareint2 == 0)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    
    else if(compareint1 == 2 && compareint2 == 1)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    
    else if(compareint1 == 2 && compareint2 == 3)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    else if(compareint1 == 2 && compareint2 == 4)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    
    else if(compareint1 == 3 && compareint2 == 0)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    else if(compareint1 == 3 && compareint2 == 1)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
        
    else if(compareint1 == 3 && compareint2 == 2)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    else if(compareint1 == 3 && compareint2 == 4)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    
    else if(compareint1 == 4 && compareint2 == 0)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }

    else if(compareint1 == 4 && compareint2 == 1)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    else if(compareint1 == 4 && compareint2 == 2)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
    
    else if(compareint1 == 4 && compareint2 == 3)
    {
        
        line1 = [[NSArray alloc]initWithObjects:@"shenzhen Airlines CA533 Airbus 300",@"Nanfang Airlines CZ9990 Airbus 300",@"China Airlines FM9107 Airbus 300", nil];
        
        line2 = [[NSArray alloc]initWithObjects:@"10:15",@"11:50",@"21:25", nil];
        
        line3 = [[NSArray alloc]initWithObjects:@"13:40",@"12:55",@"00:55", nil];
        
        line4 = [[NSArray alloc]initWithObjects:@"beijing Airport,Building A",@"shenzhen Airport,Building C",@"ShangHai Airport,Building B",nil];
        
        line5 = [[NSArray alloc]initWithObjects:@"$190",@"$240",@"$123", nil];
        
        [self firstline];
        
    }
       
    
    }
    return self;
}


-(void)firstline
{

    
    
    
    int j =0;
    for (int i = 0; i <3; i++) 
    {
       
        UILabel *flightModel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 0+j+20, 200, 120)];
            flightModel2.text = [line1 objectAtIndex:i];
            flightModel2.backgroundColor = [UIColor clearColor];
            flightModel2.numberOfLines = 0;
            flightModel2.textAlignment = UITextAlignmentLeft;
            
           UILabel *departureTime2 = [[UILabel alloc]initWithFrame:CGRectMake(270, 20+j, 50, 120)];
            departureTime2.text = [line2 objectAtIndex:i];
            departureTime2.backgroundColor = [UIColor clearColor];
            departureTime2.numberOfLines = 0;
            
           UILabel *flightTime2 = [[UILabel alloc]initWithFrame:CGRectMake(270, 35+j+50, 50, 30)];
            flightTime2.text = [line3 objectAtIndex:i];
            flightTime2.backgroundColor = [UIColor clearColor];
            flightTime2.numberOfLines = 0;
            
           UILabel *airport2 = [[UILabel alloc]initWithFrame:CGRectMake(400,10+j+40, 150, 70)];
            airport2.text = [line4 objectAtIndex:i];
            airport2.backgroundColor = [UIColor clearColor];
            airport2.numberOfLines = 0;

         UILabel *lowestOffer2 = [[UILabel alloc]initWithFrame:CGRectMake(700, 20+j+50, 200, 30)];
            lowestOffer2.text =[line5 objectAtIndex:i];
         lowestOffer2.backgroundColor = [UIColor clearColor];
        
         j += 70;
        
        UIImage *orderimg = [UIImage imageNamed:@"order.png"];
        UIButton *order1 =  [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        // [button setTitle:@"Show View" forState:UIControlStateNormal];
         order1.frame = CGRectMake(830, 0+j,orderimg.size.width, orderimg.size.height);
        
        //UIImage *buttonImageNormal2 = [UIImage imageNamed:@"userFinal.png"];
        //[cityButton setBackgroundImage:buttonImageNormal2 forState:UIControlStateNormal];
        [order1 setBackgroundImage:orderimg forState:UIControlStateNormal];
        [order1 addTarget:nil action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:order1];
        [self addSubview:flightModel2];
        [self addSubview:departureTime2];
        [self addSubview:flightTime2];
        [self addSubview:airport2];
        [self addSubview:lowestOffer2];
        [order1 release];
        [flightModel2 release];
        [departureTime2 release];
        [flightTime2 release];
        [airport2 release];
        [lowestOffer2 release];
        
        
   
    }
    
    
    
    
 
    

    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
