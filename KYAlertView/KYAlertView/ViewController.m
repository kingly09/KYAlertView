//
//  ViewController.m
//  KYAlertView
//
//  Created by kingly on 2016/11/1.
//  Copyright © 2016年 https://github.com/kingly09/KYAlertView  kingly inc. All rights reserved.
//

#import "ViewController.h"
#import "KYAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.

    self.title  = @"KYAlertView的Demo";
}

- (IBAction)UseBlockAlertView:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"登录apple成功" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil,nil];
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {

        if (index == 0) {
            NSLog(@"知道了");
        }
    };
    
    [alert show];

}
- (IBAction)textFieldAlertView:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录 iTunes Store " message:@"请输入您的“lixxxx@163.com”的密码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好",nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[alert textFieldAtIndex:0] setPlaceholder:@"请输入6位数字密码"];
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {

        if (index == 0) {

            NSLog(@"取消");

        }else  if (index == 1) {

            NSLog(@"好");

        }
        
    };
    
    [alert show];

}

- (IBAction)otherButtonTitlesAlertView:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Apple ID" message:@"lixxxx@163.com" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"查看 Apple ID",@"注销",@"iForgot",@"取消",nil];
    alert.alertViewClickedButtonAtIndexBlock = ^(UIAlertView *alert ,NSUInteger index) {

        if (index == 0) {

            NSLog(@"查看 Apple ID");

        }else  if (index == 1) {

            NSLog(@"注销");

        }else  if (index == 2) {

            NSLog(@"iForgot");

        }else  if (index == 3) {

            NSLog(@"取消");
        }
        
    };
    
    
    [alert show];
}

- (IBAction)customAlertView:(id)sender {

    [[KYAlertView sharedInstance] showAlertView:@"领取成功"
                     message:@"哇，中奖了100万,太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了"
              subBottonTitle:@"分享好友"
           cancelButtonTitle:@"立即查看"
                     handler:^(AlertViewClickBottonType bottonType) {

                         if (bottonType == AlertViewClickBottonTypeSubBotton) {
                             NSLog(@"分享好友");
                         }else if (bottonType == AlertViewClickBottonTypeCancelButton){
                             NSLog(@"立即查看");
                         }
                     }];



}
- (IBAction)hightExAlertView:(id)sender {

    KYAlertView *alertView = [KYAlertView sharedInstance];

    [alertView setTitleLabelTextColor:[UIColor blackColor]];   //设置标题的颜色

    [alertView setContentLabelTextColor:[UIColor blueColor]];    //设置内容的颜色

    [alertView setAlertViewBackgroundColor:[UIColor yellowColor]];   //设置AlertView的颜色

    //    [alertView setAlertViewBackgroundImage:[UIImage imageNamed:@"bg_woyeyaoyugao"]];   //设置AlertView的背景图片

    [alertView setSubBottonBackgroundColor:[UIColor blackColor]];   //设置SubBotton的背景颜色
    [alertView setSubBottonTitleColor:[UIColor whiteColor]];         //设置SubBotton的文字颜色

    [alertView setSubBottonBorderColor:[UIColor redColor]];         //设置SubBotton的边框颜色
    [alertView setCancelButtonTitleColor:[UIColor redColor]];       // 设置CancelButton的文字颜色
    [alertView setCancelButtonBackgroundColor:[UIColor whiteColor]];  // 设置CancelButto的背景颜色
    [alertView setCancelButtonBorderColor:[UIColor blackColor]];      // 设置CancelButton的边框颜色


    [alertView showAlertView:@"领取成功"
                     message:@"哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了哇，太好了"
              subBottonTitle:@"立即分享"
           cancelButtonTitle:@"立即查看"
                     handler:^(AlertViewClickBottonType bottonType) {

                         if (bottonType == AlertViewClickBottonTypeSubBotton) {
                             NSLog(@"分享好友");
                         }else if (bottonType == AlertViewClickBottonTypeCancelButton){
                             NSLog(@"立即查看");
                         }
                     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
