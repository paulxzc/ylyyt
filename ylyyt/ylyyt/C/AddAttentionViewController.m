//
//  AddAttentionViewController.m
//  ylyyt
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AddAttentionViewController.h"
#import "DrugStoreTableViewCell.h"
#import "DrugStoreDetailViewController.h"
#import "ScanViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "ShopInfo.h"
#import "TSPopoverController.h"
#import "LoginViewController.h"

@interface AddAttentionViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,UISearchBarDelegate,NSXMLParserDelegate>
{
    ShopInfo *_shopInfos;
}

@property (nonatomic, strong) UISearchController *searchC;

@property (nonatomic, strong)NSMutableArray *returnData;
@property (nonatomic, strong)NSMutableArray *shopInfo;

@property (nonatomic, copy) NSString *shopInfoName;

@property (nonatomic, strong) TSPopoverController *popoverController;

@property (nonatomic, strong) DrugStoreTableViewCell *drugStoreTableViewCell;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AddAttentionViewController

- (void)viewWillAppear:(BOOL)animated;{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginRefresh:) name:@"loginRefresh"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backRefresh:) name:@"backRefresh" object:nil];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.name = [userDefaults objectForKey:@"name"];
    if (self.name == nil) {
        //        LoginViewController *loginVC = [[LoginViewController alloc] init];
        //        [self presentViewController:loginVC animated:YES completion:nil];
       
        [self.tableView removeFromSuperview];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.2*SCREEN_WIDTH, 0.4*SCREEN_HEIGHT, 0.6*SCREEN_WIDTH, 0.1*SCREEN_HEIGHT)];
        label.backgroundColor = [UIColor greenColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"您还未登录";
        [self.view addSubview:label];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0.3*SCREEN_WIDTH, 0.5*SCREEN_HEIGHT+10, 0.4*SCREEN_WIDTH, 0.1*SCREEN_HEIGHT)];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
        [btn addTarget:self action:@selector(pushToLoginVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }else{
        self.navigationItem.title = @"添加关注";
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:@selector(popScanAndNearbyShop:forEvent:)];
        //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫码" style:UIBarButtonItemStylePlain target:self action:@selector(pushToScanVC)];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.tableView];
        
        _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchC.searchResultsUpdater = self;
        _searchC.dimsBackgroundDuringPresentation = NO;
        _searchC.hidesNavigationBarDuringPresentation = NO;
        _searchC.searchBar.placeholder=@"请输入要关注的药店";
        _searchC.searchBar.frame = CGRectMake(_searchC.searchBar.frame.origin.x, _searchC.searchBar.frame.origin.y, SCREEN_WIDTH, 44.0);
        _searchC.searchBar.backgroundColor = [UIColor clearColor];
        _searchC.searchBar.delegate = self;
        self.tableView.tableHeaderView = _searchC.searchBar;
        
        UINib *drugStoreNib = [UINib nibWithNibName:@"DrugStoreTableViewCell" bundle:nil];
        [self.tableView registerNib:drugStoreNib forCellReuseIdentifier:@"DrugStoreTableViewCell"];
        
#pragma mark --下载数据
        self.returnData = [[NSMutableArray alloc] init];
        [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"api_shopList.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
            responseObject.delegate = (id<NSXMLParserDelegate>)self;
            [responseObject parse];
            if (self.name != nil) {
                [self.tableView reloadData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];

    }
    
}

- (void)backRefresh:(NSNotification *)sender{
//    if (self.name == nil) {
        [self.tableView removeFromSuperview];
//    }
}

- (void)loginRefresh:(NSNotification *)sender{
    self.name = sender.object;
}

- (void)pushToLoginVC{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DrugStoreTableViewCell *drugStoreCell = [tableView dequeueReusableCellWithIdentifier:@"DrugStoreTableViewCell"];
    drugStoreCell.selectionStyle = UITableViewCellSelectionStyleNone;
    drugStoreCell.backgroundColor = [UIColor whiteColor];
    self.drugStoreTableViewCell = drugStoreCell;
    _shopInfos = [ShopInfo shopInfoWithDic:self.shopInfo[indexPath.row]];
    [drugStoreCell refreshCellForAttention:_shopInfos];
    return drugStoreCell;
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.15*SCREEN_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = returnItem;
    DrugStoreDetailViewController *drugStoreDetailVC = [[DrugStoreDetailViewController alloc] init];
    _shopInfos = [ShopInfo shopInfoWithDic:self.shopInfo[indexPath.row]];
    drugStoreDetailVC.drugStoreName = _shopInfos.shopName;
    [drugStoreDetailVC refreshVC:_shopInfos];
    [self.navigationController pushViewController:drugStoreDetailVC animated:YES];
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

- (void)popScanAndNearbyShop:(id)sender forEvent:(UIEvent*)event{
    
    UIButton *scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.05*SCREEN_WIDTH, 5, 0.4*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
    [scanBtn setTitle:@"扫码" forState:UIControlStateNormal];
    scanBtn.backgroundColor = [UIColor greenColor];
    [scanBtn addTarget:self action:@selector(pushToScanVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nearbyShopBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.05*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT+10, 0.4*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
    [nearbyShopBtn setTitle:@"附近药店" forState:UIControlStateNormal];
    nearbyShopBtn.backgroundColor = [UIColor greenColor];
    [nearbyShopBtn addTarget:self action:@selector(nearbyShopCheck) forControlEvents:UIControlEventTouchUpInside];
    
    UIViewController *VC = [[UIViewController alloc] init];
    VC.view.frame = CGRectMake(0, 0, 0.5*SCREEN_WIDTH, 0.13*SCREEN_HEIGHT);
    VC.view.backgroundColor = [UIColor whiteColor];
    [VC.view addSubview:scanBtn];
    [VC.view addSubview:nearbyShopBtn];
    self.popoverController = [[TSPopoverController alloc] initWithContentViewController:VC];
    
    self.popoverController.cornerRadius = 5;
    self.popoverController.titleText = @" 扫码&查询附近药店";
    self.popoverController.popoverBaseColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    self.popoverController.popoverGradient= YES;
    self.popoverController.arrowPosition = TSPopoverArrowPositionVertical;
    [self.popoverController showPopoverWithTouch:event];
}

- (void)pushToScanVC{
    [self.popoverController dismissPopoverAnimatd:YES];
    ScanViewController *scanVC = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)nearbyShopCheck{
    
}



#pragma mark --NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析开始！");
    self.shopInfo = [[NSMutableArray alloc] init];
}
//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict{
    if ([@"returnData" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.returnData addObject:tempDic];
        [self.returnData setValue:self.shopInfo forKey:@"shopInfo"];
    }else if ([@"shopInfo" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.shopInfo addObject:tempDic];
    }else{
        self.shopInfoName = elementName;
    }
}
//解析文本节点
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    //将string中的空格和换行去掉
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //如果去掉空格和换行的string等于@"";
    if ([string isEqualToString:@""]) {
        return;
    }
    
    NSMutableDictionary *shopInfoDic = [self.shopInfo lastObject];
    [shopInfoDic setObject:string forKey:self.shopInfoName];
    
    
}
//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    //    NSLog(@"结束标记：%@",elementName);
}
//文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析结束！");
//                NSLog(@"%@",self.returnData);
    //        NSLog(@"%@",self.shopInfo);
    
}

@end
