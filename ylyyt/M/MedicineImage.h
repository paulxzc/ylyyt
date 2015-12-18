//
//  MedicineImage.h
//  afnXmltest
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicineImage : NSObject
{
    NSString *_imageName;
    NSString *_imageDescribe;
}

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageDescribe;

- (instancetype)initWithDic:(NSDictionary*)dic;

+ (MedicineImage *)medicineImageWithDic:(NSDictionary*)dic;
@end
