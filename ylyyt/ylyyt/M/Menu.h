//
//  Menu.h
//  afnXmltest
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject


@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *menuName;

//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic;

//工厂方法
+ (Menu*)menuWithDic:(NSDictionary*)dic;

@end
