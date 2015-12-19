//
//  SubCatalog.h
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCatalog : NSObject
{
    NSString *_catalogName;
    NSString *_catalogIcon;
}

@property (nonatomic, strong) NSString *catalogName;
@property (nonatomic, strong) NSString *catalogIcon;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (SubCatalog *)subCatalogWithDic:(NSDictionary *)dic;
@end
