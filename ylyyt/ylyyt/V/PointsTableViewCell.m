//
//  PointsTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PointsTableViewCell.h"
#import "PointList.h"
@interface PointsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *minPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *resetPointLabel;

@end

@implementation PointsTableViewCell

- (void)refreshCell:(PointList *)pointList{
    self.shopLogoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",pointList.shopLogo]];
    self.totalPointLabel.text = [NSString stringWithFormat:@"获得积分:%@",pointList.totalPoint];
    self.minPointLabel.text = [NSString stringWithFormat:@"抵消积分:%@",pointList.minPoint];
    self.resetPointLabel.text = [NSString stringWithFormat:@"剩余积分:%@",pointList.restPoint];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
