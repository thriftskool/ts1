//
//  ViewController.h
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"

@interface StartScreenViewController : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UIView *startscreenView;
    IBOutlet UIButton *btnLogIn;
    IBOutlet UIButton *btnSignUp;
    UIButton *tryAgain;
    IBOutlet UIImageView *logoImage;
    UILabel *lblnetwork;

}

@property (nonatomic, retain) SignUpViewController* signUpObj;
@property (nonatomic, retain) NSString *strVerfication;
@end

