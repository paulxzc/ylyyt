//
//  RootTabBarController.m
//  yylyytv1
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomeViewController.h"
#import "DrugstoreViewController.h"
#import "HealthViewController.h"
#import "MedicineViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UIImage *normalImageHome = [[UIImage imageNamed:@"首页on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImageHome = [[UIImage imageNamed:@"首页.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:normalImageHome selectedImage:selectImageHome];
    [viewControllers addObject:homeNav];
    
    DrugstoreViewController *drugstoreVC = [[DrugstoreViewController alloc] initWithNibName:@"DrugstoreViewController" bundle:nil];
    UINavigationController *drugstoreNav = [[UINavigationController alloc] initWithRootViewController:drugstoreVC];
    UIImage *normalImageDrugstore = [[UIImage imageNamed:@"加盟药店on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImageDrugstore = [[UIImage imageNamed:@"加盟药店.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    drugstoreNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"关注药店" image:normalImageDrugstore selectedImage:selectImageDrugstore];
    [viewControllers addObject:drugstoreNav];
    
    MedicineViewController *medicineVC = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController" bundle:nil];
    UINavigationController *medicineNav = [[UINavigationController alloc] initWithRootViewController:medicineVC];
    UIImage *normalImageMedicine = [[UIImage imageNamed:@"药店模版on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImageMedicine = [[UIImage imageNamed:@"药店模版.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    medicineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类药品" image:normalImageMedicine selectedImage:selectImageMedicine];
    [viewControllers addObject:medicineNav];
    
    HealthViewController *healthVC = [[HealthViewController alloc] initWithNibName:@"HealthViewController" bundle:nil];
    UINavigationController *healthNav = [[UINavigationController alloc] initWithRootViewController:healthVC];
    UIImage *normalImageHealth = [[UIImage imageNamed:@"健康档案on.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImageHealth = [[UIImage imageNamed:@"健康档案.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    healthNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:normalImageHealth selectedImage:selectImageHealth];
    [viewControllers addObject:healthNav];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
     [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    self.viewControllers = viewControllers;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0]];
    
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
