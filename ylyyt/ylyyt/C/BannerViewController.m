//
//  BannerViewController.m
//  ylyyt
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BannerViewController.h"

@interface BannerViewController ()

@end

@implementation BannerViewController

- (void)refreshVC:(NSString *)linkUrl{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT-TABBAR_HEIHGT)];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:linkUrl]]];
    // 裕林公众号
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://tingyu.org/wa1/mobile.php?act=channel&name=index&weid=36#"]]];
    //wps转网页
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://htmlify.wps.cn/doc/index.html?ts=1449801692800&url=http%3A%2F%2Fh5-share.kss.ksyun.com%2FMjQ3ZjJkMjIyNGYyNmQ3ODMyMmEyYmI2MDc1MDM5YzA%3D_folder%2FwpsIndex_clear.html"]]];
    //有道云笔记
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://note.youdao.com/share/?id=7b2397fd57a217e96bf1d4a7bbec446b&type=note"]]];
    //秀够
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.91goshare.com/r/BjC"]]];
    
//    //word转pdf
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"吉林大药房年终大促 上午10.25.07" ofType:@"pdf"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [webView loadRequest:request];
    //秀米微信图文编辑网页转url传
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://v.xiumi.us/board/v5/2xik2/7759244"]]];
    
    [self.view addSubview:webView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
