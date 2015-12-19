//
//  ShopChoiceTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ShopChoiceTableViewCell.h"
#import "SlideBarCell.h"
#import "ShopInfoForItemShow.h"
#import "ReturnDataItemShow.h"

@interface ShopChoiceTableViewCell ()<UITableViewDelegate,UITableViewDataSource>
{
    ShopInfoForItemShow *_shopInfoForItemShow;
    ReturnDataItemShow *_returnDataItemShow;
}

@property (nonatomic,strong) NSMutableArray *shopInfoArr;

@end

@implementation ShopChoiceTableViewCell

- (void)refreshCell:(ReturnDataItemShow *)returnDataItemShow{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,0.33*SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableView];
    
    UINib *slideBarNib = [UINib nibWithNibName:@"SlideBarCell" bundle:nil];
    [tableView registerNib:slideBarNib forCellReuseIdentifier:@"SlideBarCell"];
    
    self.shopInfoArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.shopInfoArr = returnDataItemShow.sh;
    
    _returnDataItemShow = returnDataItemShow;
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopInfoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SlideBarCell *slideBarCell = [tableView dequeueReusableCellWithIdentifier:@"SlideBarCell"];
    _shopInfoForItemShow = _returnDataItemShow.sh[indexPath.row];
    [slideBarCell refreshCell:_shopInfoForItemShow];
    return slideBarCell;
}



#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.12*SCREEN_HEIGHT;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
