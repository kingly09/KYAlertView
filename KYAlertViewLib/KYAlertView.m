//
//  KYAlertView.m
//  KYAlertView
//
//  Created by kingly on 2016/11/1.
//  Copyright © 2016年 https://github.com/kingly09/KYAlertView  kingly inc. All rights reserved.
//

#import "KYAlertView.h"

#import <objc/runtime.h>
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCALE ([UIScreen mainScreen].scale)

#define kAlertViewWidth 275.0f
#define kAlertViewHight 200.0f
#define KTitleLabelHigth  25.0f

#define KTitleLabelTop    34.0f
#define KContentLabelTop  25.0f
#define KBtnVarSpaceTop   25.0f

#define kAlertViewSpace  34.0f

#define KBtnHight 30.0f
#define KBtnVarSpace  15.0f
#define KBtnToFooterSpace 32.0f
#define KBtnToBtnSpace 15.0f

static char KYOriginalUIAlertViewDelegateKey;
static char KYAlertViewClickedButtonAtIndexBlockKey;
static char KYAlertViewCancelBlockKey;
static char KYWillPresentAlertViewBlockKey;
static char KYDidPresentAlertViewBlockKey;
static char KYAlertViewWillDismissWithButtonIndexBlockKey;
static char KYAlerViewDidDismissWithButtonIndexBlockKey;
static char KYAlertViewShouldEnableFirstOtherButtonBlockKey;

@implementation UIAlertView (KYBlocks)

- (void)_useBlock {
    if (self.delegate && self.delegate != (id<UIAlertViewDelegate>)self) {
        //通过 objc_getAssociatedObject获取关联对象
        objc_setAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
    }
    self.delegate = (id<UIAlertViewDelegate>)self;
}
/**
 * 通过 objc_getAssociatedObject 点击完成btn的关联对象
 */
- (KYAlertViewCompleteBlock)alertViewClickedButtonAtIndexBlock {
    return objc_getAssociatedObject(self, &KYAlertViewClickedButtonAtIndexBlockKey);
}
/**
 * @brief 设置点击ClickedButton的Block
 */
- (void)setAlertViewClickedButtonAtIndexBlock:(KYAlertViewCompleteBlock)alertViewClickedButtonAtIndexBlock {
    if (alertViewClickedButtonAtIndexBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &KYAlertViewClickedButtonAtIndexBlockKey, alertViewClickedButtonAtIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }

}
/**
 * 通过 objc_getAssociatedObject 点击取消btn的关联对象
 */
- (KYAlertViewBlock)alertViewCancelBlock{
    return objc_getAssociatedObject(self, &KYAlertViewCancelBlockKey);
}
/**
 * @brief 设置点击取消按钮的Block
 */
- (void)setAlertViewCancelBlock:(KYAlertViewBlock)alertViewCancelBlock {
    if (alertViewCancelBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &KYAlertViewCancelBlockKey, alertViewCancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
/**
 * 通过 objc_getAssociatedObject 点击WillPresentAlertView的关联对象
 */
- (KYAlertViewBlock)willPresentAlertViewBlock {
    return objc_getAssociatedObject(self, &KYWillPresentAlertViewBlockKey);
}
/**
 * @brief 设置WillPresentAlertView的Block
 */
- (void)setWillPresentAlertViewBlock:(KYAlertViewBlock)willPresentAlertViewBlock {
    if (willPresentAlertViewBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &KYWillPresentAlertViewBlockKey, willPresentAlertViewBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
/**
 * 通过 objc_getAssociatedObject 点击PresentAlertView的关联对象
 */
- (KYAlertViewBlock)didPresentAlertViewBlock {
    return objc_getAssociatedObject(self, &KYDidPresentAlertViewBlockKey);
}
/**
 * @brief 设置父类的AlertView的Block
 */
- (void)setDidPresentAlertViewBlock:(KYAlertViewBlock)didPresentAlertViewBlock {
    if (didPresentAlertViewBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &KYDidPresentAlertViewBlockKey, didPresentAlertViewBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (KYAlertViewCompleteBlock)alertViewWillDismissWithButtonIndexBlock {
    return objc_getAssociatedObject(self, &KYAlertViewWillDismissWithButtonIndexBlockKey);
}

- (void)setAlertViewWillDismissWithButtonIndexBlock:(KYAlertViewCompleteBlock)alertViewWillDismissWithButtonIndexBlock {
    if (alertViewWillDismissWithButtonIndexBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &KYAlertViewWillDismissWithButtonIndexBlockKey, alertViewWillDismissWithButtonIndexBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

-(KYAlertViewCompleteBlock)alerViewDidDismissWithButtonIndexBlock {
    return objc_getAssociatedObject(self, &KYAlerViewDidDismissWithButtonIndexBlockKey);
}

- (void)setAlerViewDidDismissWithButtonIndexBlock:(KYAlertViewCompleteBlock)alerViewDidDismissWithButtonIndexBlock {
    if (alerViewDidDismissWithButtonIndexBlock) {
        [self _useBlock];
    }
}

-(KYAlertViewBoolBlock)alertViewShouldEnableFirstOtherButtonBlock {
    return objc_getAssociatedObject(self, &KYAlertViewShouldEnableFirstOtherButtonBlockKey);
}

- (void)setAlertViewShouldEnableFirstOtherButtonBlock:(KYAlertViewBoolBlock)alertViewShouldEnableFirstOtherButtonBlock {
    if (alertViewShouldEnableFirstOtherButtonBlock) {
        [self _useBlock];
        objc_setAssociatedObject(self, &KYAlertViewShouldEnableFirstOtherButtonBlockKey, alertViewShouldEnableFirstOtherButtonBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    KYAlertViewCompleteBlock block = self.alertViewClickedButtonAtIndexBlock;
    if (block) block(alertView, buttonIndex);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [original alertView:alertView clickedButtonAtIndex:buttonIndex];
    }
}
- (void)alertViewCancel:(UIAlertView *)alertView {
    KYAlertViewBlock block = self.alertViewCancelBlock;
    if (block) block(alertView);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertViewCancel:)]) {
        [original alertViewCancel:alertView];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    KYAlertViewBlock block = self.willPresentAlertViewBlock;
    if (block) block(alertView);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(willPresentAlertView:)]) {
        [original willPresentAlertView:alertView];
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    KYAlertViewBlock block = self.didPresentAlertViewBlock;
    if (block) block(alertView);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(didPresentAlertView:)]) {
        [original didPresentAlertView:alertView];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    KYAlertViewCompleteBlock block = self.alertViewWillDismissWithButtonIndexBlock;
    if (block) block(alertView, buttonIndex);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [original alertView:alertView willDismissWithButtonIndex:buttonIndex];
    }
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    KYAlertViewCompleteBlock block = self.alerViewDidDismissWithButtonIndexBlock;
    if (block) block(alertView, buttonIndex);

    id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey);
    if (original && [original respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
        [original alertView:alertView didDismissWithButtonIndex:buttonIndex];
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {

    KYAlertViewBoolBlock block = self.alertViewShouldEnableFirstOtherButtonBlock;
    if (block) {
        return block(alertView);
    } else {
        id<UIAlertViewDelegate> original = objc_getAssociatedObject(self, &KYOriginalUIAlertViewDelegateKey);
        if (original && [original respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)]) {
            return [original alertViewShouldEnableFirstOtherButton:alertView];
        }
    }
    return YES;
}



@end

@interface UIColor (CustomColor)

/**
 * 十六进制的颜色值转换为颜色UIColor（带透明度）
 */
+(UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

/**
 * 十六进制的颜色值转换为颜色UIColor
 */
+(UIColor*) colorWithHex:(NSInteger)hexValue;

/**
 主色调
 */
+ (UIColor*)mainColor;


@end

@implementation UIColor (CustomColor)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*) colorWithHex:(NSInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor*)mainColor{

     return [UIColor colorWithHex:0xff3c6f];
}

@end

@interface UIView (KYFrame)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;
@end

@implementation UIView (KYFrame)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

@end

@interface KYAlertView (){
    UIWindow *currWindow;
    UIView *alertView; //提示框

    UILabel  *titleLabel; //提示Label
    NSString *alertTitle; //提示语

    UILabel  *contentLabel; //提示内容Label
    NSString *alertContentText; //提示内容

    UIButton *alertSubBotton;  //确定按钮
    UILabel  *subLabel;
    NSString *alertSubBottonText; //确定文案

    UIButton *alertCancelBotton;  //取消按钮
    UILabel  *cancelLabel;
    NSString *alertCancelText;    //取消文案

    clickButtonAtIndexBlock buttonAtIndexBlock;

    UIColor *titleLabelTextColor;
    UIColor *contentLabelTextColor;
    UIColor *alertViewBackgroundColor;
    UIColor *subBottonTitleColor;
    UIColor *subBottonBackgroundColor;
    UIColor *subBottonBorderColor;
    UIColor *cancelButtonTitleColor;
    UIColor *cancelButtonBackgroundColor;
    UIColor *cancelButtonBorderColor;

    UIImage *alertViewBackgroundImage; //设置AlertView的BackgroundImage
    NSAttributedString *messageAttributedText; //设置富文本
    UIFont *messageFont;                       //设置富文本大小


}

@end

@implementation KYAlertView

+ (KYAlertView *) sharedInstance{

    static KYAlertView *sharedObj = nil;
    @synchronized (self)
    {
        if (sharedObj == nil){
            sharedObj = [[self alloc] init];

        }
    }
    return sharedObj;

}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(instancetype)init{

    if ([super init]) {

    }
    return self;
}

/**
 *  自定义视图
 **/
-(void)customView{

    alertView = [[UIView alloc] init];
    alertView.size = CGSizeMake(kAlertViewWidth, kAlertViewHight);
    alertView.x = (SCREEN_WIDTH - kAlertViewWidth)/2;
    alertView.y  = (SCREEN_HEIGHT - kAlertViewHight)/2;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 10;
    [currWindow addSubview:alertView];


    //标题
    titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHex:0xff3c6f];
    titleLabel.font   = [UIFont boldSystemFontOfSize:17];
    titleLabel.size   = CGSizeMake(kAlertViewWidth-kAlertViewSpace*2,KTitleLabelHigth);
    titleLabel.x   = kAlertViewSpace;
    titleLabel.y    = KTitleLabelTop;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines   = 1;
    [alertView addSubview:titleLabel];


    contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor colorWithHex:0x555555];
    contentLabel.font   = [UIFont systemFontOfSize:15];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.numberOfLines   = 0;
    [alertView addSubview:contentLabel];


    alertSubBotton = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertSubBotton setExclusiveTouch:YES];
    [alertSubBotton setBackgroundColor:[UIColor clearColor]];
    [alertSubBotton addTarget:self action:@selector(itemClickSubView:) forControlEvents:UIControlEventTouchUpInside];
    [alertSubBotton adjustsImageWhenHighlighted];
    [alertSubBotton adjustsImageWhenDisabled];
    [alertSubBotton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    alertSubBotton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [alertView addSubview:alertSubBotton];


    subLabel = [[UILabel alloc] init];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.textColor = [UIColor whiteColor];
    subLabel.font   = [UIFont systemFontOfSize:14];
    subLabel.backgroundColor = [UIColor clearColor];
    subLabel.numberOfLines   = 1;
    [alertSubBotton addSubview:subLabel];


    alertCancelBotton = [UIButton buttonWithType:UIButtonTypeCustom];
    [alertCancelBotton setExclusiveTouch:YES];
    [alertCancelBotton setBackgroundColor:[UIColor clearColor]];
    [alertCancelBotton addTarget:self action:@selector(itemClickCancelBotton:) forControlEvents:UIControlEventTouchUpInside];
    [alertCancelBotton adjustsImageWhenHighlighted];
    [alertCancelBotton adjustsImageWhenDisabled];
    [alertCancelBotton setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    alertCancelBotton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [alertView addSubview:alertCancelBotton];

    cancelLabel = [[UILabel alloc] init];
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.textColor = [UIColor mainColor];
    cancelLabel.font   = [UIFont systemFontOfSize:14];
    cancelLabel.backgroundColor = [UIColor clearColor];
    cancelLabel.numberOfLines   = 1;
    [alertCancelBotton addSubview:cancelLabel];

}



-(void)showAlertViewWithMessage:(NSString *)message
                 subBottonTitle:(nullable NSString *)subBottonTitle
                        handler:(clickButtonAtIndexBlock )block{

    [self showAlertView:nil message:message subBottonTitle:subBottonTitle cancelButtonTitle:nil handler:^(AlertViewClickBottonType bottonType) {
        block(bottonType);
    }];
}

-(void)showAlertViewWithMessage:(NSString *)message
              cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                        handler:(clickButtonAtIndexBlock )block{

    [self showAlertView:nil message:message subBottonTitle:nil cancelButtonTitle:cancelButtonTitle handler:^(AlertViewClickBottonType bottonType) {
        block(bottonType);
    }];
}

-(void)showAlertViewWithMessage:(NSString *)message
                 subBottonTitle:(nullable NSString *)subBottonTitle
              cancelButtonTitle:(nullable NSString *)cancelButtonTitle handler:(clickButtonAtIndexBlock )block{

    [self showAlertView:nil message:message subBottonTitle:subBottonTitle cancelButtonTitle:cancelButtonTitle handler:^(AlertViewClickBottonType bottonType) {
        block(bottonType);
    }];
}

-(void)showAlertView:(nullable NSString *)title
             message:(NSString *)message
      subBottonTitle:(nullable NSString *)subBottonTitle
             handler:(clickButtonAtIndexBlock )block{

    [self showAlertView:title message:message subBottonTitle:subBottonTitle cancelButtonTitle:nil handler:^(AlertViewClickBottonType bottonType) {
        block(bottonType);
    }];
}

-(void)showAlertView:(nullable NSString *)title
             message:(NSString *)message
   cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             handler:(clickButtonAtIndexBlock )block{

    [self showAlertView:title message:message subBottonTitle:nil cancelButtonTitle:cancelButtonTitle handler:^(AlertViewClickBottonType bottonType) {
        block(bottonType);
    }];
}


-(void)showAlertView:(nullable NSString *)title
             message:(NSString *)message
      subBottonTitle:(nullable NSString *)subBottonTitle
   cancelButtonTitle:(nullable NSString *)cancelButtonTitle handler:(clickButtonAtIndexBlock )block{

    buttonAtIndexBlock = block;

    alertTitle = title;
    alertContentText  = message;
    alertSubBottonText = subBottonTitle;
    alertCancelText    = cancelButtonTitle;

    currWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    currWindow.windowLevel = UIWindowLevelAlert+1;
    currWindow.backgroundColor = [UIColor colorWithHex:0x202020 alpha:0.55];
    currWindow.hidden = NO;

    [self customView];

    [self loadDataView];

}


/**
 *  加载数据
 */
-(void)loadDataView{

    titleLabel.text = alertTitle;
    contentLabel.text = alertContentText;

    CGRect alertContentTextRect = [alertContentText boundingRectWithSize:CGSizeMake(kAlertViewWidth-kAlertViewSpace*2,SCREEN_HEIGHT - 64 - KTitleLabelHigth - kAlertViewSpace - KBtnToFooterSpace - KBtnHight ) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    contentLabel.size   = CGSizeMake(kAlertViewWidth-kAlertViewSpace*2,alertContentTextRect.size.height);
    contentLabel.x   = kAlertViewSpace;
    contentLabel.y    = KContentLabelTop + titleLabel.y + titleLabel.height;

    if (titleLabel.text.length == 0) {
        contentLabel.y    = KContentLabelTop;
    }

    if (alertContentTextRect.size.height < KTitleLabelHigth) {
        contentLabel.textAlignment = NSTextAlignmentCenter;
    }

    if (alertSubBottonText.length > 0) {


        alertSubBotton.y  = contentLabel.y + contentLabel.height + KBtnVarSpaceTop;
        CGRect subBtnRect = [alertSubBottonText boundingRectWithSize:CGSizeMake(kAlertViewWidth,KBtnHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        alertSubBotton.size = CGSizeMake(KBtnVarSpace*2+subBtnRect.size.width+KBtnHight/2,KBtnHight);
        alertSubBotton.x = (kAlertViewWidth - alertSubBotton.width)/2;
        alertSubBotton.backgroundColor = [UIColor clearColor];

        alertView.size = CGSizeMake(kAlertViewWidth, alertSubBotton.y + alertSubBotton.height + KBtnToFooterSpace);
        alertView.x = (SCREEN_WIDTH - kAlertViewWidth)/2;
        alertView.y  = (SCREEN_HEIGHT - (alertSubBotton.y + alertSubBotton.height + KBtnToFooterSpace))/2;

        subLabel.size = alertSubBotton.size;
        subLabel.text = alertSubBottonText;


    }

    if (alertCancelText.length > 0) {

        alertCancelBotton.y  = contentLabel.y + contentLabel.height + KBtnVarSpaceTop;
        CGRect alertCancelBtnRect = [alertCancelText boundingRectWithSize:CGSizeMake(kAlertViewWidth,KBtnHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
        alertCancelBotton.size = CGSizeMake(KBtnVarSpace*2+alertCancelBtnRect.size.width+KBtnHight/2,KBtnHight);
        alertCancelBotton.x = (kAlertViewWidth - alertCancelBotton.width)/2;


        alertView.size = CGSizeMake(kAlertViewWidth, alertCancelBotton.y + alertCancelBotton.height + KBtnToFooterSpace);
        alertView.x = (SCREEN_WIDTH - kAlertViewWidth)/2;
        alertView.y  = (SCREEN_HEIGHT - (alertCancelBotton.y + alertCancelBotton.height + KBtnToFooterSpace))/2;

        cancelLabel.size =  CGSizeMake(alertCancelBotton.size.width-1,KBtnHight);
        cancelLabel.x = 1/SCALE;
        cancelLabel.text = alertCancelText;
        [cancelLabel.layer setMasksToBounds:YES];
        cancelLabel.layer.cornerRadius = KBtnHight/2;
        cancelLabel.layer.borderWidth = 1/SCALE;
        cancelLabel.layer.borderColor = [UIColor mainColor].CGColor;

    }
    if (alertSubBottonText.length > 0 && alertCancelText.length > 0){

        alertSubBotton.x = (kAlertViewWidth - alertSubBotton.width - alertCancelBotton.width - KBtnToBtnSpace)/2;
        alertCancelBotton.x = alertSubBotton.x + alertSubBotton.width + KBtnToBtnSpace;

    }

    //扩展属性
    [self alertViewExtend];
}


/**
 *  隐藏AlertView
 **/
-(void)hideAlertView{
    titleLabelTextColor = nil;
    contentLabelTextColor = nil;
    alertViewBackgroundColor = nil;
    alertViewBackgroundImage  = nil;
    subBottonTitleColor       = nil;
    subBottonBackgroundColor  = nil;
    subBottonBorderColor      = nil;
    cancelButtonBackgroundColor = nil;
    cancelButtonTitleColor     = nil;
    cancelButtonBorderColor      = nil;
    alertViewBackgroundImage     = nil;

    messageAttributedText  = nil;
    messageFont = nil;


    currWindow.hidden = YES;
    currWindow = nil;
    self.hidden = YES;

}

-(void)itemClickSubView:(id)sender{

    [self hideAlertView];

    buttonAtIndexBlock(AlertViewClickBottonTypeSubBotton);

}
-(void)itemClickCancelBotton:(id)sender{

    [self hideAlertView];
    buttonAtIndexBlock(AlertViewClickBottonTypeCancelButton);
}

#pragma mark - 扩展

-(void)alertViewExtend{

    titleLabel.textColor   = titleLabelTextColor?titleLabelTextColor:[UIColor colorWithHex:0xff3c6f];
    contentLabel.textColor = contentLabelTextColor?contentLabelTextColor:[UIColor colorWithHex:0x555555];

    alertView.backgroundColor = alertViewBackgroundColor?alertViewBackgroundColor:[UIColor whiteColor];

    if (alertViewBackgroundImage) {
        alertView.backgroundColor = [UIColor colorWithPatternImage:alertViewBackgroundImage];
    }
    subLabel.textColor = subBottonTitleColor?subBottonTitleColor:[UIColor whiteColor];

    if (subBottonBackgroundColor) {
        subLabel.backgroundColor = subBottonBackgroundColor;
        [subLabel.layer setMasksToBounds:YES];
        subLabel.layer.cornerRadius = KBtnHight/2;
        subLabel.layer.borderWidth = 1/SCALE;
        subLabel.layer.borderColor = [UIColor clearColor].CGColor;
    }else{

        CAGradientLayer *colorLayer = [CAGradientLayer layer];
        colorLayer.frame    = CGRectMake(0,0, subLabel.width, subLabel.height);
        colorLayer.colors = @[(__bridge id)[UIColor colorWithHex:0xfe436b].CGColor,
                              (__bridge id)[UIColor colorWithHex:0xfe7f65].CGColor];
        colorLayer.startPoint = CGPointMake(1, 0);
        colorLayer.endPoint   = CGPointMake(0, 1);
        colorLayer.cornerRadius = KBtnHight/2;
        [subLabel.layer addSublayer:colorLayer];
    }

    if (subBottonBorderColor) {
        subLabel.layer.borderColor = subBottonBorderColor.CGColor;
    }

    cancelLabel.backgroundColor = cancelButtonBackgroundColor?cancelButtonBackgroundColor:[UIColor clearColor];
    cancelLabel.textColor = cancelButtonTitleColor?cancelButtonTitleColor:[UIColor mainColor];
    cancelLabel.layer.borderColor = cancelButtonBorderColor?cancelButtonBorderColor.CGColor: [UIColor mainColor].CGColor;;

    if (messageAttributedText.length > 0) {

        contentLabel.attributedText = messageAttributedText;
    }

    if (messageFont) {

        CGRect alertContentTextRect = [alertContentText boundingRectWithSize:CGSizeMake(kAlertViewWidth-kAlertViewSpace*2,SCREEN_HEIGHT - 64 - KTitleLabelHigth - kAlertViewSpace - KBtnToFooterSpace - KBtnHight ) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:messageFont} context:nil];
        contentLabel.size   = CGSizeMake(kAlertViewWidth-kAlertViewSpace*2,alertContentTextRect.size.height);

        if (alertContentTextRect.size.height < KTitleLabelHigth) {
            contentLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (alertSubBottonText.length > 0) {

            alertSubBotton.y  = contentLabel.y + contentLabel.height + KBtnVarSpaceTop;

            alertView.size = CGSizeMake(kAlertViewWidth, alertSubBotton.y + alertSubBotton.height + KBtnToFooterSpace);
            alertView.x = (SCREEN_WIDTH - kAlertViewWidth)/2;
            alertView.y  = (SCREEN_HEIGHT - (alertSubBotton.y + alertSubBotton.height + KBtnToFooterSpace))/2;

            subLabel.size = alertSubBotton.size;
        }

        if (alertCancelText.length > 0) {

            alertCancelBotton.y  = contentLabel.y + contentLabel.height + KBtnVarSpaceTop;
            CGRect alertCancelBtnRect = [alertCancelText boundingRectWithSize:CGSizeMake(kAlertViewWidth,KBtnHight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
            alertCancelBotton.size = CGSizeMake(KBtnVarSpace*2+alertCancelBtnRect.size.width+KBtnHight/2,KBtnHight);

            alertView.size = CGSizeMake(kAlertViewWidth, alertCancelBotton.y + alertCancelBotton.height + KBtnToFooterSpace);
            alertView.x = (SCREEN_WIDTH - kAlertViewWidth)/2;
            alertView.y  = (SCREEN_HEIGHT - (alertCancelBotton.y + alertCancelBotton.height + KBtnToFooterSpace))/2;

            cancelLabel.size =  CGSizeMake(alertCancelBotton.size.width-1,KBtnHight);

        }
        if (alertSubBottonText.length > 0 && alertCancelText.length > 0){

            alertSubBotton.x = (kAlertViewWidth - alertSubBotton.width - alertCancelBotton.width - KBtnToBtnSpace)/2;
            alertCancelBotton.x = alertSubBotton.x + alertSubBotton.width + KBtnToBtnSpace;
            
        }
        

    }

}

-(void)setTitleLabelTextColor:(UIColor *)color{

    if (color) {
        titleLabelTextColor = color;
    }

}

-(void)setContentLabelTextColor:(UIColor *)color{

    if (color) {
        contentLabelTextColor = color;
    }
}

-(void)setAlertViewBackgroundColor:(UIColor *)color{

    if (color) {
        alertViewBackgroundColor = color;
    }

}

-(void)setAlertViewBackgroundImage:(UIImage *)image{

    if (image) {
        alertViewBackgroundImage = image;
    }
}

-(void)setSubBottonTitleColor:(UIColor *)color{

    if (color) {
        subBottonTitleColor = color;
    }
}

-(void)setSubBottonBackgroundColor:(UIColor *)color{
    if (color) {
        subBottonBackgroundColor = color;
    }
}

-(void)setSubBottonBorderColor:(UIColor *)color{

    if (color) {
        subBottonBorderColor = color;
    }
}

-(void)setCancelButtonTitleColor:(UIColor *)color{
    
    if (color) {
        cancelButtonTitleColor = color;
    }
    
}

-(void)setCancelButtonBackgroundColor:(UIColor *)color{
    
    if (color) {
        cancelButtonBackgroundColor = color;
    }
}

-(void)setCancelButtonBorderColor:(UIColor *)color{
    
    if(color){
        
        cancelButtonBorderColor = color;
    }
}


-(void)setMessageWithAttributedText:(NSAttributedString *)attributedText{

    if (attributedText.length >  0) {
        messageAttributedText = attributedText;
    }
}

-(void)setMessageWithAttributedText:(NSAttributedString *)attributedText withFont:(UIFont *)font{

    if (attributedText.length >  0) {
        messageAttributedText = attributedText;
    }

    if (font) {
        messageFont = font;
    }
}

@end



