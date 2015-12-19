//
//  SlideBarCell.m
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/30.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "SlideBarCell.h"
#import "ReturnDataItemShow.h"
#import "MedicineItemDetail.h"
#import "ShopInfoForItemShow.h"

@interface SlideBarCell ()

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (nonatomic, assign) NSInteger count;

- (IBAction)addNum:(id)sender;

- (IBAction)multiNum:(id)sender;

@end

@implementation SlideBarCell

- (void)refreshCell:(ShopInfoForItemShow *)shopInfoForItemShow{
    self.shopNameLabel.text = [NSString stringWithFormat:@"%@",shopInfoForItemShow.shopName];
    self.priceLabel.text = [NSString stringWithFormat:@"¥:%@",shopInfoForItemShow.itemPrice];
    _count = 0;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",_count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addNum:(id)sender {
    _count++;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",_count];
}

- (IBAction)multiNum:(id)sender {
    if (_count > 0) {
        _count--;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",_count];
}
@end
