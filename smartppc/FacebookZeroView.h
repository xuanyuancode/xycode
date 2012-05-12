//
//  FacebookZeroView.h
//  smartppc
//
//  Created by 勇 潘 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookZeroView : UIView<UIAlertViewDelegate>
@property(nonatomic,retain) UILabel * lable1;
@property(nonatomic,retain) UILabel * lable2;
@property(nonatomic,retain) UILabel * lable3;
@property(nonatomic,retain) UIButton * b1;
@property int state;
@property int on;
@property(nonatomic,retain)UITextField * password;
@property int alertid;

- (NSString*)getusernumber;


@end
