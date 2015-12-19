//
//  BtnTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainPage;

@protocol btnDelegate <NSObject>

- (void)btnFunction:(NSInteger)selectedBtn;

@end

@interface BtnTableViewCell : UITableViewCell

@property (nonatomic, retain) id <btnDelegate> delegate;

- (void)refreshCell:(MainPage*)mainPage;

@end
