//
//  Banner.h
//  afnXmltest
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject
{
     id _imageName;
    NSString *_linkUrl;
}

@property (nonatomic, copy) id imageName;
@property (nonatomic, copy) NSString *linkUrl;

- (instancetype)initWithDic:(NSDictionary*)dic;

+ (Banner *)bannerWithDic:(NSDictionary*)dic;

@end
