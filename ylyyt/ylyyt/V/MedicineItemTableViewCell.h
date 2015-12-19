//
//  MedicineItemTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotItem;

@interface MedicineItemTableViewCell : UITableViewCell

- (void)refreshCell:(HotItem*)hotItem;

@end
