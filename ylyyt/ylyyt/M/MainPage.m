//
//  MainPage.m
//  afnXmltest
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MainPage.h"
#import "Banner.h"
#import "HotItem.h"
#import "Menu.h"
#import "News.h"

@implementation MainPage

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"banner"]) {
        NSArray *banners = value;
        [banners enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Banner *banner = [Banner bannerWithDic:obj];
            [_ba addObject:banner];
        }];
    }
    if ([key isEqualToString:@"hotItem"]) {
        NSArray *hotItems = value;
        [hotItems enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HotItem *hotItem = [HotItem hotItemWithDic:obj];
            [_ho addObject:hotItem];
        }];
    }
    if ([key isEqualToString:@"menu"]) {
        NSArray *menus = value;
        [menus enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Menu *menu = [Menu menuWithDic:obj];
            [_me addObject:menu];
        }];
    }
    if ([key isEqualToString:@"news"]) {
        NSArray *newss = value;
        [newss enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            News *news = [News newsWithDic:obj];
            [_ne addObject:news];
        }];
    }
}

//防止别人利用kvc来读取数据模型的属性，当属性不存在时，如果不重写下面的方法，程序会发生崩溃
- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}

//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        _ba = [[NSMutableArray alloc] initWithCapacity:0];
        _ho = [[NSMutableArray alloc] initWithCapacity:0];
        _me = [[NSMutableArray alloc] initWithCapacity:0];
        _ne = [[NSMutableArray alloc] initWithCapacity:0];
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

//工厂方法
+ (MainPage*)mainPageWithDic:(NSDictionary*)dic{
    MainPage *mainPage = [[MainPage alloc] initWithDic:dic];
    return mainPage;
}
@end
