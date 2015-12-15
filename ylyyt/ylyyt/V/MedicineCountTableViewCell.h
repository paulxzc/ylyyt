//
//  MedicineCountTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol orderFinishDelegate <NSObject>

- (void)pushToOrderFinishVC:(NSInteger)count;

@end

@interface MedicineCountTableViewCell : UITableViewCell

@property (nonatomic, retain) id<orderFinishDelegate> delegate;

@end
