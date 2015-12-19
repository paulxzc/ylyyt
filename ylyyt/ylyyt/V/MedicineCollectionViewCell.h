//
//  MedicineCollectionViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubCatalog;

@interface MedicineCollectionViewCell : UICollectionViewCell

- (void)refreshCell:(SubCatalog *)subCatalog;

@end
