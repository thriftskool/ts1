//
//  ChangePasswordViewController.m
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"



@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"CHANGE PASSWORD";
    
    //Rigth Side Button
    UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    btnright.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btnright setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnright setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    btnright.frame = CGRectMake(0,1, 30.0, 20.0);
    [btnright addTarget:self action:@selector(btnBellClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnRightBellView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 30, 22)];
    btnRightBellView.bounds = CGRectOffset(btnRightBellView.bounds, 0,0);
    [btnRightBellView addSubview:btnright];
    UIBarButtonItem *bellBtn = [[UIBarButtonItem alloc]initWithCustomView:btnRightBellView];
    self.navigationItem.rightBarButtonItem = bellBtn;

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
    
    self.viewChangePwd.backgroundColor = tableBackgroundColor;
    self.btnChangepwd.layer.cornerRadius = 6.0;
    self.btnChangepwd.titleLabel.font = FontBold16;

    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    self.txtOldPwd.leftView = paddingView;
    self.txtOldPwd.leftViewMode = UITextFieldViewModeAlways;
    self.txtOldPwd.font = FontRegular16;

    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    self.txtNewPwd.leftView = paddingView2;
    self.txtNewPwd.leftViewMode = UITextFieldViewModeAlways;
    self.txtNewPwd.font = FontRegular16;

    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    self.txtConfirmNewPwd.leftView = paddingView3;
    self.txtConfirmNewPwd.leftViewMode = UITextFieldViewModeAlways;
    self.txtConfirmNewPwd.font = FontRegular16;

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(incrementBadge:)
                                   userInfo:nil
                                    repeats:YES];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = false;

}


#pragma mark - PushNOtification count
-(void)incrementBadge:(id)sender
{
//    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].notificationCount];
    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber];

}

-(void)pushNotificationReceived:(NSArray*)array
{
    NSLog(@"array push %@",array);
    NSLog(@"array push2 %@", [[array valueForKey:@"userInfo"] valueForKey:@"aps"]);
    
    //    [self btnBellClicked];
    NSString *notificationType = [[[array valueForKey:@"userInfo"] valueForKey:@"aps"] valueForKey:@"notification_type"];
    
    NSDictionary *dicNotification = [[array valueForKey:@"userInfo"] valueForKey:@"aps"];
    if([notificationType isEqualToString:@"0"])
    {
        MessageDetailViewController *msgDetailViewObj =[self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
        msgDetailViewObj.strPostName = [dicNotification valueForKey:@"name"];
        msgDetailViewObj.readID = [[dicNotification valueForKey:@"user_id"] intValue];
        //             msgDetailViewObj.userID = _userId;
        msgDetailViewObj.threadID = [[dicNotification valueForKey:@"thread_id"]intValue];
        msgDetailViewObj.postID = [[dicNotification valueForKey:@"id"]intValue];
        msgDetailViewObj.IsFromMsgList = false;
        // msgDetailViewObj.strUserName =  _strUserName;
        msgDetailViewObj.arrayFromMsgViewList = [dicNotification mutableCopy];
        NSLog(@"self.navigationController %@",self.navigationController);
        //        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
        //        NSLog(@"self.navigationController %@",nav);
        [self.navigationController pushViewController:msgDetailViewObj animated:YES];
    }
    else if([notificationType isEqualToString:@"1"] || [notificationType isEqualToString:@"2"])
    {
        MyPostDetailViewController *mypostDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostDetailViewController"];
        mypostDetailObj.dictPostDetail = [dicNotification mutableCopy];
        
        [self.navigationController pushViewController:mypostDetailObj animated:YES];
    }
    else if([notificationType isEqualToString:@"3"] || [notificationType isEqualToString:@"4"])
    {
        BuzzDetailViewController *buzzDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"BuzzDetailViewController"];
        // buzzDetailObj.buzzId = [[[arrayAllBuzzListDetail valueForKey:@"buzz_id"] objectAtIndex:indexPath.row] intValue];
        buzzDetailObj.dicBuzzDetail = [dicNotification mutableCopy];
        [self.navigationController pushViewController:buzzDetailObj animated:YES];
    }
    
}

#pragma mark - Button Click event
-(void)btnBellClicked
{
    NSLog(@"bell clicked");
    MessagesViewController *objMsgVC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC1.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC1 animated:YES];
    
}

-(void)btnBackBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnChangePwdClicked:(id)sender
{
    if ([self.txtOldPwd isFirstResponder]) {
        [self.txtOldPwd resignFirstResponder];
    }
    else if ([self.txtNewPwd isFirstResponder]) {
        [self.txtNewPwd resignFirstResponder];
    }

    else if ([self.txtConfirmNewPwd isFirstResponder]) {
        [self.txtConfirmNewPwd resignFirstResponder];
    }

    if (self.txtOldPwd.text.length>1)
    {
        if (self.txtNewPwd.text.length>1) {
            
            if (self.txtConfirmNewPwd.text.length>1) {
                
                if (![self.txtNewPwd.text isEqualToString:self.txtConfirmNewPwd.text]) {
                    [self.view makeToast:NSLocalizedString(@"New_and_confirm_password_mismatch", nil)];
                }
                else
                {
                    if ([[GlobalMethod shareGlobalMethod]connectedToNetwork]) {
                        
                        self.navigationController.view.userInteractionEnabled = false;
                        self.tabBarController.view.userInteractionEnabled = false;

                        
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        [dict setValue:[NSString stringWithFormat:@"%d",_userId] forKey:@"user_id"];
                        [dict setValue:self.txtOldPwd.text forKey:@"old_password"];
                        [dict setValue:self.txtNewPwd.text forKey:@"new_password"];
                        
                        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"changepassword";
                        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"changepassword" withToken:NO];
                    }
                    else
                    {
//                        [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];

                    }
                }
            }
            else
            {
                [self.view makeToast:NSLocalizedString(@"Blank_confirm_password", nil)];

            }
        }
        else{
            [self.view makeToast:NSLocalizedString(@"Blank_New_password", nil)];
        }
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"blank_old_password", nil)];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isFirstResponder])
    {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - connection delegate
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    NSArray *array = [nData JSONValue];
    int status = [[[array valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    if(status == 204)
    {
        [appDelegate.tabviewControllerObj.profileObj.view makeToast:NSLocalizedString(@"change_password", nil)];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (status == 1021) {
        [self.view makeToast:@"Please enter correct old password."];
    }
    if (status == 400) {
        [self.view makeToast:@"Bad Request due to invalid parameters."];
        
    }
    if (status == 401) {
        [self.view makeToast:@"Unauthorized access"];
    }
}

-(void)ConnectionDidFail:(NSString *)nState Data:(NSString *)nData{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [self.view makeToast:@"Internal Server Error"];


}

#pragma  mark -
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
