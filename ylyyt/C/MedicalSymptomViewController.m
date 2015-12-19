//
//  MedicalSymptomViewController.m
//  ylyyt
//
//  Created by apple on 15/11/11.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "MedicalSymptomViewController.h"

@interface MedicalSymptomViewController ()<UIWebViewDelegate>

@end

@implementation MedicalSymptomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"病症详情解析";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"http://baike.baidu.com/link?url=Pw8cERNAGkFd_2qCB9XLUS-Ydg6-SJRT8WR0C4OkRqIMx5CyDfw_ZLMnExxNYYK3"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.opaque = NO;
    
    [webView loadRequest:request];
    
    
    [webView goBack];
    [webView goForward];
    [webView reload];//重载
//    [webView stopLoading];//取消载入内容
    
    [self removeGradientBgColorOfWebView:webView];
}

- (void)removeGradientBgColorOfWebView:(UIWebView*)aWebView{
    NSArray *subViews = aWebView.subviews;
    for (UIView* subView in subViews){
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView* shadowView in [subView subviews]){
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    [shadowView setHidden:YES];
                }
            }
        }
    }
}

#pragma mark --UIWebViewDelegate


@end
