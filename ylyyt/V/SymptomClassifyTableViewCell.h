//
//  SymptomClassifyTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pushToSymptomDetailDelegate <NSObject>

- (void)pushToSymptomDetail:(NSInteger)btn;

@end

@interface SymptomClassifyTableViewCell : UITableViewCell

@property (nonatomic,retain) id<pushToSymptomDetailDelegate> delegate;

@end
