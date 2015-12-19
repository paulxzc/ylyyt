//
//  MedicineInfoTableViewCell.h
//  yylyytv1
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReturnDataItemShow;

@interface MedicineInfoTableViewCell : UITableViewCell

- (void)refreshCell:(ReturnDataItemShow*)returnDataItemShow;

@end
