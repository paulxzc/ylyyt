//
//  NoLoginTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NoLoginTableViewCell.h"

@interface NoLoginTableViewCell ()

@end

@implementation NoLoginTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)loginPop:(id)sender {
    [self.delegate popLogin];
    
}


@end
