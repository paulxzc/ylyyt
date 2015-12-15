//
//  RegisterViewController.m
//  ylyyt
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "TSPopoverController.h"
#import "ImageTool.h"

@interface RegisterViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用户注册";
    
    UIView *navigateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    navigateView.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    [self.view addSubview:navigateView];
    
    UILabel *navigateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.3*SCREEN_WIDTH, 0.5*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, 0.4*SCREEN_WIDTH,0.3*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    navigateLabel.backgroundColor = [UIColor clearColor];
    navigateLabel.text = @"用户注册";
    navigateLabel.textAlignment = NSTextAlignmentCenter;
    navigateLabel.textColor = [UIColor whiteColor];
    [navigateView addSubview:navigateLabel];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(5,0.5*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT , 0.4*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, 0.3*NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    [backBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(backToHealthVC) forControlEvents:UIControlEventTouchUpInside];
    [navigateView addSubview:backBtn];
    
    self.view.backgroundColor = [UIColor colorWithRed:233/255.0 green:254/255.0 blue:229/255.0 alpha:1.0];
    
//    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.4*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+20, 0.2*SCREEN_WIDTH, 0.125*SCREEN_HEIGHT)];
//    self.iconImageView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:self.iconImageView];
//    
//    UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.4*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+20, 0.2*SCREEN_WIDTH, 0.125*SCREEN_HEIGHT)];
//    iconBtn.backgroundColor = [UIColor clearColor];
//    [iconBtn addTarget:self action:@selector(showIconPopover:forEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:iconBtn];
//
//                                                                   
//    
    UITextField *userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.1*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+0.05*SCREEN_HEIGHT, 0.8*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    userNameTextField.placeholder = @"手机号" ;
    userNameTextField.font = [UIFont boldSystemFontOfSize:12];
    UIImageView *imageViewUser = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_16.png"]];
    userNameTextField.leftView = imageViewUser;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    userNameTextField.layer.cornerRadius = 8.0f;
    userNameTextField.layer.masksToBounds = YES;
    userNameTextField.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
    userNameTextField.layer.borderWidth = 1.0f;
    [self.view addSubview:userNameTextField];
    
    UITextField *phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.1*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+0.13*SCREEN_HEIGHT, 0.8*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    phoneTextField.placeholder = @"请输入手机短信中的验证码" ;
    phoneTextField.font =[UIFont boldSystemFontOfSize:12];
    UIImageView *imageViewPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mail_16.png"]];
    phoneTextField.leftView = imageViewPhone;
    phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    phoneTextField.layer.cornerRadius = 8.0f;
    phoneTextField.layer.masksToBounds = YES;
    phoneTextField.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
    phoneTextField.layer.borderWidth = 1.0f;
    [self.view addSubview:phoneTextField];
    
    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.68*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+0.13*SCREEN_HEIGHT+4, 0.2*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT-8)];
    [phoneBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    phoneBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    [self.view addSubview:phoneBtn];

    UITextField *pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.1*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+0.21*SCREEN_HEIGHT, 0.8*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    pwdTextField.placeholder = @"请输入密码";
    pwdTextField.font = [UIFont boldSystemFontOfSize:12];
    UIImageView *imageViewPwd = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_16.png"]];
    pwdTextField.leftView = imageViewPwd;
    pwdTextField.leftViewMode = UITextFieldViewModeAlways;
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    pwdTextField.layer.cornerRadius = 8.0f;
    pwdTextField.layer.masksToBounds = YES;
    pwdTextField.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
    pwdTextField.layer.borderWidth = 1.0f;
    [self.view addSubview:pwdTextField];
    
    UITextField *pwdTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(0.1*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+0.29*SCREEN_HEIGHT, 0.8*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    pwdTextField1.placeholder = @"请再次输入密码";
    pwdTextField1.font = [UIFont boldSystemFontOfSize:12];
    UIImageView *imageViewPwd1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_16.png"]];
    pwdTextField.leftView = imageViewPwd1;
    pwdTextField1.leftView = imageViewPwd;
    pwdTextField1.leftViewMode = UITextFieldViewModeAlways;
    pwdTextField1.borderStyle = UITextBorderStyleRoundedRect;
    pwdTextField1.layer.cornerRadius = 8.0f;
    pwdTextField1.layer.masksToBounds = YES;
    pwdTextField1.layer.borderColor = [UIColor colorWithRed:156/255.0 green:207/255.0 blue:144/255.0 alpha:1.0].CGColor;
    pwdTextField1.layer.borderWidth = 1.0f;
    [self.view addSubview:pwdTextField1];

    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.1*SCREEN_WIDTH, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT+0.4*SCREEN_HEIGHT, 0.8*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    [registerBtn setTitle:@"注      册" forState:UIControlStateNormal];
    registerBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
    [self.view addSubview:registerBtn];
    
}





- (void)backToHealthVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showIconPopover:(id)sender forEvent:(UIEvent*)event{
    
//    UIViewController *VC = [[UIViewController alloc] init];
//    VC.view.frame = CGRectMake(0, 0, 0.65*SCREEN_WIDTH, 0.14*SCREEN_HEIGHT);
//    VC.view.backgroundColor = [UIColor whiteColor];
//    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:VC];
//    
//    UIButton *chooseIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 0.65*SCREEN_WIDTH-10, 0.05*SCREEN_HEIGHT)];
//    chooseIconBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
//    [chooseIconBtn setTitle:@"选择图片" forState:UIControlStateNormal];
//    [chooseIconBtn addTarget:self action:@selector(chooseIcon:) forControlEvents:UIControlEventTouchUpInside];
//    [VC.view addSubview:chooseIconBtn];
//    
//    UIButton *photoIconBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 20+0.05*SCREEN_HEIGHT, 0.65*SCREEN_WIDTH-10, 0.05*SCREEN_HEIGHT)];
//    photoIconBtn.backgroundColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
//    [photoIconBtn setTitle:@"自拍图片" forState:UIControlStateNormal];
//    [photoIconBtn addTarget:self action:@selector(photoIcon) forControlEvents:UIControlEventTouchUpInside];
//    [VC.view addSubview:photoIconBtn];
//    
//    popoverController.cornerRadius = 5;
//    popoverController.titleText = @"选择头像方式";
//    popoverController.popoverBaseColor = [UIColor colorWithRed:89/255.0 green:185/255.0 blue:46/255.0 alpha:1.0];
//    popoverController.popoverGradient= YES;
//    popoverController.arrowPosition = TSPopoverArrowPositionVertical;
//    [popoverController showPopoverWithTouch:event];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择头像方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *chooseIconAction = [UIAlertAction actionWithTitle:@"选择图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{
            [self showAlertWithMessage:@"无法获取相册库"];
        }
    }];
    UIAlertAction *photoIconAction = [UIAlertAction actionWithTitle:@"自拍图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }else{
            [self showAlertWithMessage:@"相机无法使用"];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:chooseIconAction];
    [alert addAction:photoIconAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    

}

- (void)chooseIcon:(UIButton *)btn{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }else{
        [self showAlertWithMessage:@"无法获取相册库"];
    }
}

- (void)photoIcon{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        [self showAlertWithMessage:@"相机无法使用"];
    }
}

- (void)loadImagePickerWithSourceType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //加载不同资源
    picker.sourceType = type;
    //是否允许picker对图片资源进行优化
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
    }];
}

- (void)showAlertWithMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:OKAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
//点击cancel
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//点击choose
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //kUTTypeImage 代表图片资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage *smallImage = [[ImageTool shareTool] resizeImageToSize:CGSizeMake(0.2*SCREEN_WIDTH, 0.125*SCREEN_HEIGHT) sizeOfImage:image];
        self.iconImageView.image = smallImage;
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
