//
//  BtnTableViewCell.m
//  ylyyt
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BtnTableViewCell.h"
#import "Menu.h"
#import "MainPage.h"

@interface BtnTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    MainPage *_mainPage;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, strong) NSMutableArray *btnArrLabel;



@end

@implementation BtnTableViewCell

- (void)refreshCell:(MainPage*)mainPage{
    _mainPage = mainPage;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    self.btnArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.btnArrLabel = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 4; i++) {
        Menu *menu = _mainPage.me[i];
        NSString *imageName= [NSString stringWithFormat:@"%@",menu.imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        if (UIInterfaceOrientationPortrait == orientation) {
            //6,6s
            if (SCREEN_WIDTH == 375.0f) {
                imageView.frame = CGRectMake(5, 0, 70, 70);
            }else if (SCREEN_WIDTH == 320.0f){
                //4s
                if (SCREEN_HEIGHT == 480.0f) {
                    imageView.frame = CGRectMake(0, 0, 55, 55);
                    //5,5s
                }else{
                    imageView.frame = CGRectMake(0, 0, 60, 60);
                }
            }else if (SCREEN_WIDTH == 414.0f){
                imageView.frame = CGRectMake(5, 0, 70, 70);
            }
        }
        
        
        [self.btnArr addObject:imageView];
        [self.btnArrLabel addObject:menu.menuName];
    }

}

- (void)awakeFromNib {
    // Initialization code
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
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 0.18*SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    [self addSubview:self.collectionView];
    
    

}
#pragma mark --UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = self.btnArr[indexPath.row];
   [cell addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationPortrait == orientation) {
        //6,6s
        if (SCREEN_WIDTH == 375.0f) {
            label.frame = CGRectMake(5, 50, 70, 70);
        }else if (SCREEN_WIDTH == 320.0f){
            //4s
            if (SCREEN_HEIGHT == 480.0f) {
                label.frame = CGRectMake(0, 35, 55, 55);
                label.font = [UIFont boldSystemFontOfSize:13.0f];
            //5,5s
            }else{
                label.frame = CGRectMake(0, 40, 60, 60);
                label.font = [UIFont boldSystemFontOfSize:15.0f];
            }
        }else if (SCREEN_WIDTH == 414.0f){
            label.frame = CGRectMake(5, 50, 70, 70);
        }
    }
    label.text = self.btnArrLabel[indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
//    [label setAdjustsFontSizeToFitWidth:YES];
    [cell addSubview:label];

    return cell;
}
#pragma mark --UICollectionViewDelegate  
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate btnFunction:indexPath.row];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (SCREEN_WIDTH == 414.0f) {
        return CGSizeMake(70, 70);
    }
    return CGSizeMake(50, 50);
}

@end
