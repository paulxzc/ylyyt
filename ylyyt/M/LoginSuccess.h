//
//  LoginSuccess.h
//  ylyyt
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginSuccess : NSObject
{
    NSString *_IsLogin;
    NSString *_ReturnType;
    NSString *_UserAddress;
    NSString *_UserName;
    NSString *_UserPhone;
    NSString *_UserRole;
}

@property (nonatomic, copy) NSString *IsLogin;
@property (nonatomic, copy) NSString *ReturnType;
@property (nonatomic, copy) NSString *UserAddress;
@property (nonatomic, copy) NSString *UserName;
@property (nonatomic, copy) NSString *UserPhone;
@property (nonatomic, copy) NSString *UserRole;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (LoginSuccess *)loginSuccessWithDic:(NSDictionary *)dic;

@end
