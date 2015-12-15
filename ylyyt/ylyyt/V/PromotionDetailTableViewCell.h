//
//  PromotionDetailTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface PromotionDetailTableViewCell : UITableViewCell

- (void)refreshCell:(News*)news;

@end
