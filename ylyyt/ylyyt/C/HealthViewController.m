//
//  HealthViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HealthViewController.h"
#import "LoginViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "MyCenterItem.h"
#import "OrderListViewController.h"
#import "PersonTableViewCell.h"
#import "NoLoginTableViewCell.h"
#import "TSPopOverController.h"
#import "PointsViewController.h"


@interface HealthViewController ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,loginPopDelegate>
{
    MyCenterItem *_myCenterItem;
}


@property (assign) NSInteger tabCount;

@property (nonatomic, strong)NSMutableArray *returnData;
@property (nonatomic, strong)NSMutableArray *item;

//用于存储当前的标签
@property (nonatomic, copy) NSString *itemName;

//存储用户名
@property (nonatomic, copy) NSString *name;


@property (nonatomic, strong) UILabel *warnLabel;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIBarButtonItem *loginCancelBar;


@property (nonatomic, strong) TSPopoverController *popoverController;

@end

@implementation HealthViewController

- (void)viewWillAppear:(BOOL)animated;{
    [super viewWillAppear:YES];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginRefresh:) name:@"loginRefresh" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backRefresh:) name:@"backRefresh" object:nil];
    
    self.returnData = [[NSMutableArray alloc] initWithCapacity:0];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"api_personalCatalog.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        responseObject.delegate = (id<NSXMLParserDelegate>)self;
        [responseObject parse];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        self.name = [userDefault objectForKey:@"name"];
        NSLog(@"healthvc.name:%@",self.name);
        
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];

    
}

- (void)loginRefresh:(NSNotification *)sender{
    self.name = sender.object;
    NSLog(@"loginrefresh:%@",self.name);
    
//    if (self.name != nil) {
//        self.loginCancelBar = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(loginCancel)];
//        
//        self.navigationItem.rightBarButtonItem = self.loginCancelBar;
//    }
    
    
    
    
}

- (void)backRefresh:(NSNotification *)sender{
   }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"个人中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo32.png"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:logoImageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushToLoginCancel:forEvent:)];
    
#pragma mark --搭建UI
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UINib *personNib = [UINib nibWithNibName:@"PersonTableViewCell" bundle:nil];
    [tableView registerNib:personNib forCellReuseIdentifier:@"PersonTableViewCell"];
    UINib *noLoginNib = [UINib nibWithNibName:@"NoLoginTableViewCell" bundle:nil];
    [tableView registerNib:noLoginNib forCellReuseIdentifier:@"NoLoginTableViewCell"];
    
    

//    if (self.name == nil) {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        loginVC.userState = @"Cancel";
//        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
//    }
//

}

- (void)pushToLoginCancel:(id)sender forEvent:(UIEvent*)event{
    if (self.name == nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还未登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.userState = @"Cancel";
            [self.navigationController presentViewController:loginVC animated:YES completion:nil];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:loginAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        UIButton *loginCancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.05*SCREEN_WIDTH, 5, 0.4*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
        [loginCancelBtn setTitle:@"注销" forState:UIControlStateNormal];
        loginCancelBtn.backgroundColor = [UIColor greenColor];
        [loginCancelBtn addTarget:self action:@selector(loginCancel) forControlEvents:UIControlEventTouchUpInside];
        
        UIViewController *VC = [[UIViewController alloc] init];
        VC.view.frame = CGRectMake(0, 0, 0.5*SCREEN_WIDTH, 0.1*SCREEN_HEIGHT);
        VC.view.backgroundColor = [UIColor whiteColor];
        [VC.view addSubview:loginCancelBtn];
        TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:VC];
        
        popoverController.cornerRadius = 5;
        popoverController.titleText = @"注销当前用户";
        popoverController.popoverBaseColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
        popoverController.popoverGradient= YES;
        popoverController.arrowPosition = TSPopoverArrowPositionVertical;
        [popoverController showPopoverWithTouch:event];
        self.popoverController = popoverController;
        
    }
}

- (void)loginCancel{
    //获取UserDefaults单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //移除UserDefaults中存储的用户信息
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults synchronize];

    //创建发送通知
    NSNotification *noti = [[NSNotification alloc] initWithName:@"backRefresh" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    
    [self.popoverController dismissPopoverAnimatd:YES];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.userState = @"Cancel";
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
}

- (void)popLogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
//    loginVC.userState = @"Cancel";
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];

}


#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.item.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0&&self.name == nil) {
        NSLog(@"1111:%@",self.name);
        NoLoginTableViewCell *noLoginCell = [tableView dequeueReusableCellWithIdentifier:@"NoLoginTableViewCell"];
        noLoginCell.delegate = self;
        return noLoginCell;
    }else if (indexPath.row == 0&&self.name != nil){
        PersonTableViewCell *personCell = [tableView dequeueReusableCellWithIdentifier:@"PersonTableViewCell"];
        return personCell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _myCenterItem = [MyCenterItem mycenterItemWithDic:self.item[indexPath.row-1]];
        cell.textLabel.text = _myCenterItem.itemName;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_myCenterItem.itemIcon]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }
    
}



#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 0.23*SCREEN_HEIGHT;
    }
        return 0.1*SCREEN_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.name == nil) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
        
    }else{
        if (indexPath.row == 1) {
            OrderListViewController *orderListVC = [[OrderListViewController alloc] init];
            [self.navigationController pushViewController:orderListVC animated:YES];
        }else if (indexPath.row == 4){
            PointsViewController *pointsVC = [[PointsViewController alloc] init];
            [self.navigationController pushViewController:pointsVC animated:YES];
        }
    }
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
    }else if([@"item" isEqualToString:elementName]){
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
    
    NSDictionary *itemDic = [self.item lastObject];
    [itemDic setValue:string forKey:self.itemName];
    
    
}
//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    //    NSLog(@"结束标记：%@",elementName);
}
//文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析结束！");
//    NSLog(@"%@",self.returnData);
//    NSLog(@"%@",self.item);
    
}



@end
