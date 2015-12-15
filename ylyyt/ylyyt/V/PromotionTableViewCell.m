//
//  PromotionTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PromotionTableViewCell.h"
#import "MainPage.h"
#import "News.h"
#import "PromotionDetailTableViewCell.h"

@interface PromotionTableViewCell ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) News *news;

@property (nonatomic, strong) NSMutableArray * newsArr;

@property (nonatomic, strong) MainPage *mainPage;

@end


@implementation PromotionTableViewCell


- (void)refreshCell:(MainPage*)mainPage{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH-40,0.62*SCREEN_HEIGHT-50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    
    tableView.layer.borderWidth = 0.5;
    tableView.layer.borderColor = [[UIColor colorWithRed:244 green:244 blue:244 alpha:0.8] CGColor];
    tableView.layer.cornerRadius = 6.0f;
    
    [self addSubview:tableView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 40)];
        titleView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 100, 20)];
    //    titleLabel.backgroundColor = [UIColor grayColor];
    titleLabel.text = @"促销信息";
    titleLabel.textColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    [titleView addSubview:titleLabel];
    UIImageView *proImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    proImageView.image = [UIImage imageNamed:@"pro.png"];
    [titleView addSubview:proImageView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH-40, 1)];
    [lineView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [titleView addSubview:lineView];
    UIImageView *angleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.75*SCREEN_WIDTH, 12.5, 20, 15)];
//    angleImageView.backgroundColor = [UIColor grayColor];
    angleImageView.image = [UIImage imageNamed:@"右箭头_16.png"];
    [titleView addSubview:angleImageView];
    [self addSubview:titleView];
    
    
    
    self.newsArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < mainPage.ne.count; i++) {
        self.news = mainPage.ne[i];
        [self.newsArr addObject:self.news];
    }
    
    self.mainPage = mainPage;
    
    UINib *proDetailNib = [UINib nibWithNibName:@"PromotionDetailTableViewCell" bundle:nil];
    [tableView registerNib:proDetailNib forCellReuseIdentifier:@"PromotionDetailTableViewCell"];
}

- (void)awakeFromNib {
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PromotionDetailTableViewCell *proDetailCell = [tableView dequeueReusableCellWithIdentifier:@"PromotionDetailTableViewCell"];
    [proDetailCell refreshCell:self.newsArr[indexPath.row]];
    
    return proDetailCell;
}



#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.21*self.bounds.size.height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.12*self.bounds.size.height;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *titleView = [[UIView alloc] init];
////    titleView.backgroundColor = [UIColor blueColor];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.03*SCREEN_WIDTH, 0.025*SCREEN_HEIGHT, 0.4*SCREEN_WIDTH, 0.04*SCREEN_HEIGHT)];
////    titleLabel.backgroundColor = [UIColor grayColor];
//    titleLabel.text = @"促销信息";
//    titleLabel.textColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
//    [titleView addSubview:titleLabel];
//    
//    return titleView;
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    News *news = self.newsArr[indexPath.row];
    [self.delegate pushToDrugStore:news.linkUrl];
    
}
@end
