//
//  OrderListTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import "OrderListItem.h"

@interface OrderListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;

@property (weak, nonatomic) IBOutlet UIImageView *medicineImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *canDiLabel;
@property (weak, nonatomic) IBOutlet UILabel *guiGeLabel;
@property (weak, nonatomic) IBOutlet UILabel *danWeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *piHaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *shengChanRiQiLabel;
@property (weak, nonatomic) IBOutlet UILabel *youXiaoQi;
@property (weak, nonatomic) IBOutlet UILabel *kuCunLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;


@end

@implementation OrderListTableViewCell

- (void)refreshCell:(OrderListItem*)orderListItem{
    self.shopLabel.text = [NSString stringWithFormat:@"%@",orderListItem.shopName];
    self.medicineImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",orderListItem.imageName]];
    self.tagLabel.text = orderListItem.itemTag;
    self.nameLabel.text = [NSString stringWithFormat:@"%@",orderListItem.PinMing];
    self.canDiLabel.text = [NSString stringWithFormat:@"产地:%@",orderListItem.CanDi];
    self.guiGeLabel.text = [NSString stringWithFormat:@"规格:%@",orderListItem.GuiGe];
    self.danWeiLabel.text = [NSString stringWithFormat:@"单位:%@",orderListItem.DanWei];
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@",orderListItem.JiaGe];
    self.piHaoLabel.text = [NSString stringWithFormat:@"批号:%@",orderListItem.PiHao];
    self.shengChanRiQiLabel.text = [NSString stringWithFormat:@"生产日期:%@",orderListItem.ShengChanRiQi];
    self.youXiaoQi.text = [NSString stringWithFormat:@"有效期:%@",orderListItem.YouXiaoQi];
    self.kuCunLabel.text = [NSString stringWithFormat:@"库存:%@",orderListItem.KuChun];
    self.numLabel.text = @"订购数量:";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
