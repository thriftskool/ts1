//
//  SignUpViewController.h
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversityListViewController.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,SelectUniversityNameDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UIButton *btnRegister;
    IBOutlet UIButton *btncheckmark;
    IBOutlet UITextView  *txtviewPrivacyPolicy;
    IBOutlet UITextField *txtSelectUniversity;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtPassword;
    IBOutlet UITextField *txtConfirmPassword;
//    IBOutlet UILabel *lblDomainName;
    int universityId;
    BOOL checkmarkSelected;
    IBOutlet NSLayoutConstraint *keyboardHeight;
    IBOutlet NSLayoutConstraint *imgY;
//    IBOutlet NSLayoutConstraint *consSignup;
//    IBOutlet NSLayoutConstraint *consPwd;
//    IBOutlet NSLayoutConstraint *consUserName;
//    IBOutlet NSLayoutConstraint *consEmail;
    BOOL successRegistration;

}

@property (nonatomic, retain)UniversityListViewController *universityObj;
@property (nonatomic, retain) NSString *strverify;

@end
