//
//  ScanViewController.m
//  ylyyt
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DrugStoreDetailViewController.h"

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    NSTimer *_timer;
}

@property ( strong , nonatomic ) AVCaptureDevice * device;

@property ( strong , nonatomic ) AVCaptureDeviceInput * input;

@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;

@property ( strong , nonatomic ) AVCaptureSession * session;

@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * preview;

@property ( strong , nonatomic ) UILabel *label;

@property (strong, nonatomic) UIView *boxView;

@property (strong, nonatomic) CALayer *scanLayer;

//-(BOOL)startReading;
//-(void)stopReading;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"扫描药店二维码";
    
    // Device
    _device = [ AVCaptureDevice defaultDeviceWithMediaType : AVMediaTypeVideo ];
    // Input
    _input = [ AVCaptureDeviceInput deviceInputWithDevice : self . device error : nil ];
    // Output
    _output = [[ AVCaptureMetadataOutput alloc ] init ];
    // Session
    _session = [[ AVCaptureSession alloc ] init ];
    [ _session setSessionPreset : AVCaptureSessionPresetHigh ];
    if ([ _session canAddInput : self . input ])
    {
        [ _session addInput : self . input ];
    }
    if ([ _session canAddOutput : self . output ])
    {
        [ _session addOutput : self . output ];
    }
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [ _output setMetadataObjectsDelegate : self queue : dispatchQueue];
    // 条码类型 AVMetadataObjectTypeQRCode
    _output . metadataObjectTypes = @[ AVMetadataObjectTypeQRCode] ;
    // Preview
    _preview =[ AVCaptureVideoPreviewLayer layerWithSession : _session ];
    _preview . videoGravity = AVLayerVideoGravityResizeAspectFill ;
//    _preview . frame = self.view . layer . bounds ;
    _preview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view.layer insertSublayer:_preview atIndex:0];
    _output.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.2f, SCREEN_HEIGHT*0.2f, SCREEN_WIDTH-SCREEN_WIDTH*0.4f, SCREEN_HEIGHT-SCREEN_HEIGHT*0.6f)];
    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [self.view addSubview:_boxView];
    
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor redColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    _timer = timer;
    [_timer fire];
    
    // Start
    [ _session startRunning];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0.2*SCREEN_WIDTH, 0.8*SCREEN_HEIGHT, 0.6*SCREEN_WIDTH, 0.05*SCREEN_HEIGHT)];
    _label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_label];
    
    
}



#pragma mark AVCaptureMetadataOutputObjectsDelegate

- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection
{

    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        
        [_session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        stringValue = metadataObject.stringValue;
        [self openQRCodeString:metadataObject.stringValue];
//        _label.text = stringValue;
//        [_scanLayer removeFromSuperlayer];
//        [_preview removeFromSuperlayer];
//        NSLog(@"%@",_label.text);
        [_timer invalidate];
        DrugStoreDetailViewController *drugStoreDetailVC = [[DrugStoreDetailViewController alloc] init];
        drugStoreDetailVC.drugStoreName = stringValue;
        [self.navigationController pushViewController:drugStoreDetailVC animated:YES];

    }
}


- (void)stopReading{
    [_session stopRunning];
    _session = nil;
    [_scanLayer removeFromSuperlayer];
    [_preview removeFromSuperlayer];
}

- (void)openQRCodeString:(NSString *)code
{
//    if ([code hasPrefix:@"http"]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:code]];
//    } else if ([code hasPrefix:@"www."]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", code]]];
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//    DrugStoreDetailViewController *drugStoreDetailVC = [[DrugStoreDetailViewController alloc] init];
//    drugStoreDetailVC.drugStoreName = code;
//    [self.navigationController pushViewController:drugStoreDetailVC animated:YES];
}


- (void)moveScanLayer:(NSTimer *)timer{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height < _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

- (BOOL)shouldAutorotate{
    return NO;
}


@end
