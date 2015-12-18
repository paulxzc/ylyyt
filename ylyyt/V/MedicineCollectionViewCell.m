//
//  MedicineCollectionViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineCollectionViewCell.h"
#import "SubCatalog.h"

@interface MedicineCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *medicineImageView;
@property (weak, nonatomic) IBOutlet UILabel *medicineLabel;

@end

@implementation MedicineCollectionViewCell

- (void)refreshCell:(SubCatalog *)subCatalog{
    self.medicineImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",subCatalog.catalogIcon]];
    self.medicineLabel.text = [NSString stringWithFormat:@"%@",subCatalog.catalogName];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
