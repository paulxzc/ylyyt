//
//  DrugStoreDetailViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/24.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "DrugStoreDetailViewController.h"
#import "TSPopoverController.h"
#import "MapViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "ShopImageList.h"
#import "MedicineDetailViewController.h"
#import "ShopInfo.h"

@interface DrugStoreDetailViewController ()<UIScrollViewDelegate,NSXMLParserDelegate>
{
    ShopImageList *_shopImageList;
    ShopInfo *_shopInfo;
}

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIPageControl *pageControl;


@property (nonatomic, strong)NSMutableArray *returnData;
@property (nonatomic, strong)NSMutableArray *images;

@property (nonatomic, copy) NSString *imagesName;

@property (nonatomic, strong)NSMutableArray *tempNameArr;
@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneLabel;

@end

@implementation DrugStoreDetailViewController

- (void)refreshVC:(ShopInfo *)shopInfo{
    _shopInfo = shopInfo;
    self.drugStoreName = shopInfo.shopName;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    if (name == nil) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        self.navigationItem.title = self.drugStoreName;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:nil];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
#pragma mark --下载数据
        self.returnData = [[NSMutableArray alloc] init];
        [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"api_shopImageList.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
            responseObject.delegate = (id<NSXMLParserDelegate>)self;
            [responseObject parse];
            
            
            
            NSMutableArray *tempImagesArr = [[NSMutableArray alloc] initWithCapacity:0];
            _tempNameArr = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < self.images.count; i++) {
                _shopImageList = [ShopImageList shopImageListWithDic:self.images[i]];
                UIImage *tempImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_shopImageList.imageName]];
                [tempImagesArr addObject:tempImage];
                [_tempNameArr addObject:_shopImageList.imageDescribe];
            }
            
            
            NSMutableArray *imagesArr = [[NSMutableArray alloc] initWithCapacity:0];
            UIImage *image = [tempImagesArr lastObject];
            [imagesArr addObject:image];
            
            for (int i = 0; i < self.images.count; i++) {
                UIImage *image = tempImagesArr[i];
                [imagesArr addObject:image];
                
            }
            
            UIImage *imageLast = [tempImagesArr firstObject];
            [imagesArr addObject:imageLast];
            
            //    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIHGT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
            _scrollView.backgroundColor = [UIColor blackColor];
            _scrollView.bounces = NO;
            _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
            _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * imagesArr.count, SCREEN_HEIGHT-TABBAR_HEIHGT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT);
            //    _scrollView.alwaysBounceHorizontal = YES;//横向一直可拖动
            _scrollView.alwaysBounceVertical = NO;
            _scrollView.pagingEnabled = YES;//关键属性，打开page模式。
            _scrollView.delegate = self;
            _scrollView.showsHorizontalScrollIndicator = NO;//不要显示滚动条~
            _scrollView.showsVerticalScrollIndicator = NO;
            [self.view addSubview:_scrollView];
            
            
            for (int i = 0; i < imagesArr.count; i++) {
                self.imageView = [[UIImageView alloc] initWithImage:imagesArr[i]];
                self.imageView.frame = CGRectMake(i*SCREEN_WIDTH,0, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIHGT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT);
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
            
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.05*SCREEN_WIDTH, 0.12*SCREEN_HEIGHT, 0.29*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
            _nameLabel.backgroundColor = [UIColor colorWithRed:112/255.0 green:140/255.0 blue:56/255.0 alpha:0.8];
            _nameLabel.text = [NSString stringWithFormat:@"%@",_tempNameArr[0]];
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            _nameLabel.textColor = [UIColor whiteColor];
            [self.view addSubview:_nameLabel];
            
            UIButton *customerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.83*SCREEN_WIDTH, 0.12*SCREEN_HEIGHT, 0.125*SCREEN_WIDTH, 0.125*SCREEN_WIDTH)];
            [customerBtn setImage:[UIImage imageNamed:@"商户.png"] forState:UIControlStateNormal];
            [customerBtn setImage:[UIImage imageNamed:@"商户on.png"] forState:UIControlStateHighlighted];
            [customerBtn addTarget:self action:@selector(showCustomerPopover:forEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:customerBtn];
            
            UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.83*SCREEN_WIDTH, 0.2*SCREEN_HEIGHT, 0.125*SCREEN_WIDTH, 0.125*SCREEN_WIDTH)];
            [phoneBtn setImage:[UIImage imageNamed:@"电话.png"] forState:UIControlStateNormal];
            [phoneBtn setImage:[UIImage imageNamed:@"电话on.png"] forState:UIControlStateHighlighted];
            [phoneBtn addTarget:self action:@selector(showPhonePopover:forEvent:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:phoneBtn];
            
            UIButton *mapBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.83*SCREEN_WIDTH, 0.28*SCREEN_HEIGHT, 0.125*SCREEN_WIDTH, 0.125*SCREEN_WIDTH)];
            [mapBtn setTitle:@"地图" forState:UIControlStateNormal];
            mapBtn.backgroundColor = [UIColor colorWithRed:112/255.0 green:140/255.0 blue:56/255.0 alpha:0.8];
            [mapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:mapBtn];
            
            UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.83*SCREEN_WIDTH, 0.36*SCREEN_HEIGHT, 0.125*SCREEN_WIDTH, 0.125*SCREEN_WIDTH)];
            [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
            attentionBtn.backgroundColor = [UIColor colorWithRed:112/255.0 green:140/255.0 blue:56/255.0 alpha:0.8];
            [attentionBtn addTarget:self action:@selector(showAttention:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:attentionBtn];
            
            UIButton *medicineBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.83*SCREEN_WIDTH, 0.44*SCREEN_HEIGHT, 0.125*SCREEN_WIDTH, 0.125*SCREEN_WIDTH)];
            [medicineBtn setTitle:@"购药" forState:UIControlStateNormal];
            medicineBtn.backgroundColor = [UIColor colorWithRed:112/255.0 green:140/255.0 blue:56/255.0 alpha:0.8];
            [medicineBtn addTarget:self action:@selector(buyMedicine) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:medicineBtn];
            
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
        
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    _nameLabel.text = [NSString stringWithFormat:@"%@",_tempNameArr[_pageControl.currentPage]];
}

//-(void)showPopover:(id)sender
-(void)showCustomerPopover:(id)sender forEvent:(UIEvent*)event
{
    //    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    //    tableViewController.view.frame = CGRectMake(0,0, 320, 400);
    UIViewController *VC = [[UIViewController alloc] init];
    VC.view.frame = CGRectMake(0, 0, 0.7*SCREEN_WIDTH, 0.14*SCREEN_HEIGHT);
    VC.view.backgroundColor = [UIColor whiteColor];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:VC];
    
    UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 0.66*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT)];
    shopNameLabel.backgroundColor = [UIColor redColor];
    shopNameLabel.text = [NSString stringWithFormat:@"店铺名称:%@",_shopInfo.shopName];
    shopNameLabel.font = [UIFont boldSystemFontOfSize:13];
    [VC.view addSubview:shopNameLabel];
    
    UILabel *shopAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 4+0.03*SCREEN_HEIGHT, 0.66*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT)];
    shopAddressLabel.backgroundColor = [UIColor redColor];
    shopAddressLabel.text = [NSString stringWithFormat:@"地址:%@",_shopInfo.shopAddress];
    shopAddressLabel.font = [UIFont boldSystemFontOfSize:10];
    [VC.view addSubview:shopAddressLabel];
    
    UILabel *shopAdminLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 6+0.06*SCREEN_HEIGHT, 0.66*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT)];
    shopAdminLabel.backgroundColor = [UIColor redColor];
    shopAdminLabel.text = [NSString stringWithFormat:@"负责人:%@",_shopInfo.shopAdmin];
    shopAdminLabel.font = [UIFont boldSystemFontOfSize:10];
    [VC.view addSubview:shopAdminLabel];
    
    UILabel *shopPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 8+0.09*SCREEN_HEIGHT, 0.66*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT)];
    shopPhoneLabel.backgroundColor = [UIColor redColor];
    shopPhoneLabel.text = [NSString stringWithFormat:@"电话:%@",_shopInfo.shopPhone];
    shopPhoneLabel.font = [UIFont boldSystemFontOfSize:10];
    [VC.view addSubview:shopPhoneLabel];
    
    popoverController.cornerRadius = 5;
    popoverController.titleText = @"商户信息";
    popoverController.popoverBaseColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    popoverController.popoverGradient= YES;
    popoverController.arrowPosition = TSPopoverArrowPositionHorizontal;
    [popoverController showPopoverWithTouch:event];
    
}

-(void)showPhonePopover:(id)sender forEvent:(UIEvent*)event
{
    //    UITableViewController *tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    //    tableViewController.view.frame = CGRectMake(0,0, 320, 400);
    UIViewController *VC = [[UIViewController alloc] init];
    VC.view.frame = CGRectMake(0, 0, 0.65*SCREEN_WIDTH, 0.1*SCREEN_HEIGHT);
    VC.view.backgroundColor = [UIColor whiteColor];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:VC];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.05*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT, 0.35*SCREEN_WIDTH, 0.04*SCREEN_HEIGHT)];
    self.phoneLabel.text = @"18233027919";
    self.phoneLabel.backgroundColor = [UIColor redColor];
    [VC.view addSubview:self.phoneLabel];
    
    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.41*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT, 0.19*SCREEN_WIDTH, 0.04*SCREEN_HEIGHT)];
    [phoneBtn setTitle:@"点击拨打" forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    phoneBtn.backgroundColor = [UIColor greenColor];
    [phoneBtn addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    [VC.view addSubview:phoneBtn];
    
    popoverController.cornerRadius = 5;
    popoverController.titleText = @"联系电话";
    popoverController.popoverBaseColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    popoverController.popoverGradient= YES;
    popoverController.arrowPosition = TSPopoverArrowPositionHorizontal;
    [popoverController showPopoverWithTouch:event];
}

- (void)showMap{
    MapViewController *mapVC = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)showAttention:(UIButton *)btn{
    if ([btn.titleLabel.text  isEqual: @"关注"]) {
        [btn setTitle:@"取消关注" forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)buyMedicine{
    MedicineDetailViewController *medicineDetailVC = [[MedicineDetailViewController alloc] init];
    [self.navigationController pushViewController:medicineDetailVC animated:YES];
}

- (void)phone{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.phoneLabel.text]]];
}

#pragma mark --NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析开始！");
    self.images = [[NSMutableArray alloc] init];
}
//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict{
    if ([@"returnData" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.returnData addObject:tempDic];
        [self.returnData setValue:self.images forKey:@"image"];
    }else if ([@"image" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.images addObject:tempDic];
    }else{
        self.imagesName = elementName;
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
    
    NSMutableDictionary *shopInfoDic = [self.images lastObject];
    [shopInfoDic setObject:string forKey:self.imagesName];
    
    
}
//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    //    NSLog(@"结束标记：%@",elementName);
}
//文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析结束！");
//                NSLog(@"%@",self.returnData);
//            NSLog(@"%@",self.images);
    
}


@end
