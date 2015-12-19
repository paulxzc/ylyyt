//
//  NoLoginTableViewCell.h
//  ylyyt
//
//  Created by apple on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loginPopDelegate <NSObject>

- (void)popLogin;

@end



@interface NoLoginTableViewCell : UITableViewCell

@property (nonatomic, retain) id<loginPopDelegate> delegate;


- (IBAction)loginPop:(id)sender;


@end
