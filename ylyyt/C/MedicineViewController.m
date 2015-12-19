//
//  MedicineViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineViewController.h"
#import "MedicineDetailViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "MedicineCollectionViewCell.h"
#import "SubCatalog.h"

@interface MedicineViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,NSXMLParserDelegate>
{
    UICollectionView *_rightCollectionView;
    SubCatalog *_subcatalogs;
}

@property (nonatomic, strong)NSMutableArray *returnData;
@property (nonatomic, strong)NSMutableArray *catalog;

@property (nonatomic, strong)NSMutableArray *returnDataSub;
@property (nonatomic, strong)NSMutableArray *subCatalog;
@property (nonatomic, copy) NSString *subCatalogName;



@end

@implementation MedicineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"药品目录";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo32.png"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoImageView];
    
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT , 0.28*SCREEN_WIDTH, 0.55*SCREEN_HEIGHT) style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.separatorColor = [UIColor redColor];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:leftTableView];
    
    
    self.returnData = [[NSMutableArray alloc] initWithCapacity:0];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://adobeflash.duapp.com/appYulin/xmlAPI/api_totalCatalog.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        responseObject.delegate = (id<NSXMLParserDelegate>)self;
        [responseObject parse];
        [leftTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        NSString *categoryId = self.catalog[0];
        [self loadCategoryList:categoryId refresh:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];

    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationPortrait == orientation) {
        //6,6s
        if (SCREEN_WIDTH == 375.0f) {
            [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/5, 0.14*SCREEN_HEIGHT)];
            flowLayout.sectionInset = UIEdgeInsetsMake(0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH);
        }else if (SCREEN_WIDTH == 320.0f){
            //4s
            if (SCREEN_HEIGHT == 480.0f) {
                [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/6, 0.14*SCREEN_HEIGHT)];
                flowLayout.sectionInset = UIEdgeInsetsMake(0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH);
                //5,5s
            }else{
                [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/5.1, 0.14*SCREEN_HEIGHT)];
                flowLayout.sectionInset = UIEdgeInsetsMake(0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH);
            }
        }else if (SCREEN_WIDTH == 414.0f){
            [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH/5, 0.15*SCREEN_HEIGHT)];
            flowLayout.sectionInset = UIEdgeInsetsMake(0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.02*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH);
        }
    }
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView *rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.3 *SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, 0.7*SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT) collectionViewLayout:flowLayout];
    rightCollectionView.dataSource = self;
    rightCollectionView.delegate = self;
    rightCollectionView.backgroundColor = [UIColor clearColor];
    [rightCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    _rightCollectionView = rightCollectionView;
    [self.view addSubview:_rightCollectionView];
    
    UINib *rightCollectionViewNib = [UINib nibWithNibName:@"MedicineCollectionViewCell" bundle:nil];
    [_rightCollectionView registerNib:rightCollectionViewNib forCellWithReuseIdentifier:@"MedicineCollectionViewCell"];

}

- (void)loadCategoryList:(NSString *)categoryId refresh:(BOOL)refresh{
    self.returnDataSub = [[NSMutableArray alloc] initWithCapacity:0];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://adobeflash.duapp.com/appYulin/xmlAPI/api_subCatalog.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        responseObject.delegate = (id<NSXMLParserDelegate>)self;
        [responseObject parse];
        
        [_rightCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}



#pragma mark --UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subCatalog.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MedicineCollectionViewCell *medicineCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MedicineCollectionViewCell" forIndexPath:indexPath];
    medicineCell.backgroundColor = [UIColor whiteColor];
    _subcatalogs = [SubCatalog subCatalogWithDic:self.subCatalog[indexPath.row]];
    [medicineCell refreshCell:_subcatalogs];
    

    
    return medicineCell;
}
#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MedicineDetailViewController *medicineVC = [[MedicineDetailViewController alloc] init];
    [self.navigationController pushViewController:medicineVC animated:YES];
    
}


#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.catalog.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor blueColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.catalog[indexPath.row]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    return cell;
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.04*SCREEN_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * categoryId = self.catalog[indexPath.row];
    [self loadCategoryList:categoryId refresh:YES];
}

#pragma mark --NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析开始！");
//    self.catalog = [[NSMutableArray alloc] init];
     self.subCatalog = [[NSMutableArray alloc] init];
}
//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict{
    
    if ([@"returnData" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.returnData addObject:tempDic];
        [self.returnData setValue:self.catalog forKey:@"catalog"];
        NSMutableDictionary *tempDic1 = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.returnDataSub addObject:tempDic1];
        [self.returnDataSub setValue:self.subCatalog forKey:@"subCatalog"];
    }else if([@"subCatalog" isEqualToString:elementName]){
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.subCatalog addObject:tempDic];
    }else{
        self.subCatalogName = elementName;
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
    
    if (self.catalog != nil) {
        [self.catalog addObject:string];
    }else{
        self.catalog = [NSMutableArray array];
    }
    
    NSDictionary *itemDic = [self.subCatalog lastObject];
    [itemDic setValue:string forKey:self.subCatalogName];
    
}
//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    //    NSLog(@"结束标记：%@",elementName);
}
//文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析结束！");
    
//    NSLog(@"%@",self.returnData);
//    NSLog(@"%@",self.catalog);

    NSLog(@"%@",self.returnDataSub);
//    NSLog(@"%@",self.subCatalog);
    
}
@end
