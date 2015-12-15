//
//  TipsViewController.m
//  ylyyt
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "TipsViewController.h"

@interface TipsViewController ()

@end

@implementation TipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用药注意";
    UIImageView *tipsView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT)];
    tipsView.image = [UIImage imageNamed:@"app裕林温馨提示.jpg"];
    [self.view addSubview:tipsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
