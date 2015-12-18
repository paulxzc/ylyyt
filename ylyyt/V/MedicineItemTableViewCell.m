//
//  MedicineItemTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineItemTableViewCell.h"
#import "HotItem.h"

@interface MedicineItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;

@end

@implementation MedicineItemTableViewCell

- (void)refreshCell:(HotItem*)hotItem{
    self.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",hotItem.itemIcon]];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",hotItem.itemName];
    
    self.pricelabel.text = [NSString stringWithFormat:@"价格:%@",hotItem.itemPrice];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
