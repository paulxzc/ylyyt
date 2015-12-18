//
//  MedicineDetailTableViewCell.h
//  yylyytv1
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MedicineItem;

@class ReturnDataItemShow;

@protocol orderDelegate <NSObject>

- (void)pushToOrder:(MedicineItem*)medicineItem;

@end



@interface MedicineDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) id<orderDelegate> delegate;

- (void)refreshCell:(MedicineItem*)medicineItem;

- (void)refreshCellForItem:(ReturnDataItemShow *)returnDataItemShow;

@end
