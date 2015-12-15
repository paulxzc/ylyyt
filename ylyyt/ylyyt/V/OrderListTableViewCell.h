//
//  OrderListTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderListItem;

@interface OrderListTableViewCell : UITableViewCell

- (void)refreshCell:(OrderListItem*)orderListItem;

@end
