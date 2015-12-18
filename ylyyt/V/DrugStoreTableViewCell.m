//
//  DrugStoreTableViewCell.m
//  yylyytv1
//
//  Created by apple on 15/10/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DrugStoreTableViewCell.h"
#import "ShopInfo.h"

@interface DrugStoreTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAdminLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopPhoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionOrBuyMedicineBtn;
- (IBAction)buyMedicine:(UIButton *)sender;

@end

@implementation DrugStoreTableViewCell

- (void)refrehCell:(ShopInfo*)shopInfo{
    self.shopLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",shopInfo.shopLogo]];
    self.shopNameLabel.text = [NSString stringWithFormat:@"%@",shopInfo.shopName];
    self.shopAdminLabel.text = [NSString stringWithFormat:@"联系人:%@",shopInfo.shopAdmin];
    self.shopPhoneLabel.text = [NSString stringWithFormat:@"电话:%@",shopInfo.shopPhone];
    [self.attentionOrBuyMedicineBtn setTitle:@"预约购药" forState:UIControlStateNormal];
}

- (void)refreshCellForAttention:(ShopInfo*)shopInfo{
    self.shopLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",shopInfo.shopLogo]];
    self.shopNameLabel.text = [NSString stringWithFormat:@"%@",shopInfo.shopName];
    self.shopAdminLabel.text = [NSString stringWithFormat:@"联系人:%@",shopInfo.shopAdmin];
    self.shopPhoneLabel.text = [NSString stringWithFormat:@"电话:%@",shopInfo.shopPhone];
    if (self.attentionOrBuyMedicineBtn.titleLabel.text == nil) {
        if ([shopInfo.userFollowed isEqualToString:@"0"]) {
            [self.attentionOrBuyMedicineBtn setTitle:@"关注" forState:UIControlStateNormal];
        }else{
            [self.attentionOrBuyMedicineBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        }
        
    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buyMedicine:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"预约购药"]) {
        [self.delegate medicineBuy];
    }else if ([sender.titleLabel.text isEqualToString:@"关注"]){
        [sender setTitle:@"取消关注" forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor redColor];
    }else if ([sender.titleLabel.text isEqualToString:@"取消关注"]){
        [sender setTitle:@"关注" forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor greenColor];
    }
        
    
}
@end
