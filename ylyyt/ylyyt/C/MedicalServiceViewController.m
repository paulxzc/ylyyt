//
//  MedicalServiceViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicalServiceViewController.h"
#import "SymptomClassifyTableViewCell.h"
#import "TipsViewController.h"
#import "SymptomDetailViewController.h"

@interface MedicalServiceViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating,pushToSymptomDetailDelegate>

@property (nonatomic, strong) UISearchController *searchC;

@end

@implementation MedicalServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"症状分类";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"用药注意" style:UIBarButtonItemStylePlain target:self action:@selector(pushToTips)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIHGT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    
    _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchC.searchResultsUpdater = self;
    _searchC.dimsBackgroundDuringPresentation = NO;
    _searchC.hidesNavigationBarDuringPresentation = NO;
    _searchC.searchBar.placeholder=@"请输入疾病名称";
    _searchC.searchBar.frame = CGRectMake(_searchC.searchBar.frame.origin.x, _searchC.searchBar.frame.origin.y, SCREEN_WIDTH-40, 44.0);
    _searchC.searchBar.backgroundColor = [UIColor clearColor];
    _searchC.searchBar.delegate = self;
    tableView.tableHeaderView = _searchC.searchBar;
    
    UINib *symptomClassifyNib = [UINib nibWithNibName:@"SymptomClassifyTableViewCell" bundle:nil];
    [tableView registerNib:symptomClassifyNib forCellReuseIdentifier:@"SymptomClassifyTableViewCell" ];
    
}

#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SymptomClassifyTableViewCell *symptomClassifyCell = [tableView dequeueReusableCellWithIdentifier:@"SymptomClassifyTableViewCell"];
    symptomClassifyCell.backgroundColor = [UIColor whiteColor];
    symptomClassifyCell.delegate = self;
    return symptomClassifyCell;
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT-44;
}

#pragma mark --UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [_searchC.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
}
#pragma mark--UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //    [searchBar removeFromSuperview];
    
    
}

- (void)pushToTips{
    TipsViewController *tipsVC = [[TipsViewController alloc] init];
    [self.navigationController pushViewController:tipsVC animated:YES];
}

#pragma mark --pushToSymptomDetailDelegate
- (void)pushToSymptomDetail:(NSInteger)btn{
    SymptomDetailViewController *symptomDetailVC = [[SymptomDetailViewController alloc] init];
    [self.navigationController pushViewController:symptomDetailVC animated:YES];
}

@end
