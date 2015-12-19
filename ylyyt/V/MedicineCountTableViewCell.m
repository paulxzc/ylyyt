//
//  MedicineCountTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineCountTableViewCell.h"

@interface MedicineCountTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (nonatomic, assign) NSInteger count;
- (IBAction)addNum:(id)sender;
- (IBAction)multiNum:(id)sender;
- (IBAction)orderFinish:(id)sender;

@end


@implementation MedicineCountTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.count = 0;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addNum:(id)sender {
    self.count++;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.count];
}

- (IBAction)multiNum:(id)sender {
    if (self.count > 0) {
        self.count--;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.count];
}

- (IBAction)orderFinish:(id)sender {
    [self.delegate pushToOrderFinishVC:self.count];
}
@end
