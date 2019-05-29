//
//  CustomIOSAlertView.m
//  CustomIOSAlertView
//
//  Created by Richard on 20/09/2013.
//  Copyright (c) 2013-2015 Wimagguc.
//
//  Lincesed under The MIT License (MIT)
//  http://opensource.org/licenses/MIT
//

#import "MMAlertView.h"

#import <QuartzCore/QuartzCore.h>
#import "MMAlertViewConfig.h"

@implementation MMAlertView

CGFloat ButtonHeight = 0;
CGFloat AlertBodyWidth = 0;

#pragma mark - init and lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        _closeOnTouchUpOutside = false;
        _title = @"";
        _buttonTitles = @[@"确定"];
        _preferredActionIndex = -1;
        self.bodyMarginVertical = 15;
        self.bodyMarginHorizontal = 15;
        AlertBodyWidth = kCustomIOSAlertViewBodyDefaultWidthRatio * self.frame.size.width;
        _contentViewWidth = AlertBodyWidth - self.bodyMarginHorizontal * 2;
        _titleBarStyle = YBAlertTitleBarStyleThemeColor;
        _preferredActionButtonPosition = YBAlertPreferredActionButtonPositionRight;
        _titleTextFont = [MMAlertViewConfig sharedConfig].titleTextFont;
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - alert display

// Create the dialog view, and animate opening the dialog
- (void)show
{
    _dialogView = [self createContainerView];
  
    _dialogView.layer.shouldRasterize = YES;
    _dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
  
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];

    [self addSubview:_dialogView];

    // Can be attached to a view or to the top most window
    // Attached to a view:
    if (_parentView != NULL) {
        [_parentView addSubview:self];

    // Attached to the top most window
    } else {
        CGSize screenSize = [self countScreenSize];
        CGSize dialogSize = [self countAlertSize];
        CGSize keyboardSize = CGSizeMake(0, 0);
        
        _dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2,
                                       (screenSize.height - keyboardSize.height - dialogSize.height) / 2,
                                       dialogSize.width,
                                       dialogSize.height);

        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
    }

    _dialogView.layer.opacity = 0.5f;
    _dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         __strong typeof(self) strongSelf = weakSelf;
         strongSelf.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
         strongSelf.dialogView.layer.opacity = 1.0f;
         strongSelf.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
     }
                     completion:NULL];

}

- (void)alertButtonTouchUpInside:(id)sender
{
    if (_onButtonTouchUpInside != NULL) {
        _onButtonTouchUpInside(self, (int)[sender tag]);
    }
}

- (void)closeButtonTouched:(id)sender {
    [self close];
}

- (void)setSubView: (UIView *)subView
{
    _contentView = subView;
}

// Creates the container view here: create the dialog, then add the custom content and buttons
- (UIView *)createContainerView
{
    if (_contentView == NULL) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    }

    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countAlertSize];

    // For the black background
    [self setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];

    // This is the dialog's container; we attach the custom content and the buttons to this one
    UIView *dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height)];
    dialogContainer.backgroundColor = [UIColor whiteColor];
    CGFloat cornerRadius = kCustomIOSAlertViewCornerRadius;
    dialogContainer.layer.cornerRadius = cornerRadius;
    dialogContainer.layer.masksToBounds = YES;
    dialogContainer.layer.borderColor = [[UIColor colorWithRed:198.0/255.0 green:198.0/255.0 blue:198.0/255.0 alpha:1.0f] CGColor];
    dialogContainer.layer.shadowRadius = cornerRadius + 5;
    dialogContainer.layer.shadowOpacity = 0.1f;
    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius+5)/2, 0 - (cornerRadius+5)/2);
    dialogContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;

    // add top title bar
    if (self.title && [self.title isKindOfClass:[NSString class]] && self.title.length > 0) {
        UIView *topTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dialogContainer.bounds.size.width, kCustomIOSAlertViewTopTitleHeight)];
        topTitleView.backgroundColor = (_titleBarStyle == YBAlertTitleBarStyleGray) ? [UIColor whiteColor] : [MMAlertViewConfig sharedConfig].themeColor;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, topTitleView.bounds.size.width - 70, kCustomIOSAlertViewTopTitleHeight)];
        titleLabel.textColor = (self.titleBarStyle == YBAlertTitleBarStyleGray) ? [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1] : [MMAlertViewConfig sharedConfig].titleTextColor;
        titleLabel.font = _titleTextFont;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = _title;
        [topTitleView addSubview:titleLabel];
        if (_titleBarStyle != YBAlertTitleBarStyleThemeColor) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, topTitleView.frame.size.height - 1, topTitleView.frame.size.width, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
            [topTitleView addSubview:lineView];
        }
        
        [dialogContainer addSubview:topTitleView];
    }
    
    // Add the custom container if there is any
    CGFloat bodyHeight = _contentView.bounds.size.height + self.bodyMarginVertical * 2;
    if (bodyHeight < kCustomIOSAlertViewBodyMinHeight) {
        bodyHeight = kCustomIOSAlertViewBodyMinHeight;
    }
    CGFloat bodyY = self.bodyMarginVertical;
    if (self.title && self.title.length > 0) {
        bodyY += kCustomIOSAlertViewTopTitleHeight;
    }
    CGRect contentContainerRect = CGRectMake(self.bodyMarginHorizontal,
                                             bodyY,
                                             dialogContainer.bounds.size.width - self.bodyMarginHorizontal * 2,
                                             bodyHeight - self.bodyMarginVertical * 2);
    UIView *contentContainer = [[UIView alloc] initWithFrame:contentContainerRect];
    contentContainer.backgroundColor = [UIColor redColor];
    CGRect contentRect = _contentView.frame;
    contentRect.origin.y = (contentContainer.bounds.size.height - _contentView.bounds.size.height) / 2;
    _contentView.frame = contentRect;
    [contentContainer addSubview:_contentView];
    [dialogContainer addSubview:contentContainer];

    // Add the buttons too
    [self addActionButtonsToView:dialogContainer];

    return dialogContainer;
}

- (void)addActionButtonsToView:(UIView *)container
{
    if (_buttonTitles == NULL) { return; }
    
    CGRect containerRect = CGRectMake(0,
                                      container.bounds.size.height - ButtonHeight,
                                      container.bounds.size.width,
                                      ButtonHeight);
    UIView *bottomContainer = [[UIView alloc] initWithFrame:containerRect];
    bottomContainer.backgroundColor = [UIColor whiteColor];
    [self addActionButtonsToBottom:bottomContainer];
    [container addSubview:bottomContainer];
}

- (void)addActionButtonsToBottom:(UIView *)bottomBar {
    
    CGFloat buttonWidth = bottomBar.bounds.size.width / [_buttonTitles count];
    
    for (int i = 0; i < [_buttonTitles count]; i++) {
        
        // 先确定按钮色颜色、字体等样式
        UIColor *titleColor = [MMAlertViewConfig sharedConfig].actionButtonTextColor;
        UIFont *buttonTitleFont = [MMAlertViewConfig sharedConfig].actionButtonFont;
        
        BOOL isPreferredAction = (_preferredActionButtonPosition == YBAlertPreferredActionButtonPositionAll) ||
        (i == 0 && _preferredActionButtonPosition == YBAlertPreferredActionButtonPositionLeft) ||
        (i == _buttonTitles.count - 1 && _preferredActionButtonPosition == YBAlertPreferredActionButtonPositionRight);
        if (isPreferredAction) {
            titleColor = [MMAlertViewConfig sharedConfig].preferredActionButtonTextColor;
            buttonTitleFont = [MMAlertViewConfig sharedConfig].preferredActionButtonFont;
        }
        
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        actionButton.backgroundColor = [UIColor whiteColor];
        [actionButton setFrame:CGRectMake(i * buttonWidth, 1, buttonWidth, ButtonHeight-1)];
        
        [actionButton addTarget:self action:@selector(alertButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [actionButton setTag:i];
        
        [actionButton setTitle:[_buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [actionButton setTitleColor:titleColor forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
        [actionButton.titleLabel setFont:buttonTitleFont];
        actionButton.titleLabel.numberOfLines = 0;
        actionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [actionButton.layer setCornerRadius:kCustomIOSAlertViewCornerRadius];
        [bottomBar addSubview:actionButton];
        
        if (i > 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i * buttonWidth, 1, 1, ButtonHeight - 1)];
            lineView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
            [bottomBar addSubview:lineView];
        }
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomBar.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    [bottomBar addSubview:lineView];
}

#pragma mark - compute size

// Helper function: count and return the dialog's size
- (CGSize)countAlertSize
{
    CGFloat titleHeight = 0;
    if (self.title && self.title.length > 0) {
        titleHeight = kCustomIOSAlertViewTopTitleHeight;
    }
    CGFloat bodyHeight = _contentView.frame.size.height + self.bodyMarginVertical * 2;
    if (bodyHeight < kCustomIOSAlertViewBodyMinHeight) {
        bodyHeight = kCustomIOSAlertViewBodyMinHeight;
    }
    CGFloat alertViewHeight = titleHeight + bodyHeight + ButtonHeight;

    return CGSizeMake(AlertBodyWidth, alertViewHeight);
}

// Helper function: count and return the screen's size
- (CGSize)countScreenSize
{
    if (_buttonTitles!=NULL && [_buttonTitles count] > 0) {
        ButtonHeight = kCustomIOSAlertViewDefaultButtonHeight;
    } else {
        ButtonHeight = 0;
    }

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    return CGSizeMake(screenWidth, screenHeight);
}

#pragma mark - dismiss & dealloc

- (void)close
{
    CATransform3D currentTransform = _dialogView.layer.transform;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        CGFloat startRotation = [[_dialogView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
        CATransform3D rotation = CATransform3DMakeRotation(-startRotation + M_PI * 270.0 / 180.0, 0.0f, 0.0f, 0.0f);
        
        _dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    }
    
    _dialogView.layer.opacity = 1.0f;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^
     {
         __weak typeof(self) strongSelf = weakSelf;
         strongSelf.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
         strongSelf.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
         strongSelf.dialogView.layer.opacity = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         for (UIView *v in [self subviews]) {
             [v removeFromSuperview];
         }
         [self removeFromSuperview];
     }];
}

- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - Orientation

- (void)changeOrientation: (NSNotification *)notification {

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^
     {
         __weak typeof(self) strongSelf = weakSelf;
         CGSize dialogSize = [self countAlertSize];
         CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
         self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
         strongSelf.dialogView.frame = CGRectMake((screenWidth - dialogSize.width) / 2, (screenHeight - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
     }
                     completion:nil];
}

// Handle device orientation changes
- (void)deviceOrientationDidChange: (NSNotification *)notification
{
    if (_parentView != NULL) {
        return;
    }
    
    [self changeOrientation:notification];
}

#pragma mark - keyboard event handler

- (void)keyboardWillShow: (NSNotification *)notification
{
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countAlertSize];
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^
     {
         __weak typeof(self) strongSelf = weakSelf;
         strongSelf.dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - keyboardSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
     }
                     completion:nil];
}

- (void)keyboardWillHide: (NSNotification *)notification
{
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = [self countAlertSize];

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^
     {
         __weak typeof(self) strongSelf = weakSelf;
         strongSelf.dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2, (screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
     }
                     completion:nil];
}

#pragma mark - touched handler

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_closeOnTouchUpOutside) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[MMAlertView class]]) {
        [self close];
    }
}

@end
