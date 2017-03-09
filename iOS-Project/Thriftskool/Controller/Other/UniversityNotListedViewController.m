//
//  UniversityNotListedViewController.m
//  Thriftskool
//
//  Created by Asha on 18/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "UniversityNotListedViewController.h"

@interface UniversityNotListedViewController ()

@end

@implementation UniversityNotListedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"UNIVERSITY NOT LISTED?";
    self.navigationItem.hidesBackButton = YES;
    
    //Bell Button
    UIButton *btnBell = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBell.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    btnBell.frame = CGRectMake(0, 0, 30, 22);
    [btnBell setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBell setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    [btnBell addTarget:self action:@selector(btnBellClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewBellside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    viewBellside.bounds = CGRectOffset(viewBellside.bounds, 0, 0);
    [viewBellside addSubview:btnBell];
    UIBarButtonItem *barBell = [[UIBarButtonItem alloc]initWithCustomView:viewBellside];
    self.navigationItem.rightBarButtonItem = barBell;

    //LeftSide Button
    UIButton *btnleftside = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleftside.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btnleftside.frame = CGRectMake(0, 0, 20.0, 50.0);
    [btnleftside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleftside setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [btnleftside addTarget:self action:@selector(btnBackBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewleftside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20.0, 50.0)];
    viewleftside.bounds = CGRectOffset(viewleftside.bounds, 0, 0);
    [viewleftside addSubview:btnleftside];
    UIBarButtonItem *barleftside = [[UIBarButtonItem alloc]initWithCustomView:viewleftside];
    self.navigationItem.leftBarButtonItem = barleftside;
    
    
    /// UI
    
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(10, 64+10, screenWidth-20, 80)];
    lbl.text = @"Please enter your university email below so we know to get ThriftSkool on your campus and can notify you when it’s unlocked, thanks!";
    lbl.font = FontRegular16;
    lbl.numberOfLines = lbl.frame.size.height/lbl.font.lineHeight;
    [self.view addSubview:lbl];
    
    txtUniName = [[UITextField alloc]initWithFrame:CGRectMake(10, lbl.frame.origin.y+lbl.frame.size.height+10,  screenWidth-20, 40)];
    txtUniName.backgroundColor = [UIColor whiteColor];
    txtUniName.placeholder =@"University name";
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    txtUniName.leftView = paddingView;
    txtUniName.leftViewMode = UITextFieldViewModeAlways;
    txtUniName.font = FontRegular;
    txtUniName.delegate = self;
    [self.view addSubview:txtUniName];
    
    txtEmail = [[UITextField alloc]initWithFrame:CGRectMake(10, txtUniName.frame.origin.y+txtUniName.frame.size.height+10,  screenWidth-20, 40)];
    txtEmail.backgroundColor = [UIColor whiteColor];
    txtEmail.placeholder =@"University contact email address";
    txtEmail.delegate = self;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];

    txtEmail.leftView = paddingView1;
    txtEmail.leftViewMode = UITextFieldViewModeAlways;
    txtEmail.font = FontRegular;

    [self.view addSubview:txtEmail];

    btnsend = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2-30, txtEmail.frame.origin.y+txtEmail.frame.size.height+30, 60, 40)];
    btnsend.backgroundColor = NavigationBarBgColor;
    btnsend.layer.cornerRadius = 6.0;
    [btnsend setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnsend setTitle:@"SEND" forState:UIControlStateNormal];
    [btnsend addTarget:self action:@selector(btnSendClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnsend.titleLabel.font = FontBold16;
    [self.view addSubview:btnsend];
    
    self.view.backgroundColor = tableBackgroundColor;
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

}

#pragma mark - Button Click event

-(void)btnBellClicked
{
//    NSLog(@"bell clicked");
//    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
//    //  objMsgVC.userId = _userId;
//    //   objMsgVC.strUserName = _strUserName;
//    objMsgVC.SelectMsgType = 0;
//    [self.navigationController pushViewController:objMsgVC animated:YES];
    
}

-(void)btnBackBtnClicked
{
    NSLog(@"Back clicked");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnSendClicked:(id)sender
{
    NSLog(@"Clicked");
    
    if (txtUniName.text.length>1)
    {
        
        if (txtEmail.text.length>1) {
        NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];

        
        if ([emailTest evaluateWithObject:txtEmail.text] == YES)
        {
            if([GlobalMethod shareGlobalMethod].connectedToNetwork)
            {
                self.navigationController.view.userInteractionEnabled = false;
                self.tabBarController.view.userInteractionEnabled = false;

                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                format.dateFormat = @"yyyy-MM-dd hh:mm:ss";
                NSLog(@"%@", [format stringFromDate:[NSDate date]]);
                NSString *date = [format stringFromDate:[NSDate date]];
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setValue:txtUniName.text forKey:@"university_name"];
                [dict setValue:txtEmail.text forKey:@"email"];
                [dict setValue:date forKey:@"dt_createdate"];
                
                NSLog(@"dict %@",dict);
                
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"university_request";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"university_request" withToken:NO];
            }
            else{
                [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
            }

        }
        else
        {
            [self.view makeToast:@"Please enter valid email address"];
        }
        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"Blank_University_Contact_email",nil)];
        }
        
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"Blank_university_name",nil)];
    }
    
    
}
#pragma mark -  UITextField delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:txtEmail]) {
        txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([txtUniName isFirstResponder]) {
        [txtUniName resignFirstResponder];
    }
    if ([txtEmail isFirstResponder]) {
        [txtEmail resignFirstResponder];
    }
    return YES;
}

#pragma mark - connection delegate
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    NSArray *arra = [nData JSONValue];
    NSLog(@"arra %@",arra);
 
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    int status =[[[arra valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (status == 201) {
        [self.navigationController popViewControllerAnimated:YES];
        [appDelegate.startscreenviewObj.signUpObj.universityObj.view makeToast:NSLocalizedString(@"university_not_found_send", nil)];
    }
}

-(void)ConnectionDidFail:(NSString *)nState Data:(NSString *)nData
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
