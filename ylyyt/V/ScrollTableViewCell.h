//
//  ScrollTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReturnDataItemShow;
@interface ScrollTableViewCell : UITableViewCell

- (void)refreshCell:(ReturnDataItemShow *)returnDataItemShow;

@end
