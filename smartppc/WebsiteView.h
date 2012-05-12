//
//  WebsiteView.h//  smartppc
//
//  Created by 勇 潘 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteView : UIView

@property(nonatomic,retain) UIScrollView * scrollview;
@property(nonatomic,retain) UILabel * title;
@property(nonatomic,retain) UILabel * thetext;
@property(nonatomic,retain) NSArray *webpages;
- (void)layoutScrollImages;
@end