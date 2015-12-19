//
//  MedicineTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pushToMedicineDelegate <NSObject>

- (void)pushToMedicine:(NSString *)medicineName;

@end

@class MainPage;

@interface MedicineTableViewCell : UITableViewCell

@property (nonatomic, retain) id<pushToMedicineDelegate> delegate;

- (void)refreshCell:(MainPage*)mainPage;

@end
