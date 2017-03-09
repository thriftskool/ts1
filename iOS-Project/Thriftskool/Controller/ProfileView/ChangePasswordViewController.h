//
//  ChangePasswordViewController.h
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordViewController : UIViewController<ConnectionDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, retain) IBOutlet UIView *viewChangePwd;
@property (nonatomic, retain) IBOutlet UITextField *txtOldPwd;
@property (nonatomic, retain) IBOutlet UITextField *txtNewPwd;
@property (nonatomic, retain) IBOutlet UITextField *txtConfirmNewPwd;
@property (nonatomic, retain) IBOutlet UIButton *btnChangepwd;
@property (nonatomic) int userId;

@end
