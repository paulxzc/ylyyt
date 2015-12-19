//
//  PromotionTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainPage;

@protocol pushToDrugStoreDelegate <NSObject>

- (void)pushToDrugStore:(NSString *)linkUrl;

@end

@interface PromotionTableViewCell : UITableViewCell

@property (nonatomic, retain) id <pushToDrugStoreDelegate> delegate;

- (void)refreshCell:(MainPage*)mainPage;

@end
