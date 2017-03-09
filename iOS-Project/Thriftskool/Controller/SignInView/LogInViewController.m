//
//  LogInViewController.m
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "LogInViewController.h"
#import "HomeViewController.h"
#import "TabViewController.h"
#import "AppDelegate.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // Add Back Button
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:40.0];
    button.frame = CGRectMake(13, 26, 30.0, 30.0);
    [button setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [button setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    btnLogIn.layer.cornerRadius = 6.0;
    btnLogIn.layer.borderWidth = 1.0;
    btnLogIn.layer.borderColor = [UIColor whiteColor].CGColor;
    btnLogIn.titleLabel.font = FontBold;
    
    txtUsername.placeholder = @"Email";
    txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    txtPassword.placeholder = @"Password";
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    
    btnForgotPwd.tag = 789;
    btnForgotUsername.tag = 456;
    [btnForgotPwd addTarget:self action:@selector(btnForgotUserNameClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnForgotUsername addTarget:self action:@selector(btnForgotUserNameClick:) forControlEvents:UIControlEventTouchUpInside];

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

}

-(void)viewWillAppear:(BOOL)animated
{
   [self observeKeyboard];
//    self.tabBarController.tabBar.translucent = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [self RemoveObserveKeyboard];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.translucent = YES;

}


#pragma mark - Button action
-(IBAction)btnLogInClicked:(id)sender
{
    
    if (txtUsername.text.length> 0)
    {
        if (txtPassword.text.length>0)
        {
        if([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;

            [MBProgressHUD showHUDAddedTo:self.view animated:false];
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:txtUsername.text forKey:@"username"];
            [dic setObject:txtPassword.text forKey:@"password"];
            NSString *strDeviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceToken"];
            if (strDeviceToken) {
             [dic setObject:strDeviceToken forKey:@"device_id"];
            }
            else
            {
              [dic setObject:@"015ca64ec97df6b005d0c0ee6ce3275424a09a832d02e0481b48083e777504da" forKey:@"device_id"];
            }
            
            NSLog(@"login with token:%@",dic);
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"login";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dic caseName:@"login" withToken:NO];
            
        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"InternetAvailable", nil)];
        }
        }
        else{
            [self.view makeToast:NSLocalizedString(@"Blank_password", nil)];
        }

    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"Blank_username", nil)];
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
    
    keyboardHeight.constant=height-85;
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        [self.view layoutIfNeeded]
        ;
    }];
    
    imgY.constant = 200;
    
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyboardHeight.constant = 0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    imgY.constant = 50;
}


#pragma mark - UITextFiled Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([txtUsername isFirstResponder]) {
        [txtUsername resignFirstResponder];
        
    }
    else if ([txtPassword isFirstResponder])
    {
        [txtPassword resignFirstResponder];
    }
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:txtUsername] || [textField isEqual:txtPassword])
    {
        //now preparing the toolbar which will be displayed at the top of the keyboard
        UIToolbar  *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 44)];
        pickerToolbar.barStyle=UIBarStyleDefault;
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked:)];
        done.tintColor = txtFieldTextColor;
        [pickerToolbar setItems:[[NSArray alloc] initWithObjects: done, nil]];
        [textField setInputAccessoryView:pickerToolbar];
        
    }

    return YES;
}

#pragma mark -Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    int status = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (strstatuscode == 500)
    {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (status == 200)
    {
        if ([nState isEqualToString:@"login"])
        {
            NSMutableDictionary *dictUniversityList = (NSMutableDictionary*)arrData;
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setBool:true forKey:@"userLogin"];
            
            TabViewController *tabviewObj= [self.storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
            tabviewObj.strUserName = [[dictUniversityList valueForKey:@"Response"] valueForKey:@"user_name"];
            tabviewObj.strUniversityName =[[dictUniversityList valueForKey:@"Response"] valueForKey:@"university_name"];
            tabviewObj.userID = [[[dictUniversityList valueForKey:@"Response"] valueForKey:@"login_id"] intValue] ;
            tabviewObj.strEmail=[[dictUniversityList valueForKey:@"Response"] valueForKey:@"email_id"] ;
            tabviewObj.universityID = [[[dictUniversityList valueForKey:@"Response"] valueForKey:@"university_id"] intValue];
            tabviewObj.strLogin = @"Successfully Login";
            
            [GlobalMethod shareGlobalMethod].userID = tabviewObj.userID;
            [GlobalMethod shareGlobalMethod].strUserName = tabviewObj.strUserName;
            
            [Mint sharedInstance].userIdentifier = [GlobalMethod shareGlobalMethod].strUserName;

            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dictUniversityList];
            [defaults setObject:data forKey:@"loginArray"];
//            [defaults setValue:dictUniversityList forKey:@"loginArray"];
            [defaults synchronize];
            [self.navigationController pushViewController:tabviewObj animated:NO];
            
            if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0)
            {
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            }
           
        }
        if ([nState isEqualToString:@"forgotname"])
        {
             [self.view makeToast:@"Thank you. Please check your email inbox."];
        }
        if ([nState isEqualToString:@"forgotpassword"])
        {
            [self.view makeToast:@"Thank you. Please check your email inbox."];
        }
        
    }
    else if (status == 400)
    {
        self.navigationController.view.userInteractionEnabled = true;

        [self.view makeToast:@"Bad Request due to invalid parameters."];
        
    }
    
    else if (status == 404)
    {
         [self.view makeToast:@"Invalid username or password."];
        
    }
    else if (status == 401)
    {
        [self.view makeToast:@"Unauthorized access."];
        
    }

    else if (status == 4011)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please verify your email address to access your account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
//        [self.view makeToast:@"Please verify your email address to access your account."];
    }
    else if (status == 1018)
    {
        [self.view makeToast:@"The requested email is not found."];
    }
    else if (status == 208)
    {
        [self.view makeToast:@"Please use different Username for registration."];
    }
}

- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;
{
    
    NSLog(@"nstate %@",nState);
    //    [[GlobalMethod shareGlobalMethod]hideProgressView:self.view];
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.view makeToast:@"Internal Server Error"];
    //[[GlobalMethod shareGlobalMethod] AlertShow:NSLocalizedString(@"InternalServer", nil)/*[dictionary valueForKey:@"message"]*/ dele:self aTag:1 aTitle:NSLocalizedString(@"Alert", nil)];
    
}
#pragma mark - UIBUTTON ACTION METHOD
-(IBAction)btnForgotUserNameClick:(UIButton*)sender
{
    NSLog(@"sender %@",sender);
    if (sender.tag == 789) {
        isClickedPwd = true;
    }
    else
    {
        isClickedPwd = false;
    }
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        
//        CustomIOSAlertView *
        if (!alertView) {
            alertView = [[CustomIOSAlertView alloc] init];

        }
        
        // Add some custom content to the alert view
      [alertView setContainerView:[self createDemoView]];
        
        // Modify the parameters
        [alertView setButtonTitles:nil];
        [alertView setDelegate:self];
        [alertView setUseMotionEffects:TRUE];

        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView1, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView1 tag]);
            [alertView1 close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
    }

    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissCustomAlertview:)];
    [alertView addGestureRecognizer:tap];

    
}

-(void)doneButtonClicked:(id)sender
{
    if ([txtUsername isFirstResponder])
    {
        [txtUsername resignFirstResponder];
    }
    if ([txtPassword isFirstResponder])
    {
        [txtPassword resignFirstResponder];
    }
}


#pragma mark - Custom Alert
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView1 clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView1 tag]);
    [alertView1 close];
}

-(void)dismissCustomAlertview:(CustomIOSAlertView *)alert
{
    NSLog(@"alert %@",alert);
    NSLog(@"alert view %@",alertView);
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 135)];
    
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 289,30)];
    lbltitle.layer.cornerRadius = 3.0;
    lbltitle.text = @"Enter your email address";
    lbltitle.textAlignment = NSTextAlignmentLeft;
    lbltitle.textColor = txtFieldTextColor;
    lbltitle.font = FontRegular14;
    [demoView addSubview:lbltitle];
    
//    UITextField  *
    if (!txtEmail) {
        txtEmail =[[UITextField alloc] init];
    }
    txtEmail.frame = CGRectMake(10, lbltitle.frame.origin.y+lbltitle.frame.size.height+5, 270,35);
    txtEmail.layer.cornerRadius = 3.0;
    txtEmail.textAlignment = NSTextAlignmentLeft;
    txtEmail.borderStyle = UITextBorderStyleRoundedRect;
    txtEmail.layer.borderColor = NavigationBarBgColor.CGColor;
    txtEmail.layer.borderWidth = 1.0;
    txtEmail.layer.cornerRadius = 6.0;
    txtEmail.text = @"";
    //    lblCount.backgroundColor = [UIColor yellowColor];
    //    lblCount.textColor = [UIColor whiteColor];
    txtEmail.font = FontRegular16;
    [demoView addSubview:txtEmail];

    
    UIButton *btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(demoView.frame.size.width/2-40, txtEmail.frame.origin.y+txtEmail.frame.size.height+20, 60, 30)];
    [btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
    [btnSubmit setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    btnSubmit.layer.cornerRadius = 6.0;
    btnSubmit.layer.borderColor = NavigationBarBgColor.CGColor;
    btnSubmit.layer.borderWidth = 1.0;
    btnSubmit.backgroundColor = NavigationBarBgColor;
    btnSubmit.titleLabel.font = FontRegular14;
    
    [btnSubmit addTarget:self action:@selector(btnSubmitClicked:) forControlEvents:UIControlEventTouchUpInside];
    [demoView addSubview:btnSubmit];
    demoView.backgroundColor = [UIColor whiteColor];
    return demoView;
}


-(void)btnSubmitClicked:(UITextField*)textEmail
{
    if (txtEmail.text.length>1) {
        
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
        //Valid email address
        
        if ([emailTest evaluateWithObject:txtEmail.text] == YES)
        {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;

            //Do Something
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            [dict setValue:txtEmail.text forKey:@"email"];
            
            if (isClickedPwd == true) {
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"forgotpassword";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"forgotpassword" withToken:NO];

            }
            else{
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"forgotname";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"forgotname" withToken:NO];
            }
            [alertView close];

        }
        else
        {
            [self.view makeToast:@"Please enter valid email address"];
        }


    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"Blank_email_address", nil)];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
