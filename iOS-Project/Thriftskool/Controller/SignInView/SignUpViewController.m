//
//  SignUpViewController.m
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "SignUpViewController.h"
#import "PrivacyPocilyViewController.h"
#import "UniversityListViewController.h"
#import "AppDelegate.h"
#import "UIView+Toast.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize universityObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"navi bar %@", self.navigationController.navigationBar);
    // Add Back Button
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:40.0];
    button.frame = CGRectMake(13, 26, 30.0, 30.0);
    [button setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [button setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    txtSelectUniversity.borderStyle = UITextBorderStyleRoundedRect;
    txtSelectUniversity.textColor = txtFieldTextColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btn.frame = CGRectMake(0, 0, 20.0, 20.0);
    [btn setTitleColor:txtFieldTextColor forState:UIControlStateNormal];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleRight] forState:UIControlStateNormal];
    txtSelectUniversity.rightView = btn;
    [txtSelectUniversity setRightViewMode:UITextFieldViewModeAlways];
    txtSelectUniversity.tag = 1;

    txtEmail.borderStyle = UITextBorderStyleRoundedRect;
    txtEmail.enabled = NO;
    txtEmail.tag = 2;
    
    txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    txtUsername.enabled = NO;
    txtUsername.tag = 3;
    
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtPassword.enabled = NO;
    txtPassword.tag = 4;
    
    txtConfirmPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtConfirmPassword.enabled = NO;
    txtConfirmPassword.tag=5;
    
    btnRegister.layer.borderColor = [UIColor whiteColor].CGColor;
    btnRegister.layer.borderWidth = 1.0;
    btnRegister.layer.cornerRadius = 6.0;
    btnRegister.titleLabel.font = FontBold;
    
//    btncheckmark = [[UIButton alloc]initWithFrame:CGRectMake(0,100, 35, 35)];
    [btncheckmark setImage:[UIImage imageNamed:@"registration_unselected.png"] forState:UIControlStateNormal];
    [btncheckmark addTarget:self action:@selector(btnCheckMarkClicked:) forControlEvents:UIControlEventTouchUpInside];
    checkmarkSelected = false;
    
//    CGRect frame = txtviewPrivacyPolicy.frame;
//    frame.size.height = 40;
//    txtviewPrivacyPolicy.frame = frame;
    
    NSMutableAttributedString *str12 = [[NSMutableAttributedString alloc]initWithString:@"I have read the Privacy Policy and agree to the Terms of Use."];
    [str12 addAttribute:NSLinkAttributeName value: @"https://Ihaveread" range: NSMakeRange(0,15)];
    [str12 addAttribute:NSForegroundColorAttributeName value: NavigationTitleColor range:NSMakeRange(0, 15)];
    
    [str12 addAttribute:NSLinkAttributeName value: @"https://PrivacyPolicy" range: NSMakeRange(16,14)];
    [str12 addAttribute: NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(16,14)];
    [str12 addAttribute:NSForegroundColorAttributeName value:NavigationTitleColor range:NSMakeRange(16, 14)];
    
    [str12 addAttribute:NSLinkAttributeName value: @"https://and" range: NSMakeRange(30,18)];
    [str12 addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor] range:NSMakeRange(30, 18)];
    
    [str12 addAttribute:NSLinkAttributeName value: @"https://TermsofUse" range: NSMakeRange(48,13)];
    [str12 addAttribute: NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(48,13)];
    [str12 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(48, 13)];

    txtviewPrivacyPolicy.editable= NO;
    txtviewPrivacyPolicy.selectable=YES;
    txtviewPrivacyPolicy.showsVerticalScrollIndicator=NO;
    txtviewPrivacyPolicy.attributedText=str12;
    txtviewPrivacyPolicy.font=FontRegular14;
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];


}

-(void)viewWillAppear:(BOOL)animated
{
    appDelegate.startscreenviewObj.signUpObj = self;
    [self observeKeyboard];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self RemoveObserveKeyboard];
}

#pragma mark - Button Method
-(IBAction)btnCheckMarkClicked:(id)sender
{
    NSLog(@"checkmark clicked");
    if (checkmarkSelected== true) {
        [sender setImage:[UIImage imageNamed:@"registration_unselected.png"] forState:UIControlStateNormal];
        checkmarkSelected= false;
    }
    else
    {
        checkmarkSelected = true;
        [sender setImage:[UIImage imageNamed:@"registration_selected.png"] forState:UIControlStateNormal];
        
    }
    
}

-(void)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnRegisterClicked:(id)sender
{
    if (txtSelectUniversity.text.length > 0)
    {
        if (txtEmail.text.length > 0)
        {
            if ([self isValiedEMailAddress:txtEmail.text])
            {
                if (txtUsername.text.length > 0)
                {
                    if (txtPassword.text.length>0)
                    {
                        if (txtConfirmPassword.text.length>0)
                        {
                        
                            if ([txtConfirmPassword.text isEqualToString:txtPassword.text]) {
                                if (checkmarkSelected == true) {
                                    [self postData];
                                }
                                else
                                {
                                    [self.view makeToast:NSLocalizedString(@"Blank_privacy_policy_check_box", nil)];
                                }
                            }
                            else
                            {
                                [self.view makeToast:NSLocalizedString(@"New_and_confirm_password_mismatch", nil)];
                            }
                        }
                        else
                        {
                            [self.view makeToast:NSLocalizedString(@"Blank_confirm_password",nil)];
                        }
                    }
                    else
                    {
                        [self.view makeToast:NSLocalizedString(@"Blank_password", nil)];
                    }
                }
                else
                {
                    [self.view makeToast:NSLocalizedString(@"Blank_username", nil)];
                }
            }else{
                [self.view makeToast:NSLocalizedString(@"Valied_email_address",nil)];
            }
        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"Blank_email_address",nil)];
        }
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"Blank_Select_university", nil)];
    }
}
-(void)postData
{
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
       [MBProgressHUD showHUDAddedTo:self.view animated:false];
        self.navigationController.view.userInteractionEnabled = false;
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        
        [dic setObject:[NSString stringWithFormat:@"%d",universityId] forKey:@"university_id"];
        
        if (![txtEmail.text isEqual:@""])
        {
//            NSString *str =[ NSString stringWithFormat:@"%@%@",txtEmail.text,lblDomainName.text];
//            [dic setObject:str forKey:@"email_id"];
            [dic setObject:txtEmail.text forKey:@"email_id"];
        }
        
        if (![txtUsername.text isEqual:@""])
        {
            NSString *str =[ NSString stringWithFormat:@"%@",txtUsername.text];
            [dic setObject:str forKey:@"user_name"];
        }
        
        if (![txtPassword.text isEqual:@""])
        {
            NSString *str =[ NSString stringWithFormat:@"%@",txtPassword.text];
            [dic setObject:str forKey:@"password"];
        }
        
        [dic setObject:@"123456" forKey:@"device_id"];
        
        NSLog(@"dic %@",dic);
        //        NSString *strUser = [NSString stringWithFormat:@"",strUserId];
        //        [[ConnectionServer sharedConnectionWithDelegate:self] getDataWithPUTRequest:dic caseName:@"registration"];
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"registration";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dic caseName:@"registration" withToken:NO];
        
        
    }
    else
    {
        [appDelegate.window makeToast:NSLocalizedString(@"InternetAvailable", nil)];
        
        
    }
    
}

//MARK:- KeyBoard
- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)RemoveObserveKeyboard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// The callback for frame-changing of keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height =  keyboardFrame.size.height;
    
    keyboardHeight.constant=height-75;
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        [self.view layoutIfNeeded]
        ;
    }];
    imgY.constant = 350;
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyboardHeight.constant = 10;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    imgY.constant = 180;

}


#pragma mark - University Delegate Method
-(void)selectUniversityName:(NSString *)name domain:(NSString *)domainName id:(NSString *)UniversityId imgName:(NSString *)UniImageName
{
    if (domainName != nil)
    {
        txtSelectUniversity.text = name;
//        lblDomainName.text = [NSString stringWithFormat:@"@%@",domainName];
        universityId = [UniversityId intValue];
        if (txtSelectUniversity.text.length > 0 ) {
            txtEmail.enabled = YES;
            txtPassword.enabled = YES;
            txtConfirmPassword.enabled = YES;
            txtUsername.enabled = YES;
        }
    }
}
#pragma mark - UITextField delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == txtUsername)
    {
        if ([string isEqualToString:@" "] )
        {
            return false;
        }
    }
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    if (textField.tag == 1)
    {
       // UniversityList1ViewController *universityObj = [self.storyboard instantiateViewControllerWithIdentifier:@"UniversityList1ViewController"];
        //[self.navigationController pushViewController:universityObj animated:NO];
        
//        UniversityListViewController *
        universityObj = [self.storyboard instantiateViewControllerWithIdentifier:@"UniversityListViewController"];
        universityObj.delegate = self;
        [self.navigationController pushViewController:universityObj animated:NO];
        [textField resignFirstResponder];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (txtSelectUniversity.text.length > 0 )
    {
        txtEmail.enabled = YES;
        txtPassword.enabled = YES;
        txtConfirmPassword.enabled = YES;
        txtUsername.enabled = YES;
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([txtEmail isFirstResponder])
    {
        [txtEmail resignFirstResponder];
    }
    
    else if ([txtUsername isFirstResponder])
    {
        [txtUsername resignFirstResponder];
    }
    
    else if ([txtConfirmPassword isFirstResponder])
    {
        [txtConfirmPassword resignFirstResponder];
    }
    
    else if ([txtPassword isFirstResponder])
    {
        [txtPassword resignFirstResponder];
    }
    
    return YES;
}

#pragma mark- UITextView delegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
     if([@"https://PrivacyPolicy" isEqualToString:[NSString stringWithFormat:@"%@",URL]])
    {
        PrivacyPocilyViewController *privacyPolicyobj=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPocilyViewController"];
        privacyPolicyobj.FromPrivacyPolicy = true;
        [self.navigationController pushViewController:privacyPolicyobj animated:YES];
    }
    else if ([@"https://Ihaveread" isEqualToString:[NSString stringWithFormat:@"%@",URL]])
    {
        [self btnCheckMarkClicked:btncheckmark];
    }
    else if ([@"https://TermsofUse" isEqualToString:[NSString stringWithFormat:@"%@",URL]])
    {
        PrivacyPocilyViewController *privacyPolicyobj=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPocilyViewController"];
        privacyPolicyobj.FromPrivacyPolicy = false;
        [self.navigationController pushViewController:privacyPolicyobj animated:YES];
    }
    return NO;
    
}




#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    

    [MBProgressHUD hideAllHUDsForView:self.view  animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
 
    int status = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (status ==201)
    {
        if ([nState isEqualToString:@"registration"])
        {
            self.navigationController.view.userInteractionEnabled = true;
//           NSMutableDictionary *dictUniversityList = (NSMutableDictionary*)arrData;
            txtSelectUniversity.text =@"";
            txtEmail.text = @"";
            txtUsername.text = @"";
            txtPassword.text = @"";
            txtConfirmPassword.text =@"";
           
            _strverify = @"A verification has been sent to your university email, please check to complete sign up.";
            [self.navigationController popViewControllerAnimated:YES];

        }
        
    }
    
    else if (status == 208)
    {
        [self.view makeToast:@"Please use different Username for registration."];
    }
    else if (status == 401)
    {
        [self.view makeToast:@"You have already registered with this email address. Please verify it to access your account."];
    }
    else if (status == 400)
    {
        [self.view makeToast:@"Bad Request."];
 
    }
    
    else if (status == 500)
    {
    }
    
}

- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;
{
    
    NSLog(@"nstate %@",nState);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [self.view makeToast:@"Internal Server Error"];

}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) isValiedEMailAddress:(NSString *) emailStr{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}
@end
