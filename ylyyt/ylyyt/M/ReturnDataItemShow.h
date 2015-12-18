//
//  ReturnDataItemShow.h
//  afnXmltest
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MedicineImage;
@class MedicineItemDetail;
@class ShopInfoForItemShow;
@interface ReturnDataItemShow : NSObject
{
    NSMutableArray *_it;
    NSMutableArray *_im;
    NSMutableArray *_sh;
}

@property (nonatomic, retain) NSMutableArray *it;
@property (nonatomic, retain) NSMutableArray *im;
@property (nonatomic, retain) NSMutableArray *sh;

//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic;

//工厂方法
+ (ReturnDataItemShow*)returnDataItemShowWithDic:(NSDictionary*)dic;
@end
