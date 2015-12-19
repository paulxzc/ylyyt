//
//  Menu.m
//  afnXmltest
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "Menu.h"

@implementation Menu

//当字典中有key，但是数据模型里面没有对应key的属性，这种情况会调用下面的方法，可以处理一些特殊情况
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
//防止别人利用kvc来读取数据模型的属性，当属性不存在时，如果不重写下面的方法，程序会发生崩溃
- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}
//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
//    if (self = [super init]) {
//        self.imageName = dic[@imageName];
//        self.menuName = dic[@menuName];
//    }

    return self;
}

//工厂方法
+ (Menu*)menuWithDic:(NSDictionary*)dic{
    Menu *menu = [[Menu alloc] initWithDic:dic];
    return menu;
}

@end
