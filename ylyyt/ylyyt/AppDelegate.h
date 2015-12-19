//
//  AppDelegate.h
//  yylyytv1
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BMKMapManager *_mapManager;
}


@property (strong, nonatomic) UIWindow *window;

@end

