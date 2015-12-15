//
//  AFAppDotNetAPIClient.m
//  afnXmltest
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AFAppDotNetAPIClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = @"http://adobeflash.duapp.com/appYulin/xmlAPI/";
//static NSString * const AFAppDotNetAPIBaseURLString = @"http://api.yulinfw100.com/mde/";

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer = [AFXMLParserResponseSerializer serializer];
    });
    
    return _sharedClient;
}
@end
