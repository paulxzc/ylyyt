//
//  BannerTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pushBannerDelegate <NSObject>

- (void)pushBanner:(NSString *)linkUrl;

@end

@class MainPage;

@interface BannerTableViewCell : UITableViewCell

@property (nonatomic, strong) id<pushBannerDelegate> delegate;

- (void)refreshCell:(MainPage*)mainPage;

@end
