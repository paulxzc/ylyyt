//
//  ReturnData.h
//  ylyyt
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MedicineItem;

@interface ReturnData : NSObject
{
    NSMutableArray *_it;
    NSString *_returnType;
}

@property (nonatomic, strong) NSMutableArray *it;
@property (nonatomic, strong) NSString *returnType;


//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic;

//工厂方法
+ (ReturnData*)returnDataWithDic:(NSDictionary*)dic;
@end
