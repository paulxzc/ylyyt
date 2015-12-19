//
//  ExplainViewController.m
//  yylyytv1
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ExplainViewController.h"
#import "ReturnDataItemShow.h"
#import "MedicineItemDetail.h"

@interface ExplainViewController ()

@end

@implementation ExplainViewController

- (void)refreshVC:(ReturnDataItemShow *)returnDataItemShow{
    
    self.navigationItem.title = @"药品说明书";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑on.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pushToMedicineTableView)];
//    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
//    self.navigationItem.rightBarButtonItem = closeItem;
    
    _returnDataItemShow = returnDataItemShow;
    
    MedicineItemDetail *medicineItemDetail = _returnDataItemShow.it[0];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIHGT-NAVIGATION_HEIGHT_ADD_STATUS_HEIGHT)];
    textView.text = medicineItemDetail.itemDescribe;
    [self.view addSubview:textView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
