//
//  HomeViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerTableViewCell.h"
#import "BtnTableViewCell.h"
#import "PromotionTableViewCell.h"
#import "MedicineTableViewCell.h"
#import "LoginViewController.h"
#import "MedicalServiceViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "Banner.h"
#import "MainPage.h"
#import "Menu.h"
#import "News.h"
#import "HotItem.h"
#import "DrugStoreDetailViewController.h"
#import "Medicine-DrugStoreViewController.h"
#import "AddAttentionViewController.h"
#import "PointsViewController.h"
#import "PromotionViewController.h"
#import "DrugstoreViewController.h"
#import "BannerViewController.h"


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,btnDelegate,NSXMLParserDelegate,pushToDrugStoreDelegate,pushToMedicineDelegate,pushBannerDelegate>
{
    MainPage *_mainPages;
}

@property (nonatomic, strong)NSMutableDictionary *mainPage;
@property (nonatomic, strong)NSMutableArray *banner;
@property (nonatomic, strong)NSMutableArray *menu;
@property (nonatomic, strong)NSMutableArray *news;
@property (nonatomic, strong)NSMutableArray *hotItem;


@property (nonatomic, strong) NSMutableDictionary *bannerDic;
@property (nonatomic, copy)  NSString *bannerText;
@property (nonatomic, copy) NSString *bannerElementName;

@property (nonatomic, strong) NSMutableDictionary *menuDic;
@property (nonatomic, copy)  NSString *menuText;
@property (nonatomic, copy) NSString *menuElementName;

@property (nonatomic, strong) NSMutableDictionary *newsDic;
@property (nonatomic, copy)  NSString *newsText;
@property (nonatomic, copy) NSString *newsElementName;

@property (nonatomic, strong) NSMutableDictionary *hotItemDic;
@property (nonatomic, copy)  NSString *hotItemText;
@property (nonatomic, copy) NSString *hotItemElementName;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    UIBarButtonItem *replyItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    NSArray *itemsArr = @[addItem,replyItem];
    self.navigationItem.rightBarButtonItems = itemsArr;
    
    
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 200, 50)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:18.0]];
    [titleText setText:@"裕林医药通"];
    self.navigationItem.titleView=titleText;
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo32.png"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoImageView];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
#pragma mark --搭建UI
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
#pragma mark --注册cell
    UINib *bannerNib = [UINib nibWithNibName:@"BannerTableViewCell" bundle:nil];
    [tableView registerNib:bannerNib forCellReuseIdentifier:@"BannerTableViewCell"];
    UINib *btnNib = [UINib nibWithNibName:@"BtnTableViewCell" bundle:nil];
    [tableView registerNib:btnNib forCellReuseIdentifier:@"BtnTableViewCell"];
    UINib *proNib = [UINib nibWithNibName:@"PromotionTableViewCell" bundle:nil];
    [tableView registerNib:proNib forCellReuseIdentifier:@"PromotionTableViewCell"];
    UINib *medNib = [UINib nibWithNibName:@"MedicineTableViewCell" bundle:nil];
    [tableView registerNib:medNib forCellReuseIdentifier:@"MedicineTableViewCell"];
    
#pragma mark --下载数据
    self.mainPage = [[NSMutableDictionary alloc] init];
    self.banner = [[NSMutableArray alloc] init];
    self.menu = [[NSMutableArray alloc] init];
    self.news = [[NSMutableArray alloc] init];
    self.hotItem = [[NSMutableArray alloc] init];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://adobeflash.duapp.com/appYulin/xmlAPI/api_homepage.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        responseObject.delegate = (id<NSXMLParserDelegate>)self;
        [responseObject parse];
        _mainPages = [MainPage mainPageWithDic:self.mainPage];
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BannerTableViewCell *bannerCell = [tableView dequeueReusableCellWithIdentifier:@"BannerTableViewCell"];
        bannerCell.backgroundColor = [UIColor whiteColor];
        bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        bannerCell.delegate = self;
        [bannerCell refreshCell:_mainPages];
        return bannerCell;
    }else if (indexPath.row == 1){
        BtnTableViewCell *btnCell = [tableView dequeueReusableCellWithIdentifier:@"BtnTableViewCell"];
        btnCell.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
        btnCell.selectionStyle = UITableViewCellSelectionStyleNone;
        btnCell.delegate = self;
        [btnCell refreshCell:_mainPages];
        return btnCell;
    }else if (indexPath.row == 2){
        PromotionTableViewCell *proCell = [tableView dequeueReusableCellWithIdentifier:@"PromotionTableViewCell"];
        proCell.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
        proCell.selectionStyle = UITableViewCellSelectionStyleNone;
        proCell.delegate = self;
        [proCell refreshCell:_mainPages];
        return proCell;
    }else if (indexPath.row == 3){
        MedicineTableViewCell *medCell = [tableView dequeueReusableCellWithIdentifier:@"MedicineTableViewCell"];
        medCell.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
        medCell.selectionStyle = UITableViewCellSelectionStyleNone;
        medCell.delegate = self;
        [medCell refreshCell:_mainPages];
        return medCell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    

}



#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 0.35*SCREEN_HEIGHT;
    }else if (indexPath.row == 1){
        return 0.18*SCREEN_HEIGHT;
    }else if (indexPath.row == 2){
        return 0.62*SCREEN_HEIGHT;
    }else{
        return 0.61*SCREEN_HEIGHT;
    }
    
}

#pragma mark --btnDelegate
- (void)btnFunction:(NSInteger)selectedBtn{
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = returnItem;
    if (selectedBtn == 0) {
        AddAttentionViewController *addAttentionVC = [[AddAttentionViewController alloc] init];
        [self.navigationController pushViewController:addAttentionVC animated:YES];
    }else if (selectedBtn == 1) {
        DrugstoreViewController *drugStoreVC = [[DrugstoreViewController alloc] init];
        drugStoreVC.tag = 1;
        [self.navigationController pushViewController:drugStoreVC animated:YES];
    }else if (selectedBtn == 2) {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
        PointsViewController *pointsVC = [[PointsViewController alloc] init];
        [self.navigationController pushViewController:pointsVC animated:YES];
    }else if (selectedBtn == 3) {
        MedicalServiceViewController *medicalServiceVC = [[MedicalServiceViewController alloc] init];
        [self.navigationController pushViewController:medicalServiceVC animated:YES];
    }
}

#pragma mark --NSXMLParserDelegate
//step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );

    self.bannerDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.menuDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.newsDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.hotItemDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
    
    self.bannerText = [[NSString alloc] init];
    if ([elementName isEqualToString:@"banner"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        self.bannerDic = newNode;
        
//        [self.mainPage addObject :newNode];
    }else if(self.bannerDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        [self.bannerDic setObject :string forKey :elementName];
        self.bannerElementName = elementName;
    }
    
    self.menuText = [[NSString alloc] init];
    if ([elementName isEqualToString:@"menu"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        self.menuDic = newNode;

//        [self.mainPage addObject :newNode];
    }else if(self.menuDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        [self.menuDic setObject :string forKey :elementName];
        self.menuElementName = elementName;
    }
    
    self.newsText = [[NSString alloc] init];
    if ([elementName isEqualToString:@"news"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        self.newsDic = newNode;
        
//        [self.mainPage addObject :newNode];
    }else if(self.newsDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        [self.newsDic setObject :string forKey :elementName];
        self.newsElementName = elementName;
    }
    
    self.hotItemText = [[NSString alloc] init];
    if ([elementName isEqualToString:@"hotItem"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        self.hotItemDic = newNode;
//        [self.mainPage addObject:newNode];
    }else if(self.hotItemDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        [self.hotItemDic setObject :string forKey :elementName];
        self.hotItemElementName = elementName;
    }

    
    
}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
//    NSLog(@"%@",NSStringFromSelector(_cmd) );
//    [self.currentText appendString:string];
    
    self.bannerText = [self.bannerText stringByAppendingString:string];
    self.menuText = [self.menuText stringByAppendingString:string];
    self.newsText = [self.newsText stringByAppendingString:string];
    self.hotItemText = [self.hotItemText stringByAppendingString:string];
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    

    if ([elementName isEqualToString:@"banner"]) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tempDic addEntriesFromDictionary:self.bannerDic];
        [self.banner addObject:tempDic];
        self.bannerDic = nil;
    }else if ([elementName isEqualToString:self.bannerElementName]) {
            
//            if ([elementName isEqualToString:@"description"]
//                ||[elementName isEqualToString:@"content:encoded"]) {
//                [twitterDic setObject:Cdata forKey:currentElementName];
//            }else {
                [self.bannerDic setObject:self.bannerText forKey:self.bannerElementName];
        
//            }
        }
    if ([elementName isEqualToString:@"menu"]) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tempDic addEntriesFromDictionary:self.menuDic];
        [self.menu addObject:tempDic];
        self.menuDic = nil;
    }else if ([elementName isEqualToString:self.menuElementName]){
        [self.menuDic setObject:self.menuText forKey:self.menuElementName];
    }
    if ([elementName isEqualToString:@"news"]) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tempDic addEntriesFromDictionary:self.newsDic];
        [self.news addObject:tempDic];
        self.newsDic = nil;
    }else if ([elementName isEqualToString:self.newsElementName]){
        [self.newsDic setObject:self.newsText forKey:self.newsElementName];
    }
    if ([elementName isEqualToString:@"hotItem"]) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tempDic addEntriesFromDictionary:self.hotItemDic];
        [self.hotItem addObject:tempDic];
        self.hotItemDic = nil;
    }else if ([elementName isEqualToString:self.hotItemElementName]){
        [self.hotItemDic setObject:self.hotItemText forKey:self.hotItemElementName];
    }
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.mainPage setObject:self.banner forKey:@"banner"];
    [self.mainPage setObject:self.menu forKey:@"menu"];
    [self.mainPage setObject:self.news forKey:@"news"];
    [self.mainPage setObject:self.hotItem forKey:@"hotItem"];
//    NSLog(@"%@",self.mainPage);
//    NSLog(@"%@",self.banner);
    
}

#pragma mark --pushToDrugStoreDelegate

- (void)pushToDrugStore:(NSString *)linkUrl{
    PromotionViewController *promotionVC = [[PromotionViewController alloc] init];
    [promotionVC refreshVC:linkUrl];
    [self.navigationController pushViewController:promotionVC animated:YES];
}

#pragma mark --pushToMedicineDelegate
- (void)pushToMedicine:(NSString *)medicineName{
    Medicine_DrugStoreViewController *medicineDrugStoreVC = [[Medicine_DrugStoreViewController alloc] init];
    [self.navigationController pushViewController:medicineDrugStoreVC animated:YES];
}

#pragma mark --pushBannerDelegate
- (void)pushBanner:(NSString *)linkUrl{
    BannerViewController *bannerVC = [[BannerViewController alloc] init];
    [bannerVC refreshVC:linkUrl];
    [self.navigationController pushViewController:bannerVC animated:YES];
}
@end
