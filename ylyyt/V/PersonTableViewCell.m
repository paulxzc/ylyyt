//
//  PersonTableViewCell.m
//  yylyytv1
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "PersonTableViewCell.h"
#import "LoginSuccess.h"
#import "TSPopoverController.h"
#import "ImageTool.h"

@interface PersonTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)showPop:(id)sender;

@end

@implementation PersonTableViewCell

- (void)refreshCell:(LoginSuccess *)loginSuccess{
    
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIconPopover:forEvent:)];
//    [self.iconImageView addGestureRecognizer:tap];
    
//    UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    iconBtn.backgroundColor = [UIColor blackColor];
//    [iconBtn addTarget:self action:@selector(showIconPopover:forEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [self.iconImageView addSubview:iconBtn];
    
    self.nameLabel.text = [NSString stringWithFormat:@"用户名:%@",loginSuccess.UserName];
    self.phoneLabel.text = [NSString stringWithFormat:@"联系电话:%@",loginSuccess.UserPhone];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@",loginSuccess.UserAddress];
    
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showIconPopover:(id)sender forEvent:(UIEvent*)event{
    
    
  
    
    
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
    [self.delegatePicker showImagePicker:picker andImageView:self.iconImageView];
//    picker.delegate = self;
//    
//    [self presentViewController:picker animated:YES completion:^{
//    }];
}

- (void)showAlertWithMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:OKAction];
    [self.delegateMessage showAlertMessage:alert];
//    [self presentViewController:alert animated:YES completion:nil];
}



- (IBAction)showPop:(id)sender {
    
    NSLog(@"---------------");
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
    [self.delegate showIconAlert:alert];
    //    [self presentViewController:alert animated:YES completion:nil];
}
@end
