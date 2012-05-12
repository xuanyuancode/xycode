#import "HistoryView.h"

@implementation HistoryView
@synthesize tableview,daylist,monthlist;

static int width = 750;
static int font = 14; 

static float yellow_R = 231.0/255;
static float yellow_G = 231.0/255;
static float yellow_B = 231.0/255;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:yellow_R green:yellow_G blue:yellow_B alpha:1];
        // Initialization code
        UIImage *formImg = [UIImage imageNamed:@"form.png"];
        UIImageView *myimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 350, formImg.size.width, formImg.size.height)];
        myimageview.image = formImg;
        
        UIImage *columnImg = [UIImage imageNamed:@"column.png"];
        UIImageView *columnview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, columnImg.size.width, columnImg.size.height)];
        columnview.image = columnImg;
        
        [self addSubview:columnview];
        [self addSubview:myimageview];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *day = [[NSDateFormatter alloc]init];
        NSDateFormatter *year = [[NSDateFormatter alloc]init];
        NSDateFormatter *month = [[NSDateFormatter alloc]init];
        [day setDateFormat:@"dd"];
        [year setDateFormat:@"yy"];
        [month setDateFormat:@"MM"];
        
        NSString *daystring = [day stringFromDate:date];
        NSString *yearstring = [year stringFromDate:date];
        NSString *monthstring = [month stringFromDate:date];
        NSString* val = daystring;
        NSString *valyear = yearstring;
        NSString *valmonth = monthstring;
        
        
       // int monthint = [monthstring intValue];
        
        
        int trye = [val intValue];
        int monthinttry = [monthstring intValue];
        int final = trye;
        int c = 630;
        for (int i = 7; i>0; i--) {
            
            final--;
            if (trye - i ==0) 
            {
                final = 30;
                monthinttry = monthinttry -1;
            }
            
            if (i == 4) {
                c = 340;
            }
            
            NSLog(@"final %d",final);
            UILabel *seventh = [[UILabel alloc] initWithFrame:CGRectMake(c, 250, 100, 30)];
            seventh.text = [NSString stringWithFormat:@"20%@/%.2d/%.2d",yearstring,monthinttry,final];
            seventh.backgroundColor = [UIColor clearColor];
            seventh.font = [UIFont systemFontOfSize:15];
            [self addSubview:seventh];
            
            c = c-100;
            
        }
        
        
        
        
        int yeartry = [valyear intValue];
        int monthtry = [valmonth intValue];
        
        int finalyear = yeartry;
        int finalmonth = monthtry;
        
        int cc = 435;
        for (int j = 1; j<5; j++) {
            
            finalmonth--;
            if (monthtry - j ==0) 
            {
                finalmonth = 12;
                finalyear = finalyear -1;
            }
            
            if (j == 2) {
                cc = 470;
            }
            
            if (j == 3) {
                cc = 508;
            }
            
            if (j == 4) {
                cc = 545;
            }
            
            if (j == 5) {
                cc = 580;
            }
            
            
            NSLog(@"finalfffdd %d",finalmonth);
            
            UILabel *monthly = [[UILabel alloc] initWithFrame:CGRectMake(100,cc, 100, 30)];
            monthly.text = [NSString stringWithFormat:@"20%.2d/%.2d",finalyear,finalmonth];
            monthly.backgroundColor = [UIColor clearColor];
            monthly.font = [UIFont systemFontOfSize:15];
            [self addSubview:monthly];
            
            cc = cc+30;
            
        }
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    id key1 = @"time";
    id key2 = @"num";
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"2012-04",key1,@"287",key2,nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2012-03",key1,@"207",key2,nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"2012-02",key1,@"187",key2,nil];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"2012-01",key1,@"181",key2,nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011-12",key1,@"127",key2,nil];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:@"2011-11",key1,@"134",key2,nil];
    monthlist = [[NSArray alloc] initWithObjects:dict1,dict2,dict3,dict4,dict5,dict6,nil];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 320, width, 300) style:UITableViewStylePlain];
    [tableview setBounces:NO];
    tableview.delegate = self;
    tableview.dataSource = self;
    
    //[self addSubview:tableview];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [monthlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"abc";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    id key1 = @"time";
    id key2 = @"num";
    cell.textLabel.text =[NSString stringWithFormat:@"%@       %@Mb", [[monthlist objectAtIndex:indexPath.row] objectForKey:key1],[[monthlist objectAtIndex:indexPath.row] objectForKey:key2]]; 
    cell.textLabel.font = [UIFont systemFontOfSize:font + 2]; 
    cell.detailTextLabel.font = [UIFont systemFontOfSize:font + 3];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}



@end