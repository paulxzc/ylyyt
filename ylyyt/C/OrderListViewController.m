//
//  OrderListViewController.m
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewCell.h"
#import "AFAppDotNetAPIClient.h"
#import "OrderListItem.h"

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate>
{
    OrderListItem *_orderListItem;
}

@property (nonatomic, strong)NSMutableArray *returnData;

@property (nonatomic, strong) NSMutableDictionary *itemDic;
@property (nonatomic, copy)  NSString *itemText;
@property (nonatomic, copy) NSString *itemElementName;


@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"预约订单列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    UITableView *tableView = [[UITableView alloc] init];
    //    self.tableView.backgroundColor = [UIColor redColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT);
    
    [self.view addSubview:tableView];
    
    UINib *orderListNib = [UINib nibWithNibName:@"OrderListTableViewCell" bundle:nil];
    [tableView registerNib:orderListNib forCellReuseIdentifier:@"OrderListTableViewCell"];
    
    self.returnData = [[NSMutableArray alloc] initWithCapacity:0];
    [[AFAppDotNetAPIClient sharedClient] GET:[NSString stringWithFormat:@"http://adobeflash.duapp.com/appYulin/xmlAPI/api_itemOrderList.xml"] parameters:nil success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
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
    OrderListTableViewCell *orderListCell = [tableView dequeueReusableCellWithIdentifier:@"OrderListTableViewCell"];
    _orderListItem = [OrderListItem orderListItemWithDic:self.returnData[indexPath.row]];
    [orderListCell refreshCell:_orderListItem];
    return orderListCell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.25*SCREEN_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
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
    
            NSLog(@"%@",self.returnData);
    //    NSLog(@"%@",self.banner);
    
}


@end
