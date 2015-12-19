//
//  MedicineDetailTableViewCell.m
//  yylyytv1
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineDetailTableViewCell.h"
#import "MedicineItem.h"
#import "ReturnData.h"
#import "ReturnDataItemShow.h"
#import "MedicineItemDetail.h"

@interface MedicineDetailTableViewCell ()
{
    MedicineItem *_medicineItem;
}
@property (weak, nonatomic) IBOutlet UIImageView *medicineImageView;
@property (weak, nonatomic) IBOutlet UILabel *pinMingLabel;
@property (weak, nonatomic) IBOutlet UILabel *canDiLabel;
@property (weak, nonatomic) IBOutlet UILabel *guiGeLabel;
@property (weak, nonatomic) IBOutlet UILabel *danWeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiaGeLabel;
@property (weak, nonatomic) IBOutlet UILabel *piHaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *shengCanRiQiLabel;
@property (weak, nonatomic) IBOutlet UILabel *youXiaoQiLabel;
@property (weak, nonatomic) IBOutlet UILabel *kuCunLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;
- (IBAction)order:(id)sender;

@end


@implementation MedicineDetailTableViewCell


- (void)refreshCell:(MedicineItem*)medicineItem{
//    for (int i = 0; i < returnData.it.count; i++) {
//        MedicineItem *medicineItem = returnData.it[i];
    _medicineItem = medicineItem;
        self.medicineImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",medicineItem.imageName]];
        self.pinMingLabel.text = [NSString stringWithFormat:@"%@",medicineItem.PinMing];
        self.canDiLabel.text = [NSString stringWithFormat:@"产地:%@",medicineItem.CanDi];
        self.guiGeLabel.text = [NSString stringWithFormat:@"规格:%@",medicineItem.GuiGe];
        self.danWeiLabel.text = [NSString stringWithFormat:@"单位:%@",medicineItem.DanWei];
        self.jiaGeLabel.text = [NSString stringWithFormat:@"价格:%@",medicineItem.JiaGe];
        self.piHaoLabel.text = [NSString stringWithFormat:@"批号:%@",medicineItem.PiHao];
        self.shengCanRiQiLabel.text = [NSString stringWithFormat:@"生产日期:%@",medicineItem.ShengChanRiQi];
        self.youXiaoQiLabel.text = [NSString stringWithFormat:@"有效期:%@",medicineItem.YouXiaoQi];
        self.kuCunLabel.text = [NSString stringWithFormat:@"库存:%@",medicineItem.KuChun];
    self.shopLabel.text = [NSString stringWithFormat:@"经销药店:%@",medicineItem.shopName];
//    }
    [self.orderBtn setTitle:@"订购" forState:UIControlStateNormal];
    
}

- (void)refreshCellForItem:(ReturnDataItemShow *)returnDataItemShow{
    for (int i = 0; i < returnDataItemShow.it.count; i++) {
        MedicineItemDetail *medicineItemDetail = returnDataItemShow.it[i];
        self.medicineImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",medicineItemDetail.imageName]];
        self.pinMingLabel.text = [NSString stringWithFormat:@"%@",medicineItemDetail.PinMing];
        self.canDiLabel.text = [NSString stringWithFormat:@"产地:%@",medicineItemDetail.CanDi];
        self.guiGeLabel.text = [NSString stringWithFormat:@"规格:%@",medicineItemDetail.GuiGe];
        self.danWeiLabel.text = [NSString stringWithFormat:@"单位:%@",medicineItemDetail.DanWei];
        self.jiaGeLabel.text = [NSString stringWithFormat:@"价格:%@",medicineItemDetail.JiaGe];
        self.piHaoLabel.text = [NSString stringWithFormat:@"批号:%@",medicineItemDetail.PiHao];
        self.shengCanRiQiLabel.text = [NSString stringWithFormat:@"生产日期:%@",medicineItemDetail.ShengChanRiQi];
        self.youXiaoQiLabel.text = [NSString stringWithFormat:@"有效期:%@",medicineItemDetail.YouXiaoQi];
        self.kuCunLabel.text = [NSString stringWithFormat:@"库存:%@",medicineItemDetail.KuChun];
        self.shopLabel.text = [NSString stringWithFormat:@"经销药店:%@",medicineItemDetail.shopName];
    }
    self.orderBtn.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)order:(id)sender {
    [self.delegate pushToOrder:_medicineItem];
}
@end
