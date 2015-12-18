//
//  OrderBtnTableViewCell.m
//  yylyytv1
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "OrderBtnTableViewCell.h"

@interface OrderBtnTableViewCell ()

@property (weak, nonatomic) IBOutlet UIStepper *numStepper;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
- (IBAction)addNum:(id)sender;

@end

@implementation OrderBtnTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.numStepper.minimumValue = 0;
    self.numStepper.maximumValue = 100;
    self.numStepper.stepValue = 1;
    self.numStepper.value = 0;
    self.numTextField.text = [NSString stringWithFormat:@"%.f",self.numStepper.value];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addNum:(id)sender {
    self.numTextField.text = [NSString stringWithFormat:@"%.f",self.numStepper.value];
}
@end
