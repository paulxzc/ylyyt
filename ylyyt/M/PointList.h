//
//  PointList.h
//  ylyyt
//
//  Created by apple on 15/12/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointList : NSObject
{
    NSString *_idd;
    NSString *_totalPoint;
    NSString *_minPoint;
    NSString *_restPoint;
    NSString *_shopLogo;
}

@property (nonatomic, strong) NSString *idd;
@property (nonatomic, strong) NSString *totalPoint;
@property (nonatomic, strong) NSString *minPoint;
@property (nonatomic, strong) NSString *restPoint;
@property (nonatomic, strong) NSString *shopLogo;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (PointList *)pointListWithDic:(NSDictionary *)dic;

@end
