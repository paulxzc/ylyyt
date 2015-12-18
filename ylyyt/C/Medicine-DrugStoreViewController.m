//
//  Medicine-DrugStoreViewController.m
//  ylyyt
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Medicine-DrugStoreViewController.h"
#import "ExplainViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "MedicineItemDetail.h"
#import "MedicineImage.h"
#import "ReturnDataItemShow.h"
#import "ShopInfoForItemShow.h"
#import "ScrollTableViewCell.h"
#import "MedicineInfoTableViewCell.h"
#import "MedicineCountTableViewCell.h"
#import "ExplainViewController.h"
#import "MedicineDetailTableViewCell.h"
#import "OrderFinishViewController.h"
#import "LoginViewController.h"

@interface Medicine_DrugStoreViewController ()<NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate,orderFinishDelegate>
{
    ReturnDataItemShow *_returnDataItemShow;
    MedicineItemDetail *_medicineItemDetail;
    MedicineImage *_medicineImage;
    ShopInfoForItemShow *_shopInfoForItemShow;
}


@property (nonatomic, strong)NSMutableDictionary *returnData;
@property (nonatomic, strong)NSMutableArray *item;
@property (nonatomic, strong)NSMutableArray *image;

@property (nonatomic, strong) NSMutableDictionary *itemDic;
@property (nonatomic, copy)  NSString *itemText;
@property (nonatomic, copy) NSString *itemElementName;

@property (nonatomic, strong) NSMutableDictionary *imageDic;
@property (nonatomic, copy)  NSString *imageText;
@property (nonatomic, copy) NSString *imageElementName;

@end

@implementation Medicine_DrugStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.title = @"药品详情";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStylePlain target:self action:@selector(pushToExplain)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UINib *scrollNib = [UINib nibWithNibName:@"ScrollTableViewCell" bundle:nil];
    [tableView registerNib:scrollNib forCellReuseIdentifier:@"ScrollTableViewCell"];
    UINib *medicineInfoNib = [UINib nibWithNibName:@"MedicineDetailTableViewCell" bundle:nil];
    [tableView registerNib:medicineInfoNib forCellReuseIdentifier:@"MedicineDetailTableViewCell"];
    UINib *medicineCountNib = [UINib nibWithNibName:@"MedicineCountTableViewCell" bundle:nil];
    [tableView registerNib:medicineCountNib forCellReuseIdentifier:@"MedicineCountTableViewCell"];
    
    self.returnData = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.item = [[NSMutableArray alloc] initWithCapacity:0];
    self.image = [[NSMutableArray alloc] initWithCapacity:0];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://adobeflash.duapp.com/appYulin/xmlAPI/api_itemShow.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        responseObject.delegate = (id<NSXMLParserDelegate>)self;
        [responseObject parse];
        _returnDataItemShow = [ReturnDataItemShow returnDataItemShowWithDic:self.returnData];
        _medicineItemDetail = _returnDataItemShow.it[0];
        [tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];

   
    
//    _tabCount = 2;
//    [self initSlideWithCount:_tabCount];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.item.count*3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ScrollTableViewCell *scrollCell = [tableView dequeueReusableCellWithIdentifier:@"ScrollTableViewCell"];
        [scrollCell refreshCell:_returnDataItemShow];
        return scrollCell;
    }else if (indexPath.row == 1){
        MedicineDetailTableViewCell *medicineDetailCell = [tableView dequeueReusableCellWithIdentifier:@"MedicineDetailTableViewCell"];
        [medicineDetailCell refreshCellForItem:_returnDataItemShow];
        return medicineDetailCell;
    }else{
        MedicineCountTableViewCell *medicineCountCell = [tableView dequeueReusableCellWithIdentifier:@"MedicineCountTableViewCell"];
//        [medicinCou refreshCell:_returnDataItemShow];
        medicineCountCell.delegate = self;
        return medicineCountCell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 0.5*SCREEN_HEIGHT;
    }else if (indexPath.row == 1){
        return 0.2*SCREEN_HEIGHT;
    }
    return 0.1*SCREEN_HEIGHT;
}

#pragma mark --orderFinishDelegate
- (void)pushToOrderFinishVC:(NSInteger)count{
    NSLog(@"%ld",count);
    if (count == 0) {
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
    
}


- (void)pushToExplainVC{
    ExplainViewController *explainVC = [[ExplainViewController alloc] init];
    [explainVC refreshVC:_returnDataItemShow];
    [self.navigationController pushViewController:explainVC animated:YES];
}

#pragma mark --NSXMLParserDelegate
//step 1 :准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
    self.itemDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.imageDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    
}
//step 2：准备解析节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    
    
    self.itemText = [[NSString alloc] init];
    if ([elementName isEqualToString:@"item"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        self.itemDic = newNode;
    }else if(self.itemDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        [self.itemDic setObject :string forKey :elementName];
        self.itemElementName = elementName;
    }
    
    self.imageText = [[NSString alloc] init];
    if ([elementName isEqualToString:@"image"]) {
        NSMutableDictionary *newNode = [[ NSMutableDictionary alloc ] initWithCapacity : 0 ];
        self.imageDic = newNode;
    }else if(self.imageDic) {
        NSMutableString *string = [[ NSMutableString alloc ] initWithCapacity : 0 ];
        [self.imageDic setObject :string forKey :elementName];
        self.imageElementName = elementName;
    }

}
//step 3:获取首尾节点间内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //    NSLog(@"%@",NSStringFromSelector(_cmd) );
    //    [self.currentText appendString:string];
    
    self.itemText = [self.itemText stringByAppendingString:string];
    self.imageText = [self.imageText stringByAppendingString:string];
}

//step 4 ：解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    
    if ([elementName isEqualToString:@"item"]) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tempDic addEntriesFromDictionary:self.itemDic];
        [self.item addObject:tempDic];
        self.itemDic = nil;
    }else if ([elementName isEqualToString:self.itemElementName]) {
        
        //            if ([elementName isEqualToString:@"description"]
        //                ||[elementName isEqualToString:@"content:encoded"]) {
        //                [twitterDic setObject:Cdata forKey:currentElementName];
        //            }else {
        [self.itemDic setObject:self.itemText forKey:self.itemElementName];
        
        //            }
    }
    if ([elementName isEqualToString:@"image"]) {
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [tempDic addEntriesFromDictionary:self.imageDic];
        [self.image addObject:tempDic];
        self.imageDic = nil;
    }else if ([elementName isEqualToString:self.imageElementName]){
        [self.imageDic setObject:self.imageText forKey:self.imageElementName];
    }
}

//step 5；解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.returnData setObject:self.item forKey:@"item"];
    [self.returnData setObject:self.image forKey:@"image"];
    
//            NSLog(@"%@",self.returnData);
    //    NSLog(@"%@",self.banner);
    
}



- (void)pushToExplain{
    ExplainViewController *explainVC = [[ExplainViewController alloc] init];
    [explainVC refreshVC:_returnDataItemShow];
    [self.navigationController pushViewController:explainVC animated:YES];
}

@end
