//
//  OrderViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "OrderViewController.h"
#import "PersonTableViewCell.h"
#import "MedicineInfoTableViewCell.h"
#import "OrderBtnTableViewCell.h"
#import "ShopCarViewController.h"
#import "ReturnDataItemShow.h"

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation OrderViewController


- (void)refreshVC:(ReturnDataItemShow *)returnDataItemShow{
    self.navigationItem.title = @"订购商品";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UINib *personNib = [UINib nibWithNibName:@"PersonTableViewCell" bundle:nil];
    [tableView registerNib:personNib forCellReuseIdentifier:@"PersonTableViewCell"];
    UINib *medicineInfoNib = [UINib nibWithNibName:@"MedicineInfoTableViewCell" bundle:nil];
    [tableView registerNib:medicineInfoNib forCellReuseIdentifier:@"MedicineInfoTableViewCell"];
    UINib *orderBtnNib = [UINib nibWithNibName:@"OrderBtnTableViewCell" bundle:nil];
    [tableView registerNib:orderBtnNib forCellReuseIdentifier:@"OrderBtnTableViewCell"];
    
    UIButton *shopCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.9*SCREEN_WIDTH, 0.65*SCREEN_HEIGHT, 0.1*SCREEN_WIDTH, 0.1*SCREEN_WIDTH)];
    shopCarBtn.backgroundColor = [UIColor greenColor];
    [shopCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [shopCarBtn addTarget:self action:@selector(pushToShopCar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCarBtn];
    
    _returnDataItemShow = returnDataItemShow;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

                        
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PersonTableViewCell *personCell = [tableView dequeueReusableCellWithIdentifier:@"PersonTableViewCell"];
        return personCell;
    }else if (indexPath.row == 1){
        MedicineInfoTableViewCell *medicineInfoCell = [tableView dequeueReusableCellWithIdentifier:@"MedicineInfoTableViewCell"];
        [medicineInfoCell refreshCell:_returnDataItemShow];
        return medicineInfoCell;
    }else{
        OrderBtnTableViewCell *orderBtnCell = [tableView dequeueReusableCellWithIdentifier:@"OrderBtnTableViewCell"];
        return orderBtnCell;
    }
    }

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 0.15*SCREEN_HEIGHT;

    }else if (indexPath.row == 1){
        return 0.42*SCREEN_HEIGHT;
    }
    return 0.24*SCREEN_HEIGHT;
}

- (void)pushToShopCar{
    ShopCarViewController *shopCarVC = [[ShopCarViewController alloc] init];
    [self.navigationController pushViewController:shopCarVC animated:YES];
}


@end
