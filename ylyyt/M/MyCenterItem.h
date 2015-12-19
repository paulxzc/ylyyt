//
//  MyCenterItem.h
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCenterItem : NSObject
{
    NSString *_itemName;
    NSString *_itemIcon;
    NSString *_pageCode;
}

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemIcon;
@property (nonatomic, strong) NSString *pageCode;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (MyCenterItem *)mycenterItemWithDic:(NSDictionary *)dic;

@end
