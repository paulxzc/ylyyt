//
//  MedicineTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicineTableViewCell.h"
#import "MainPage.h"
#import "HotItem.h"
#import "MedicineItemTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MedicineTableViewCell ()<UITableViewDelegate,UITableViewDataSource/*,UISearchResultsUpdating,UISearchBarDelegate*/>

//@property (nonatomic, strong) UISearchController *searchC;

@property (nonatomic, strong) NSMutableArray *hotItemArr;

@property (nonatomic, strong) HotItem *hotItem;

@end

@implementation MedicineTableViewCell


- (void)refreshCell:(MainPage*)mainPage{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH-40, 0.61*SCREEN_HEIGHT-TABBAR_HEIHGT-50) style:UITableViewStylePlain];
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
    titleLabel.text = @"推荐药品";
    titleLabel.textColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    [titleView addSubview:titleLabel];
    UIImageView *medImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    medImageView.image = [UIImage imageNamed:@"med.png"];
    [titleView addSubview:medImageView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH-40, 1)];
    [lineView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5]];
    [titleView addSubview:lineView];
    UIImageView *angleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.75*SCREEN_WIDTH, 12.5, 20, 15)];
    //    angleImageView.backgroundColor = [UIColor grayColor];
    angleImageView.image = [UIImage imageNamed:@"右箭头_16.png"];
    [titleView addSubview:angleImageView];
    [self addSubview:titleView];
   
    
    self.hotItemArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < mainPage.ho.count; i++) {
        self.hotItem = mainPage.ho[i];
        [self.hotItemArr addObject:self.hotItem];
    }
    UINib *medicineItemNib = [UINib nibWithNibName:@"MedicineItemTableViewCell" bundle:nil];
    [tableView registerNib:medicineItemNib forCellReuseIdentifier:@"MedicineItemTableViewCell"];
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
    return self.hotItemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        UITableViewCell *cell = [[UITableViewCell alloc] init];
//        _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
//        _searchC.searchResultsUpdater = self;
//        _searchC.dimsBackgroundDuringPresentation = NO;
//        _searchC.hidesNavigationBarDuringPresentation = NO;
//        _searchC.searchBar.placeholder=@"药品关键字";
//        _searchC.searchBar.frame = CGRectMake(_searchC.searchBar.frame.origin.x, _searchC.searchBar.frame.origin.y, SCREEN_WIDTH-40, 44.0);
//        _searchC.searchBar.backgroundColor = [UIColor clearColor];
//        _searchC.searchBar.delegate = self;
////        tableView.tableHeaderView = _searchC.searchBar;
//
//        [cell addSubview:_searchC.searchBar];
//        return cell;
//    }else{
        MedicineItemTableViewCell *medItemCell = [tableView dequeueReusableCellWithIdentifier:@"MedicineItemTableViewCell"];
        [medItemCell refreshCell:self.hotItemArr[indexPath.row]];
        return medItemCell;
//    }
    
}

#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 0.1*self.bounds.size.height;
//    }
    return 0.21*self.bounds.size.height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.15*self.bounds.size.height;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *titleView = [[UIView alloc] init];
//    //    titleView.backgroundColor = [UIColor blueColor];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.03*SCREEN_WIDTH, 0.025*SCREEN_HEIGHT, 0.4*SCREEN_WIDTH, 0.04*SCREEN_HEIGHT)];
//    //    titleLabel.backgroundColor = [UIColor grayColor];
//    titleLabel.text = @"药品展示";
//    [titleLabel setTextColor:[UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0]];
//    [titleView addSubview:titleLabel];
//    
//    return titleView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotItem *hotItem = self.hotItemArr[indexPath.row];
    [self.delegate pushToMedicine:hotItem.itemName];
    
    
}
//#pragma mark --UISearchResultsUpdating
//-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString *searchString = [_searchC.searchBar text];
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    
//}
//#pragma mark--UISearchBarDelegate
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    //    [searchBar removeFromSuperview];
//    
//}

@end
