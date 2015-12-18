//
//  PromotionDetailTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PromotionDetailTableViewCell.h"
#import "News.h"

@interface PromotionDetailTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;


@end

@implementation PromotionDetailTableViewCell

- (void)refreshCell:(News*)news{
    
    self.shopImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",news.newsPicBar]];
    
    self.namelabel.text = news.shopName;
    
    self.activityLabel.text = news.newsDescribe;
    
  
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
