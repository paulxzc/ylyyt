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

@interface MapViewController ()<BMKMapViewDelegate>
{
    BMKMapView *_mapView;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = _mapView;
}

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
}
@end
