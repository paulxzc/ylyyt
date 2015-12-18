//
//  MedicineInfoTableViewCell.m
//  yylyytv1
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineInfoTableViewCell.h"
#import "ReturnDataItemShow.h"
#import "MedicineItemDetail.h"
#import "MedicineImage.h"

@interface MedicineInfoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *medicineImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *specificationLabel;


@end

@implementation MedicineInfoTableViewCell

- (void)refreshCell:(ReturnDataItemShow*)returnDataItemShow{
    MedicineItemDetail *medicineItemDetail = returnDataItemShow.it[0];
    _medicineImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",medicineItemDetail.imageName]];
//    _itemNameLabel.text = [NSString stringWithFormat:@"通用名:%@",medicineItemDetail.itemName];
//    _pinNameLabel.text = [NSString stringWithFormat:@"品名:%@",medicineItemDetail.pinName];
//    _originPlaceLabel.text = [NSString stringWithFormat:@"产地:%@",medicineItemDetail.originPlace];
//    _unitLabel.text = [NSString stringWithFormat:@"单位:%@",medicineItemDetail.unit];
//    _specificationLabel.text = [NSString stringWithFormat:@"规格:%@",medicineItemDetail.specification];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
