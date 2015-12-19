//
//  MedicineDetailViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/23.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineDetailViewController.h"
#import "MedicineDetailTableViewCell.h"
#import "MedicineShowViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "MedicineItem.h"
#import "Medicine-DrugStoreViewController.h"
#import "JKAlertDialog.h"
#import "LoginViewController.h"
#import "OrderFinishViewController.h"

@interface MedicineDetailViewController ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UISearchResultsUpdating,UISearchBarDelegate,orderDelegate>
{
    MedicineItem *_medicineItem;
}

@property (nonatomic, strong)NSMutableArray *returnData;

@property (nonatomic, strong) UISearchController *searchC;

@property (nonatomic, strong) NSMutableDictionary *itemDic;
@property (nonatomic, copy)  NSString *itemText;
@property (nonatomic, copy) NSString *itemElementName;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation MedicineDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.title = @"药品列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UITableView *tableView = [[UITableView alloc] init];
    //    self.tableView.backgroundColor = [UIColor redColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT);
    [self.view addSubview:tableView];
    
    _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchC.searchResultsUpdater = self;
    _searchC.dimsBackgroundDuringPresentation = NO;
    _searchC.hidesNavigationBarDuringPresentation = NO;
    _searchC.searchBar.placeholder=@"请输入药品或症状";
    _searchC.searchBar.frame = CGRectMake(_searchC.searchBar.frame.origin.x, _searchC.searchBar.frame.origin.y, _searchC.searchBar.frame.size.width, 44.0);
    _searchC.searchBar.backgroundColor = [UIColor clearColor];
    _searchC.searchBar.delegate = self;
    tableView.tableHeaderView = _searchC.searchBar;
    
    UINib *medicineDetailNib = [UINib nibWithNibName:@"MedicineDetailTableViewCell" bundle:nil];
    [tableView registerNib:medicineDetailNib forCellReuseIdentifier:@"MedicineDetailTableViewCell"];
    
    self.returnData = [[NSMutableArray alloc] initWithCapacity:0];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://adobeflash.duapp.com/appYulin/xmlAPI/api_itemList.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        responseObject.delegate = (id<NSXMLParserDelegate>)self;
        [responseObject parse];
        [tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.returnData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _medicineItem = [MedicineItem medicineItemWithDic:self.returnData[indexPath.row]];
    MedicineDetailTableViewCell *medicineDetailcell = [tableView dequeueReusableCellWithIdentifier:@"MedicineDetailTableViewCell"];
    medicineDetailcell.delegate = self;
    [medicineDetailcell refreshCell:_medicineItem];
    return medicineDetailcell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.2*SCREEN_HEIGHT;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    Medicine_DrugStoreViewController *medicine_DrugStoreVC = [[Medicine_DrugStoreViewController alloc] init];
//    [self.navigationController pushViewController:medicine_DrugStoreVC animated:YES];
//}

#pragma mark --orderDelegate
- (void)pushToOrder:(MedicineItem*)medicineItem{
//    Medicine_DrugStoreViewController *medicine_DrugStoreVC = [[Medicine_DrugStoreViewController alloc] init];
//    [self.navigationController pushViewController:medicine_DrugStoreVC animated:YES];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择数量" message:@"订单信息" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    [alert addAction:OKAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
    
    JKAlertDialog *alert = [[JKAlertDialog alloc] initWithTitle:@"选择数量" message:@"订单信息"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AlertWidth, 0.6*SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor greenColor];
    
    UIImageView *medicineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 0.25*AlertWidth, 0.3*SCREEN_HEIGHT)];
    medicineImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",medicineItem.imageName]];
    [view addSubview:medicineImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.25*AlertWidth+10, 5, 0.3*AlertWidth, 0.06*SCREEN_HEIGHT)];
    nameLabel.backgroundColor = [UIColor redColor];
    nameLabel.text = [NSString stringWithFormat:@"%@",medicineItem.PinMing];
    nameLabel.font = [UIFont boldSystemFontOfSize:13];
    [view addSubview:nameLabel];
    
    UILabel *kuCunLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.55*AlertWidth+12, 5, 0.4*AlertWidth, 0.06*SCREEN_HEIGHT)];
    kuCunLabel.backgroundColor = [UIColor redColor];
    kuCunLabel.text = [NSString stringWithFormat:@"库存:%@",medicineItem.KuChun];
    kuCunLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:kuCunLabel];
    
    UILabel *chanDiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.25*AlertWidth+10, 0.06*SCREEN_HEIGHT+10, 0.3*AlertWidth, 0.06*SCREEN_HEIGHT)];
    chanDiLabel.backgroundColor = [UIColor redColor];
    chanDiLabel.text = [NSString stringWithFormat:@"产地:%@",medicineItem.CanDi];
    chanDiLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:chanDiLabel];
    
    UILabel *piHaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.55*AlertWidth+12, 0.06*SCREEN_HEIGHT+10, 0.4*AlertWidth, 0.06*SCREEN_HEIGHT)];
    piHaoLabel.backgroundColor = [UIColor redColor];
    piHaoLabel.text = [NSString stringWithFormat:@"批号:%@",medicineItem.PiHao];
    piHaoLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:piHaoLabel];
    
    UILabel *guiGeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.25*AlertWidth+10, 0.12*SCREEN_HEIGHT+15, 0.3*AlertWidth, 0.06*SCREEN_HEIGHT)];
    guiGeLabel.backgroundColor = [UIColor redColor];
    guiGeLabel.text = [NSString stringWithFormat:@"规格:%@",medicineItem.GuiGe];
    guiGeLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:guiGeLabel];
    
    UILabel *shengChanRiQiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.55*AlertWidth+12, 0.12*SCREEN_HEIGHT+15, 0.4*AlertWidth, 0.06*SCREEN_HEIGHT)];
    shengChanRiQiLabel.backgroundColor = [UIColor redColor];
    shengChanRiQiLabel.text = [NSString stringWithFormat:@"生产日期:%@",medicineItem.ShengChanRiQi];
    shengChanRiQiLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:shengChanRiQiLabel];
    
    UILabel *danWeiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.25*AlertWidth+10, 0.18*SCREEN_HEIGHT+20, 0.3*AlertWidth, 0.06*SCREEN_HEIGHT)];
    danWeiLabel.backgroundColor = [UIColor redColor];
    danWeiLabel.text = [NSString stringWithFormat:@"单位:%@",medicineItem.DanWei];
    danWeiLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:danWeiLabel];
    
    UILabel *youXiaoQiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.55*AlertWidth+12, 0.18*SCREEN_HEIGHT+20, 0.4*AlertWidth, 0.06*SCREEN_HEIGHT)];
    youXiaoQiLabel.backgroundColor = [UIColor redColor];
    youXiaoQiLabel.text = [NSString stringWithFormat:@"有效期:%@",medicineItem.YouXiaoQi];
    youXiaoQiLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:youXiaoQiLabel];
    
    UILabel *jiaGeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.25*AlertWidth+10, 0.24*SCREEN_HEIGHT+25, 0.3*AlertWidth, 0.06*SCREEN_HEIGHT)];
    jiaGeLabel.backgroundColor = [UIColor redColor];
    jiaGeLabel.text = [NSString stringWithFormat:@"价格:%@",medicineItem.JiaGe];
    jiaGeLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:jiaGeLabel];
    
    UILabel *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.55*AlertWidth+12, 0.24*SCREEN_HEIGHT+25, 0.4*AlertWidth, 0.06*SCREEN_HEIGHT)];
    shopLabel.backgroundColor = [UIColor redColor];
    shopLabel.text = [NSString stringWithFormat:@"经销药店:%@",medicineItem.shopName];
    shopLabel.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:shopLabel];
    
    UIButton *multiBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.1*AlertWidth, 0.4*SCREEN_HEIGHT, 0.15*AlertWidth, 0.15*AlertWidth)];
    multiBtn.backgroundColor = [UIColor redColor];
    [multiBtn setTitle:@"-" forState:UIControlStateNormal];
    [multiBtn addTarget:self action:@selector(multiNum) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:multiBtn];
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.25*AlertWidth, 0.4*SCREEN_HEIGHT, 0.5*AlertWidth, 0.15*AlertWidth)];
    self.numLabel.backgroundColor = [UIColor whiteColor];
    self.count = 0;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.count];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.numLabel];
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.75*AlertWidth, 0.4*SCREEN_HEIGHT, 0.15*AlertWidth, 0.15*AlertWidth)];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setTitle:@"＋" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    
    alert.contentView = view;
    [alert addButtonWithTitle:@"取消"];
    
    [alert addButton:Button_OTHER withTitle:@"确定" handler:^(JKAlertDialogItem *item) {
        NSLog(@"click %@",item.title);
        NSLog(@"%ld",self.count);
        if (self.count == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入订购数量" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *name = [userDefaults objectForKey:@"name"];
        if (name ==nil) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }else{
            OrderFinishViewController *orderFinishVC = [[OrderFinishViewController alloc] init];
            [self.navigationController pushViewController:orderFinishVC animated:YES];
        }

    }];;
    
    
    [alert show];
}

- (void)multiNum{
    if (self.count > 0) {
        self.count--;
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.count];
}

- (void)addNum{
    self.count++;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",self.count];
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

#pragma mark --NSXMLParserDelegate
//step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
    self.itemDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
    
    self.itemText = [[NSString alloc] init];
    if ([elementName isEqualToString:@"item"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        self.itemDic = newNode;
        
                [self.returnData addObject :newNode];
    }else if(self.itemDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        [self.itemDic setObject :string forKey :elementName];
        self.itemElementName = elementName;
    }
    
}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    //    [self.currentText appendString:string];
    
    self.itemText = [self.itemText stringByAppendingString:string];
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
    if ([elementName isEqualToString:@"item"]) {
//        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
//        [tempDic addEntriesFromDictionary:self.itemDic];
//        [self.banner addObject:tempDic];
        self.itemDic = nil;
    }else if ([elementName isEqualToString:self.itemElementName]) {
        
        //            if ([elementName isEqualToString:@"description"]
        //                ||[elementName isEqualToString:@"content:encoded"]) {
        //                [twitterDic setObject:Cdata forKey:currentElementName];
        //            }else {
        [self.itemDic setObject:self.itemText forKey:self.itemElementName];
        
        //            }
    }
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
//    [self.returnData setObject:self.banner forKey:@"banner"];
    
//        NSLog(@"%@",self.returnData);
    //    NSLog(@"%@",self.banner);
    
}


@end
