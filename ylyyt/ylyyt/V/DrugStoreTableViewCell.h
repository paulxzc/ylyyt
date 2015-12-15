//
//  DrugStoreTableViewCell.h
//  yylyytv1
//
//  Created by apple on 15/10/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyMedicineDelegate <NSObject>

- (void)medicineBuy;

@end

@class ShopInfo;

@interface DrugStoreTableViewCell : UITableViewCell

@property (nonatomic, retain) id<BuyMedicineDelegate> delegate;

- (void)refrehCell:(ShopInfo*)shopInfo;

- (void)refreshCellForAttention:(ShopInfo*)shopInfo;

@end
