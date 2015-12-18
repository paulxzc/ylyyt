//
//  MainPage.h
//  afnXmltest
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Banner;
@class Menu;
@class News;
@class HotItem;

@interface MainPage : NSObject
{
    NSMutableArray *_ba;
    NSMutableArray *_me;
    NSMutableArray *_ne;
    NSMutableArray *_ho;
}

@property (nonatomic, retain) NSMutableArray *ba;
@property (nonatomic, retain) NSMutableArray *me;
@property (nonatomic, retain) NSMutableArray *ne;
@property (nonatomic, retain) NSMutableArray *ho;

//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic;

//工厂方法
+ (MainPage*)mainPageWithDic:(NSDictionary*)dic;

@end
