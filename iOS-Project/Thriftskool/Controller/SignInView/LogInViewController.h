//
//  LogInViewController.h
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOSAlertView.h"


@interface LogInViewController : UIViewController<UITextFieldDelegate,CustomIOSAlertViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UIButton *btnForgotPwd;
    IBOutlet UIButton *btnForgotUsername;
    IBOutlet UIButton *btnLogIn;
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtPassword;
    IBOutlet UIImageView *imgLogo;
    UITextField *txtEmail;
    
    IBOutlet NSLayoutConstraint *keyboardHeight;
    IBOutlet NSLayoutConstraint *imgY;
    
    
    UITapGestureRecognizer *tap;
    CustomIOSAlertView *alertView;
    
    BOOL isClickedPwd;
}

@end
