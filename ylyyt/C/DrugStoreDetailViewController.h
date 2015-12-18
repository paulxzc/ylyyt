//
//  DrugStoreDetailViewController.h
//  yylyytv1
//
//  Created by apple on 15/10/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopInfo;

@interface DrugStoreDetailViewController : UIViewController

@property (nonatomic, copy) NSString *drugStoreName;

- (void)refreshVC:(ShopInfo *)shopInfo;

@end
