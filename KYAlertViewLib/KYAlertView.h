//
//  KYAlertView.h
//  KYAlertView
//
//  Created by kingly on 2016/11/1.
//  Copyright © 2016年 https://github.com/kingly09/KYAlertView  kingly inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,AlertViewClickBottonType){
    AlertViewClickBottonTypeSubBotton = 0,
    AlertViewClickBottonTypeCancelButton = 1
};

typedef void (^clickButtonAtIndexBlock)(AlertViewClickBottonType bottonType);

typedef void (^KYAlertViewBlock)(UIAlertView *alertView);
typedef void(^KYAlertViewCompleteBlock)(UIAlertView *alertView, AlertViewClickBottonType bottonType);
typedef BOOL (^KYAlertViewBoolBlock)(UIAlertView *alertView);

@interface UIAlertView (KYBlocks)

@property (nonatomic, copy) KYAlertViewCompleteBlock alertViewClickedButtonAtIndexBlock;
@property (nonatomic, copy) KYAlertViewBlock alertViewCancelBlock;
@property (nonatomic, copy) KYAlertViewBlock willPresentAlertViewBlock;
@property (nonatomic, copy) KYAlertViewBlock didPresentAlertViewBlock;
@property (nonatomic, copy) KYAlertViewCompleteBlock alertViewWillDismissWithButtonIndexBlock;
@property (nonatomic, copy) KYAlertViewCompleteBlock alerViewDidDismissWithButtonIndexBlock;
@property (nonatomic, copy) KYAlertViewBoolBlock alertViewShouldEnableFirstOtherButtonBlock;

@end

@interface KYAlertView : UIView

@property (nonatomic,strong)   id customObject; //自定义对象
/**
 * @breif 获取实例
 */
+ (KYAlertView *) sharedInstance;


/**
 设置AlertView标题的颜色

 @param color 标题的颜色
 */
-(void)setTitleLabelTextColor:(UIColor *)color;


/**
 设置AlertView内容的颜色

 @param color 内容的颜色
 */
-(void)setContentLabelTextColor:(UIColor *)color;


/**
 设置AlertView背景颜色

 @param color AlertView背景颜色
 */
-(void)setAlertViewBackgroundColor:(UIColor *)color;

/**
 设置AlertView背景图片

 @param image AlertView背景图片
 */
-(void)setAlertViewBackgroundImage:(UIImage *)image;

/**
 设置SubBottonTitle的字体颜色

 @param color SubBottonTitle的字体颜色
 */
-(void)setSubBottonTitleColor:(UIColor *)color;


/**
 设置SubBotton的背景颜色

 @param color SubBotton的背景颜色
 */
-(void)setSubBottonBackgroundColor:(UIColor *)color;

/**
 设置SubBotton的边框颜色

 @param color SubBotton的边框颜色
 */
-(void)setSubBottonBorderColor:(UIColor *)color;

/**
 设置cancelButtonTitle的字体颜色

 @param color cancelButtonTitle的字体颜色
 */
-(void)setCancelButtonTitleColor:(UIColor *)color;


/**
 设置CancelButton的背景颜色

 @param color CancelButton的背景颜色
 */
-(void)setCancelButtonBackgroundColor:(UIColor *)color;
/**
 设置CancelButton的边框颜色

 @param color CancelButton的边框颜色
 */
-(void)setCancelButtonBorderColor:(UIColor *)color;
/**
 设置富文本

 @param attributedText 富文本文字
 */
-(void)setMessageWithAttributedText:(NSAttributedString *)attributedText;
/**
 设置富文本

 @param attributedText 富文本文字
 @param font 富文本字体大小
 */
-(void)setMessageWithAttributedText:(NSAttributedString *)attributedText withFont:(UIFont *)font;

/**
 显示AlertView视图，包含确定按钮,没有标题
 @param message           消息内容
 @param subBottonTitle    确认按钮文案
 */
-(void)showAlertViewWithMessage:(NSString *)message
                 subBottonTitle:(nullable NSString *)subBottonTitle
                        handler:(clickButtonAtIndexBlock )block;


/**
 显示AlertView视图，包含确定按钮

 @param title             标题
 @param message           消息内容
 @param subBottonTitle    确认按钮文案
 */
-(void)showAlertView:(nullable NSString *)title
             message:(NSString *)message
      subBottonTitle:(nullable NSString *)subBottonTitle
             handler:(clickButtonAtIndexBlock )block;

/**
 显示AlertView视图，包含取消按钮,没有标题

 @param message           消息内容
 @param cancelButtonTitle 取消按钮文案
 */
-(void)showAlertViewWithMessage:(NSString *)message
              cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        handler:(clickButtonAtIndexBlock )block;


/**
 显示AlertView视图，包含取消按钮


 @param title             标题
 @param message           消息内容
 @param cancelButtonTitle 取消按钮文案
 */
-(void)showAlertView:(nullable NSString *)title
             message:(NSString *)message
   cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             handler:(clickButtonAtIndexBlock )block;

/**
 显示AlertView视图，包含确认和取消按钮,但没有标题

 @param message           消息内容
 @param subBottonTitle    确认按钮文案
 @param cancelButtonTitle 取消按钮文案
 */
-(void)showAlertViewWithMessage:(NSString *)message
                 subBottonTitle:(nullable NSString *)subBottonTitle
              cancelButtonTitle:(nullable NSString *)cancelButtonTitle handler:(clickButtonAtIndexBlock )block;


/**
 显示AlertView视图，包含确认和取消按钮

 @param title             标题
 @param message           消息内容
 @param subBottonTitle    确认按钮文案
 @param cancelButtonTitle 取消按钮文案
 */
-(void)showAlertView:(nullable NSString *)title
             message:(NSString *)message
      subBottonTitle:(nullable NSString *)subBottonTitle
   cancelButtonTitle:(nullable NSString *)cancelButtonTitle handler:(clickButtonAtIndexBlock )block;

@end

NS_ASSUME_NONNULL_END
