//
//  SlideTabBarView.m
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/25.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "SlideTabBarView.h"
#import "SlideBarCell.h"
#import "MedicineShowViewController.h"
#import "AFAppDotNetAPIClient.h"
#define TOPHEIGHT 40
@interface SlideTabBarView()<UIScrollViewDelegate,NSXMLParserDelegate>

@property (strong , nonatomic) UITextField *userTextField;

@property (strong , nonatomic) UITextField *pwdTextField;

@property (strong, nonatomic) NSMutableArray *returnData;
@property (strong, nonatomic) NSString *elementName;


///@brife 整个视图的大小
@property (assign) CGRect mViewFrame;

///@brife 下方的ScrollView
@property (strong, nonatomic) UIScrollView *scrollView;

///@brife 上方的按钮数组
@property (strong, nonatomic) NSMutableArray *topViews;

///@brife 下方的表格数组
@property (strong, nonatomic) NSMutableArray *scrollViews;

///@brife TableViews的数据源
@property (strong, nonatomic) NSMutableArray *dataSource;

///@brife 当前选中页数
@property (assign) NSInteger currentPage;

///@brife 下面滑动的View
@property (strong, nonatomic) UIView *slideView;

///@brife 上方的ScrollView
@property (strong, nonatomic) UIScrollView *topScrollView;

///@brife 上方的view
@property (strong, nonatomic) UIView *topMainView;
@end

@implementation SlideTabBarView

-(instancetype)initWithFrame:(CGRect)frame WithCount: (NSInteger) count{
    self = [super initWithFrame:frame];
    
    if (self) {
        _mViewFrame = frame;
        _tabCount = count;
        _topViews = [[NSMutableArray alloc] init];
        _scrollViews = [[NSMutableArray alloc] init];
        
        
        [self initScrollView];
        
        [self initTopTabs];
        
        [self initDownTables];
        
        
        [self initSlideView];
        
    }
    
    return self;
}


#pragma mark -- 初始化滑动的指示View
-(void) initSlideView{
    
    CGFloat width = _mViewFrame.size.width / 6;
    
    if(self.tabCount <=6){
        width = _mViewFrame.size.width / self.tabCount;
    }

    _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT - 5, width, 5)];
    [_slideView setBackgroundColor:[UIColor redColor]];
    [_topScrollView addSubview:_slideView];
}





#pragma mark -- 实例化ScrollView
-(void) initScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOPHEIGHT, _mViewFrame.size.width, _mViewFrame.size.height - TOPHEIGHT)];
    _scrollView.contentSize = CGSizeMake(_mViewFrame.size.width * _tabCount, _mViewFrame.size.height - 60);
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}



#pragma mark -- 实例化顶部的tab
-(void) initTopTabs{
    CGFloat width = _mViewFrame.size.width / 6;
    
    if(self.tabCount <=6){
        width = _mViewFrame.size.width / self.tabCount;
    }
    
    _topMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mViewFrame.size.width, TOPHEIGHT)];
    
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _mViewFrame.size.width, TOPHEIGHT)];
    
    _topScrollView.showsHorizontalScrollIndicator = NO;
    
    _topScrollView.showsVerticalScrollIndicator = YES;
    
    _topScrollView.bounces = NO;
    
    _topScrollView.delegate = self;
    
    if (_tabCount >= 6) {
        _topScrollView.contentSize = CGSizeMake(width * _tabCount, TOPHEIGHT);

    } else {
        _topScrollView.contentSize = CGSizeMake(_mViewFrame.size.width, TOPHEIGHT);
    }
    
    
    [self addSubview:_topMainView];
    
    [_topMainView addSubview:_topScrollView];
    
    
    
    for (int i = 0; i < _tabCount; i ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, width, TOPHEIGHT)];
        
        view.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
        
        if (i % 2) {
            view.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, TOPHEIGHT)];
        button.tag = i;
        if (button.tag == 0) {
            [button setTitle:@"登录" forState:UIControlStateNormal];
        }else if(button.tag == 1){
            [button setTitle:@"注册" forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(tabButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        [_topViews addObject:view];
        [_topScrollView addSubview:view];
    }
}



#pragma mark --点击顶部的按钮所触发的方法
-(void) tabButton: (id) sender{
    UIButton *button = sender;
    [_scrollView setContentOffset:CGPointMake(button.tag * _mViewFrame.size.width, 0) animated:YES];
}

#pragma mark --初始化下方的TableViews
-(void) initDownTables{
    
    for (int i = 0; i < 2; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * _mViewFrame.size.width, 0, _mViewFrame.size.width, _mViewFrame.size.height - TOPHEIGHT-TABBAR_HEIHGT)];
        self.autoresizesSubviews = YES;
        view.tag = i;
        if (view.tag == 0) {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.3*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT, 0.4*SCREEN_WIDTH, 0.025*SCREEN_HEIGHT)];
            titleLabel.text = @"裕林医药通";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont boldSystemFontOfSize:20];
            [view addSubview:titleLabel];
            
            UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.33*SCREEN_WIDTH, 0.13*SCREEN_HEIGHT, 0.34*SCREEN_WIDTH, 0.34*SCREEN_WIDTH)];
            titleImageView.image = [UIImage imageNamed:@"登录logo230.png"];
            [view addSubview:titleImageView];
            
            UITextField *userTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.11*SCREEN_WIDTH, 0.36*SCREEN_HEIGHT, 0.78*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
            userTextField.placeholder = @"用户名";
            userTextField.borderStyle = UITextBorderStyleRoundedRect;
            userTextField.rightViewMode = UITextFieldViewModeAlways;
            userTextField.layer.cornerRadius = 8.0f;
            userTextField.layer.masksToBounds = YES;
            userTextField.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
            userTextField.layer.borderWidth = 1.0f;
            [view addSubview:userTextField];
//            self.userTextField = userTextField;
            
            UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.11*SCREEN_WIDTH, 0.45*SCREEN_HEIGHT, 0.78*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
            pwdTextField.placeholder = @"密   码";
            pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
            pwdTextField.rightViewMode = UITextFieldViewModeAlways;
            pwdTextField.layer.cornerRadius = 8.0f;
            pwdTextField.layer.masksToBounds = YES;
            pwdTextField.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
            pwdTextField.layer.borderWidth = 1.0f;
            pwdTextField.secureTextEntry = true;
            [view addSubview:pwdTextField];
//            self.pwdTextField = pwdTextField;
            
            UIImageView *pwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.11*SCREEN_WIDTH, 0.53*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.06*SCREEN_WIDTH)];
            pwdImageView.backgroundColor = [UIColor greenColor];
            [view addSubview:pwdImageView];
            
            UIButton *pwdbutton = [[UIButton alloc] initWithFrame:CGRectMake(0.18*SCREEN_WIDTH, 0.53*SCREEN_HEIGHT, 0.18*SCREEN_WIDTH, 0.06*SCREEN_WIDTH)];
            [pwdbutton setTitle:@"忘记密码" forState:UIControlStateNormal];
            pwdbutton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [pwdbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [view addSubview:pwdbutton];
            
            UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0.06*SCREEN_WIDTH, 0.63*SCREEN_HEIGHT, 0.88*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
            [loginButton setTitle:@"登      录" forState:UIControlStateNormal];
            loginButton.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
            [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:loginButton];
        }
        [_scrollViews addObject:view];
        [_scrollView addSubview:view];
        

    }
    
}



//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

-(void)login:(id)sender{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.userTextField.text forKey:@"userName"];
    [parameters setObject:self.pwdTextField.text forKey:@"userPassword"];
    [parameters setObject:@"userLogin" forKey:@"returnType"];
    //    [[AFAppDotNetAPIClient sharedClient] POST:@"api_login.xml" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
    //        NSLog(@"%@",responseObject);
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        NSLog(@"%@",error);
    //    }];
    [[AFAppDotNetAPIClient sharedClient] GET:@"api_login.xml" parameters:parameters success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
        //        NSLog(@"%@",responseObject);
        responseObject.delegate = self;
        [responseObject parse];
        
        //获取用户输入的信息
        NSString *username = self.userTextField.text;
        NSString *password = self.pwdTextField.text;
        //对用户信息的验证
        if ([username isEqualToString:password]){
            //获取userDefault单例
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //登陆成功后把用户名和密码存储到UserDefault
            [userDefaults setObject:username forKey:@"name"];
            [userDefaults setObject:password forKey:@"password"];
            [userDefaults synchronize];
            //用模态跳转到主界面
            NSString *name = [userDefaults objectForKey:@"name"];
//            //创建发送通知
//            NSNotification *noti = [[NSNotification alloc] initWithName:@"loginRefresh" object:name userInfo:parameters];
//            [[NSNotificationCenter defaultCenter] postNotification:noti];
            
            [self.delegate pushToLogin:name];
            
//            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark --NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"解析开始！");
    self.returnData = [[NSMutableArray alloc] init];
    
}
//解析起始标记
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary*)attributeDict{
    if ([@"returnData" isEqualToString:elementName]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        [self.returnData addObject:tempDic];
    }else{
        self.elementName = elementName;
    }
}


//解析文本节点
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    //将string中的空格和换行去掉
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //如果去掉空格和换行的string等于@"";
    if ([string isEqualToString:@""]) {
        return;
    }
    NSMutableDictionary *tempDic = [self.returnData lastObject];
    [tempDic setObject:string forKey:self.elementName];
    
}
//解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    //    NSLog(@"结束标记：%@",elementName);
}
//文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"解析结束！");
    NSLog(@"%@",self.elementName);
    NSLog(@"%@",self.returnData);
    
}



#pragma mark -- scrollView的代理方法

-(void) modifyTopScrollViewPositiong: (UIScrollView *) scrollView{
    if ([_topScrollView isEqual:scrollView]) {
        CGFloat contentOffsetX = _topScrollView.contentOffset.x;
        
        CGFloat width = _slideView.frame.size.width;
        
        int count = (int)contentOffsetX/(int)width;
        
        CGFloat step = (int)contentOffsetX%(int)width;
        
        CGFloat sumStep = width * count;
        
        if (step > width/2) {
            
            sumStep = width * (count + 1);
            
        }
        
        [_topScrollView setContentOffset:CGPointMake(sumStep, 0) animated:YES];
        return;
    }

}

///拖拽后调用的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //[self modifyTopScrollViewPositiong:scrollView];
}



-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];


}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    if ([scrollView isEqual:_scrollView]) {
        _currentPage = _scrollView.contentOffset.x/_mViewFrame.size.width;
        
        _currentPage = _scrollView.contentOffset.x/_mViewFrame.size.width;

        return;
    }
    [self modifyTopScrollViewPositiong:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([_scrollView isEqual:scrollView]) {
        CGRect frame = _slideView.frame;
        
        if (self.tabCount <= 6) {
             frame.origin.x = scrollView.contentOffset.x/_tabCount;
        } else {
             frame.origin.x = scrollView.contentOffset.x/6;
            
        }
        
       
        _slideView.frame = frame;
    }
    
}



@end
