//
//  LoginViewController.m
//  ylyyt
//
//  Created by apple on 15/10/15.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RegisterViewController.h"
#import "HealthViewController.h"
#import "AFAppDotNetAPIClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "LoginSuccess.h"

@interface LoginViewController ()<NSXMLParserDelegate>

@property (strong , nonatomic) UITextField *userTextField;

@property (strong , nonatomic) UITextField *pwdTextField;

@property (strong, nonatomic) NSMutableArray *returnData;
@property (strong, nonatomic) NSString *elementName;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib. 
//    self.navigationItem.title = @"用户登录";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(pushToRegisterVC)];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景.png"]];
    
    UIView *navigateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    navigateView.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    [self.view addSubview:navigateView];
    
    UILabel *navigateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.3*SCREEN_WIDTH, 0.5*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, 0.4*SCREEN_WIDTH,0.3*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    navigateLabel.backgroundColor = [UIColor clearColor];
    navigateLabel.text = @"用户登录";
    navigateLabel.textAlignment = NSTextAlignmentCenter;
    navigateLabel.textColor = [UIColor whiteColor];
    [navigateView addSubview:navigateLabel];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(5,0.5*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT , 0.4*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, 0.3*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    [backBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backToHealthVC) forControlEvents:UIControlEventTouchUpInside];
    [navigateView addSubview:backBtn];
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.85*SCREEN_WIDTH, 0.5*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT,
                                                                       0.6*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, 0.3*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor clearColor];
    [registerBtn addTarget:self action:@selector(pushToRegisterVC) forControlEvents:UIControlEventTouchUpInside];
    [navigateView addSubview:registerBtn];
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.3*SCREEN_WIDTH, 0.17*SCREEN_HEIGHT, 0.4*SCREEN_WIDTH, 0.025*SCREEN_HEIGHT)];
    titleLabel.text = @"裕林医药通";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:titleLabel];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.33*SCREEN_WIDTH, 0.25*SCREEN_HEIGHT, 0.34*SCREEN_WIDTH, 0.34*SCREEN_WIDTH)];
    titleImageView.image = [UIImage imageNamed:@"登录logo230.png"];
    [self.view addSubview:titleImageView];
    
    UITextField *userTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.11*SCREEN_WIDTH, 0.48*SCREEN_HEIGHT, 0.78*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    userTextField.placeholder = @"用户名";
    userTextField.borderStyle = UITextBorderStyleRoundedRect;
    userTextField.rightViewMode = UITextFieldViewModeAlways;
    userTextField.layer.cornerRadius = 8.0f;
    userTextField.layer.masksToBounds = YES;
    userTextField.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
    userTextField.layer.borderWidth = 1.0f;
    [self.view addSubview:userTextField];
    self.userTextField = userTextField;
    
    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.11*SCREEN_WIDTH, 0.57*SCREEN_HEIGHT, 0.78*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    pwdTextField.placeholder = @"密   码";
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    pwdTextField.rightViewMode = UITextFieldViewModeAlways;
    pwdTextField.layer.cornerRadius = 8.0f;
    pwdTextField.layer.masksToBounds = YES;
    pwdTextField.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
    pwdTextField.layer.borderWidth = 1.0f;
    pwdTextField.secureTextEntry = true;
    [self.view addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    UIImageView *pwdImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.11*SCREEN_WIDTH, 0.65*SCREEN_HEIGHT, 0.06*SCREEN_WIDTH, 0.06*SCREEN_WIDTH)];
    pwdImageView.image = [UIImage imageNamed:@"pwd.png"];
    [self.view addSubview:pwdImageView];
    
    UIButton *pwdbutton = [[UIButton alloc] initWithFrame:CGRectMake(0.18*SCREEN_WIDTH, 0.65*SCREEN_HEIGHT, 0.18*SCREEN_WIDTH, 0.06*SCREEN_WIDTH)];
    [pwdbutton setTitle:@"忘记密码" forState:UIControlStateNormal];
    pwdbutton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [pwdbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:pwdbutton];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0.06*SCREEN_WIDTH, 0.75*SCREEN_HEIGHT, 0.88*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    [loginButton setTitle:@"登      录" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
}


- (void)pushToRegisterVC{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
//    [self.navigationController pushViewController:registerVC animated:YES];
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)backToHealthVC{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)pushToLogin:(NSString *)name{
    
    //创建发送通知
    NSNotification *noti = [[NSNotification alloc] initWithName:@"loginRefresh" object:name userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    //获取用户输入的信息
    NSString *username = self.userTextField.text;
    NSString *password = self.pwdTextField.text;
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:@"用户名或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
//        [[AFAppDotNetAPIClient sharedClient] GET:@"http://adobeflash.duapp.com/appYulin/xmlAPI/api_login.xml" parameters:parameters success:^(NSURLSessionDataTask *task, NSXMLParser *responseObject) {
//            //        NSLog(@"%@",responseObject);
//            responseObject.delegate = self;
//            [responseObject parse];
//            
//            //对用户信息的验证
//            if ([username isEqualToString:password]){
//                //获取userDefault单例
//                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                //登陆成功后把用户名和密码存储到UserDefault
//                [userDefaults setObject:username forKey:@"name"];
//                [userDefaults setObject:password forKey:@"password"];
//                [userDefaults synchronize];
//                //用模态跳转到主界面
//                NSString *name = [userDefaults objectForKey:@"name"];
//                //创建发送通知
//                NSNotification *noti = [[NSNotification alloc] initWithName:@"loginRefresh" object:name userInfo:parameters];
//                [[NSNotificationCenter defaultCenter] postNotification:noti];
//                
//                [self dismissViewControllerAnimated:YES completion:nil];
//                
//            }
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];//设置相应内容类型
        [manager POST:@"http://api.yulinfw100.com/mde/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
            
//            LoginSuccess *loginSuccess = [LoginSuccess loginSuccessWithDic:responseObject];
//            NSLog(@"%@",loginSuccess);
            
            //对用户信息的验证
            if ([username isEqualToString:password]){
                //获取userDefault单例
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                //登陆成功后把用户名和密码存储到UserDefault
                [userDefaults setObject:username forKey:@"name"];
                [userDefaults setObject:password forKey:@"password"];
                [userDefaults setObject:responseObject forKey:@"userInfo"];
                [userDefaults synchronize];
                //用模态跳转到主界面
                NSString *name = [userDefaults objectForKey:@"name"];
                //创建发送通知
                NSNotification *noti = [[NSNotification alloc] initWithName:@"loginRefresh" object:name userInfo:responseObject];
                [[NSNotificationCenter defaultCenter] postNotification:noti];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];

        
        

//        [[AFAppDotNetAPIClient sharedClient] POST:@"login" parameters:parameters success:^(NSURLSessionDataTask *task,NSXMLParser *responseObject) {
//            //            responseObject.delegate = self;
//            //            [responseObject parse];
//            
//            NSLog(@"%@",responseObject);
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];



    }
    
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

@end
