//
//  PointsViewController.m
//  ylyyt
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PointsViewController.h"
#import "PointsTableViewCell.h"
#import "LoginViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "PointList.h"

@interface PointsViewController ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
{
    PointList *_pointList;
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *returnData;
@property (nonatomic, strong) NSMutableArray *item;

@property (nonatomic, copy) NSString *itemName;

@end

@implementation PointsViewController

- (void)viewWillAppear:(BOOL)animated;{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginRefresh:) name:@"loginRefresh" object:nil];
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
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationItem.title = @"我的积分";
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.05*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, 0.9*SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        self.tableView = tableView;
        
        UINib *pointsNib = [UINib nibWithNibName:@"PointsTableViewCell" bundle:nil];
        [tableView registerNib:pointsNib forCellReuseIdentifier:@"PointsTableViewCell"];
        
        self.returnData = [[NSMutableArray alloc] initWithCapacity:0];
        [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"api_pointList.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
            responseObject.delegate = (id<NSXMLParserDelegate>)self;
            [responseObject parse];
            if (self.name != nil) {
                [tableView reloadData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }

}

- (void)loginRefresh:(NSNotification *)sender{
    self.name = sender.object;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)pushToLoginVC{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.item.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PointsTableViewCell *pointsCell = [tableView dequeueReusableCellWithIdentifier:@"PointsTableViewCell"];
    pointsCell.backgroundColor = [UIColor clearColor];
    _pointList = [PointList pointListWithDic:self.item[indexPath.row]];
    [pointsCell refreshCell:_pointList];
    return pointsCell;
    
}



#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0.15*SCREEN_HEIGHT;
    
}

#pragma mark --NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析开始！");
    self.item = [[NSMutableArray alloc] init];
}
//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict{
    if ([@"returnData" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.returnData addObject:tempDic];
        [self.returnData setValue:self.item forKey:@"item"];
    }else if ([@"item" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.item addObject:tempDic];
    }else{
        self.itemName = elementName;
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
    
    NSMutableDictionary *itemDic = [self.item lastObject];
    [itemDic setObject:string forKey:self.itemName];
    
    
}
//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    //    NSLog(@"结束标记：%@",elementName);
}
//文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析结束！");
                    NSLog(@"%@",self.returnData);
            NSLog(@"%@",self.item);
    
}


@end
