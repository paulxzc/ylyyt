//
//  OrderViewController.h
//  yylyytv1
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReturnDataItemShow.h"

@interface OrderViewController : UIViewController


@property (nonatomic, copy) ReturnDataItemShow *returnDataItemShow;

- (void)refreshVC:(ReturnDataItemShow *)returnDataItemShow;

@end
