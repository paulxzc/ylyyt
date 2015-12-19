//
//  MapViewController.m
//  ylyyt
//
//  Created by apple on 15/10/28.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
<<<<<<< HEAD
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapView *_mapView;
    BMKLocationService * _locService;
    BMKGeoCodeSearch *_search;
=======

@interface MapViewController ()<BMKMapViewDelegate>
{
    BMKMapView *_mapView;
>>>>>>> f1073a416403924c68e21506c0afbceb4f7d8962
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = _mapView;
<<<<<<< HEAD
    
    //切换为普通地图
    [_mapView setMapType:BMKMapTypeStandard];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
//    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
//    [BMKLocationService setLocationDistanceFilter:100.f];
    _locService.distanceFilter = 100.f;
    
    
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

//实现相关delegate 处理位置信息更新

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}


//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    //以下_mapView为BMKMapView对象
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
//    BMKCoordinateRegion region;
//    region.center.latitude  = userLocation.location.coordinate.latitude;
//    region.center.longitude = userLocation.location.coordinate.longitude;
//    region.span.latitudeDelta  = 0.2;
//    region.span.longitudeDelta = 0.2;
//    if (_mapView)
//    {
//        _mapView.region = region;
//        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    }
//    
//    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude};
//    
//    _search = [[BMKGeoCodeSearch alloc] init];
//    _search.delegate = self;
//    
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//    
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;
//    
//    BOOL flag = [_search reverseGeoCode:reverseGeocodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//    }
    
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    //    [_mapView removeAnnotations:array];
    //    array = [NSArray arrayWithArray:_mapView.overlays];
    //    [_mapView removeOverlays:array];
    //    if (error == 0) {
    //        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    //        item.coordinate = result.location;
    //        item.title = result.address;
    //        [_mapView addAnnotation:item];
    //        _mapView.centerCoordinate = result.location;
    //        NSString* titleStr;
    //        NSString* showmeg;
    //        titleStr = @"反向地理编码";
    //        showmeg = [NSString stringWithFormat:@"%@",item.title];
    //
    //
    //        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    //        [myAlertView show];
    //    }
    
    NSLog(@"%@",result.address);
    
    _search.delegate = nil;
    
    
}



=======
}

>>>>>>> f1073a416403924c68e21506c0afbceb4f7d8962
- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    if (name == nil) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [_mapView viewWillAppear];
        _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
<<<<<<< HEAD
    _search.delegate = nil;
}


=======
}
>>>>>>> f1073a416403924c68e21506c0afbceb4f7d8962
@end
