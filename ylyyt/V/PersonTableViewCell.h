//
//  PersonTableViewCell.h
//  yylyytv1
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol showIconDelegate <NSObject>

- (void)showIconAlert:(UIAlertController *)alert;

@end

@protocol showPickerDeleagate <NSObject>

- (void)showImagePicker:(UIImagePickerController *)picker andImageView:(UIImageView *)imageView;

@end

@protocol  showMessageDelegate <NSObject>

- (void)showAlertMessage:(UIAlertController *)message;

@end

@class LoginSuccess;

@interface PersonTableViewCell : UITableViewCell

@property (nonatomic, retain) id<showIconDelegate> delegate;

@property (nonatomic, retain) id<showPickerDeleagate> delegatePicker;

@property (nonatomic, retain) id<showMessageDelegate> delegateMessage;

- (void)refreshCell:(LoginSuccess *)loginSuccess;

@end
