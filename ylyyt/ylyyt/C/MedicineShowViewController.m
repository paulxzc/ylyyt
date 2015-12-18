//
//  MedicineShowViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineShowViewController.h"
#import "OrderViewController.h"
#import "ExplainViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "MedicineItemDetail.h"
#import "MedicineImage.h"
#import "ReturnDataItemShow.h"
#import "ShopInfoForItemShow.h"

@interface MedicineShowViewController ()<UIScrollViewDelegate,NSXMLParserDelegate>
{
    ReturnDataItemShow *_returnDataItemShow;
    MedicineItemDetail *_medicineItemDetail;
    MedicineImage *_medicineImage;
    ShopInfoForItemShow *_shopInfoForItemShow;
}

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (nonatomic, strong)NSMutableArray *returnData;
@property (nonatomic, strong)NSMutableArray *item;
@property (nonatomic, strong)NSMutableArray *image;
@property (nonatomic, strong)NSMutableArray *shopInfo;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *shopInfoName;

@property (nonatomic) int count;
@end

@implementation MedicineShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"药品详细信息";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.returnData = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"api_itemShow.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        responseObject.delegate = (id<NSXMLParserDelegate>)self;
        [responseObject parse];
        _returnDataItemShow = [ReturnDataItemShow returnDataItemShowWithDic:self.returnData[0]];
        _medicineItemDetail = _returnDataItemShow.it[0];
        
        for (int i = 0; i < _returnDataItemShow.im.count; i++) {
            _medicineImage = _returnDataItemShow.im[i];
            [tempArr addObject:_medicineImage.imageName];
            
        }
       
        
        NSMutableArray *imagesArr = [[NSMutableArray alloc] initWithCapacity:0];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempArr lastObject]]];
        [imagesArr addObject:image];
        
        for (int i = 0; i < tempArr.count; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@",tempArr[i]];
            UIImage *image = [UIImage imageNamed:imageName];
            [imagesArr addObject:image];
        }
        
        UIImage *imageLast = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tempArr firstObject]]];
        [imagesArr addObject:imageLast];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT)];
        _scrollView.bounces = NO;
        _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imagesArr.count, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT);
        //    _scrollView.alwaysBounceHorizontal = YES;//横向一直可拖动
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.pagingEnabled = YES;//关键属性，打开page模式。
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;//不要显示滚动条~
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        
        
        for (int i = 0; i < imagesArr.count; i++) {
            self.imageView = [[UIImageView alloc] initWithImage:imagesArr[i]];
            self.imageView.frame = CGRectMake(i*SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT);
            [_scrollView addSubview:self.imageView];
        }
        
        CGSize size = [self.pageControl sizeForNumberOfPages:imagesArr.count];
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        self.pageControl.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-TABBAR_HEIHGT-10);
        self.pageControl.numberOfPages = imagesArr.count - 2;
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        //    self.pageControl.currentPage = 0;
        [self.view addSubview:self.pageControl];
        //    [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];

        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.06*SCREEN_WIDTH, 0.14*SCREEN_HEIGHT, 0.28*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT)];
//        priceLabel.text = [NSString stringWithFormat:@"单价:%@",_medicineItemDetail.itemPrice];
        priceLabel.backgroundColor = [UIColor colorWithRed:112/255.0 green:140/255.0 blue:56/255.0 alpha:0.8];
        [self.view addSubview:priceLabel];
        
        UIButton *orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.65*SCREEN_WIDTH, 0.12*SCREEN_HEIGHT, 0.12*SCREEN_WIDTH, 0.12*SCREEN_WIDTH)];
        [orderBtn setTitle:@"订购药品" forState:UIControlStateNormal];
        orderBtn.backgroundColor = [UIColor colorWithRed:112/255.0 green:140/255.0 blue:56/255.0 alpha:0.8];
        [orderBtn addTarget:self action:@selector(pushToOrderVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:orderBtn];
        
        UIButton *explainBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.79*SCREEN_WIDTH, 0.12*SCREEN_HEIGHT, 0.12*SCREEN_WIDTH, 0.12*SCREEN_WIDTH)];
        [explainBtn setTitle:@"药物说明" forState:UIControlStateNormal];
        explainBtn.backgroundColor = [UIColor colorWithRed:112/255.0 green:140/255.0 blue:56/255.0 alpha:0.8];
        [explainBtn addTarget:self action:@selector(pushToExplainVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:explainBtn];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
    
    
    
}

- (void)pageChanged:(UIPageControl*)pageControl{
    [self.scrollView setContentOffset:CGPointMake(pageControl.currentPage*SCREEN_WIDTH, 0) animated:YES];
}

//减速完成时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    if (currentPage == 0 || currentPage == 5) {
        if (currentPage == 0) {
            currentPage = 4;
        }else{
            currentPage = 1;
        }
        [scrollView setContentOffset:CGPointMake(currentPage*SCREEN_WIDTH, 0)];
    }
    //同步
    _pageControl.currentPage = currentPage-1;
    
}

- (void)pushToOrderVC{
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    [orderVC refreshVC:_returnDataItemShow];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)pushToExplainVC{
    ExplainViewController *explainVC = [[ExplainViewController alloc] init];
    [explainVC refreshVC:_returnDataItemShow];
    [self.navigationController pushViewController:explainVC animated:YES];
}

#pragma mark --NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析开始！");
    self.item = [NSMutableArray array];
    self.image = [NSMutableArray array];
    self.shopInfo = [NSMutableArray array];
    
}
//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict{
    
    if ([@"returnData" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.returnData addObject:tempDic];
        [self.returnData setValue:self.item forKey:@"item"];
        [self.returnData setValue:self.image forKey:@"image"];
        [self.returnData setValue:self.shopInfo forKey:@"shopInfo"];
    }else if ([@"item" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.item addObject:tempDic];
    }else if ([@"image" isEqualToString:elementName]){
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.image addObject:tempDic];
    }else if ([@"shopInfo" isEqualToString:elementName]){
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.shopInfo addObject:tempDic];
    }
    else{
        self.itemName = elementName;
        self.imageName = elementName;
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
    
    _count++;
    if (self.item.count == 1&&_count <= 13) {
        NSMutableDictionary *itemDic = [self.item lastObject];
        [itemDic setObject:string forKey:self.itemName];
    }
    
    if (self.image.count <= 4&&_count<=20&&_count>=17) {
        NSMutableDictionary *imageDic = [self.image lastObject];
        [imageDic setObject:string forKey:self.imageName];
    }
    
    
//    
//    NSMutableDictionary *imageDic = [self.image lastObject];
//    [imageDic setObject:string forKey:self.imageName];
//    
//        NSLog(@"%d",_count);
//        NSLog(@"%lu",(unsigned long)self.image.count);
//        NSLog(@"%@",imageDic);
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
    
    NSLog(@"%@",self.returnData);
//            NSLog(@"%@",self.item);
        NSLog(@"%@",self.image);
//    NSLog(@"%@",self.shopInfo);
    
    
}
@end
