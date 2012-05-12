//
//  VediosView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VediosView : UIView<UIScrollViewDelegate>
@property(nonatomic,retain) UIScrollView * scrollview;
@property(nonatomic,retain) UIPageControl * pc;

- (void)layoutScrollImages;
- (IBAction)changevideo:(id)sender; 
- (NSArray*)loaddb;
@end
