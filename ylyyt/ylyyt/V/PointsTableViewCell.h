//
//  PointsTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PointList;

@interface PointsTableViewCell : UITableViewCell

- (void)refreshCell:(PointList *)pointList;

@end
