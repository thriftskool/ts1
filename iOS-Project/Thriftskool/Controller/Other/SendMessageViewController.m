//
//  SendMessageViewController.m
//  Thriftskool
//
//  Created by Asha on 16/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "SendMessageViewController.h"
#import "WatchListDetailViewController.h"
#import "WatchListViewController.h"
#import "ProfileViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"


@interface SendMessageViewController ()

@end

@implementation SendMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_IsContactBtnClicked == false) {
    
        NSLog(@"reply");
        self.navigationItem.title = @"REPLY TO POST";
        lbl.hidden = YES;
        

    }
    else
    {
        NSLog(@"Contact");
        self.navigationItem.title = @"CONTACT US";
        lbl.hidden  = NO;
    }

    if ([txtview.text isEqualToString:@"Enter message"]) {
        txtview.textColor  = [UIColor colorWithRed:195.0/255.0 green:194.0/255.0 blue:201.0/255.0 alpha:1.0];
    }

    btnsend.backgroundColor = NavigationBarBgColor;
    btnsend.layer.cornerRadius = 6.0;
    btnsend.titleLabel.font = FontBold16;
    self.navigationItem.hidesBackButton = YES;
    
    //LeftSide Button
    UIButton *btnleftside = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleftside.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btnleftside.frame = CGRectMake(0, 0, 20.0, 50.0);
    [btnleftside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleftside setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [btnleftside addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewleftside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20.0, 50.0)];
    viewleftside.bounds = CGRectOffset(viewleftside.bounds, 0, 0);
    [viewleftside addSubview:btnleftside];
    UIBarButtonItem *barleftside = [[UIBarButtonItem alloc]initWithCustomView:viewleftside];
    self.navigationItem.leftBarButtonItem = barleftside;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismisskeyboardWhenOutSideTap)];
    [self.view addGestureRecognizer:tap];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arrtemp=[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"loginArray"]];
    userInfo =  [arrtemp valueForKey:@"Response"];
    //userInfo = [[defaults valueForKey:@"loginArray"] valueForKey:@"Response"];
    if (userInfo == nil) {
        userInfo = [defaults valueForKey:@"loginArray"];
    }

}
-(void)viewDidDisappear:(BOOL)animated
{
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
#pragma mark - UITextView deleagte
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter message"]) {
        txtview.text = @"";
        txtview.textColor = txtFieldTextColor;
    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:txtview]) {
        txtview.text = textView.text;
        txtview.textColor = txtFieldTextColor;
    }
    if (textView.text.length < 1) {
        txtview.text = @"Enter message";
        txtview.textColor = [UIColor colorWithRed:195.0/255.0 green:194.0/255.0 blue:201.0/255.0 alpha:1.0];;
    }
}
#pragma mark - BUtton method
-(void)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnSendClicked:(id)sender
{
    if (_IsContactBtnClicked == true) {
        
        if (txtview.text.length>0 && ![txtview.text isEqualToString:@"Enter message"])
        {
            if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
            {
                
                self.navigationController.view.userInteractionEnabled = false;
                self.tabBarController.view.userInteractionEnabled = false;

                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                [dict setValue:[userInfo valueForKey:@"login_id"] forKey:@"user_id"];
                [dict setValue:[userInfo valueForKey:@"user_name"] forKey:@"user_name"];
                [dict setValue:[userInfo  valueForKey:@"email_id"] forKey:@"user_email"];
                
                
                [dict setValue:txtview.text forKey:@"message"];
                
                NSLog(@"current date %@",[NSDate date]);
                //neha
//                NSDateFormatter *format = [[NSDateFormatter alloc] init];
//                [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
//                format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//                NSString *date = [format stringFromDate:[NSDate date]];
                //
                
                
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"]; // Prevent adjustment to user's local time zone.
                [format setTimeZone:timeZone];
                [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *date = [format stringFromDate:[NSDate date]];

                
                
                [dict setValue:date forKey:@"dt_createdate"];
                NSLog(@"dict %@",dict);
                
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"contactus";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"contactus" withToken:NO];
            }
            else
            {
//                [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];

            }
        }
        
        else{
            [self.view makeToast:@"Message can not be blank."];
        }

    }
    else
    {
        if (txtview.text.length>0 && ![txtview.text isEqualToString:@"Enter message"]) {
            
            if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
                self.navigationController.view.userInteractionEnabled = false;
                self.tabBarController.view.userInteractionEnabled = false;

                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"post_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",_userId] forKey:@"user_id"];
                [dict setValue:_strUserName forKey:@"user_name"];
                [dict setValue:txtview.text forKey:@"message"];
                [dict setValue:_strPostName forKey:@"post_name"];
                
//                NSDateFormatter *format = [[NSDateFormatter alloc] init];
//                [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
//                format.dateFormat = @"yyyy-MM-dd hh:mm:ss";
//                NSLog(@"%@", [format stringFromDate:[NSDate date]]);
//                NSString *date = [format stringFromDate:[NSDate date]];
                
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"]; // Prevent adjustment to user's local time zone.
                [format setTimeZone:timeZone];
                [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *date = [format stringFromDate:[NSDate date]];

                [dict setValue:date forKey:@"create_date"];
                NSLog(@"REPLY dict %@",dict);
                
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"send_message";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"send_message" withToken:NO];
            }
            else
            {
                [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
            }
        }
        else{
            [self.view makeToast:@"Please Enter message text."];
        }
    }
}

#pragma mark - ConnectionDelegate
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    
    NSArray *array = [nData JSONValue];
    NSLog(@"array %@",array);
    int statusCode = [[[array valueForKey:@"Response"] valueForKey:@"status"] intValue];
    NSLog(@"statuscode ==> %d",statusCode);
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if (statusCode == 201) {
        if ([nState isEqualToString:@"contactus"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [appDelegate.tabviewControllerObj.profileObj.watchlistobj.watchdetailObj.view makeToast:@"Thank you for contacting us, we will get back to you shortly."];
            [appDelegate.tabviewControllerObj.profileObj.view makeToast:@"Thank you for contacting us, we will get back to you shortly."];
            
            [appDelegate.tabviewControllerObj.homeviewObj.selectcatpostlistObj.selectDetailObj.view makeToast:@"Thank you for contacting us, we will get back to you shortly."];

        }
        if ([nState isEqualToString:@"send_message"])
        {
            [self.navigationController popViewControllerAnimated:YES];
            
            [appDelegate.tabviewControllerObj.profileObj.watchlistobj.watchdetailObj.view makeToast:@"Message sent."];
            
            [appDelegate.tabviewControllerObj.homeviewObj.selectcatpostlistObj.selectDetailObj.view makeToast:@"Message sent."];
            appDelegate.tabviewControllerObj.homeviewObj.selectcatpostlistObj.selectDetailObj.threadCount = 1;

        }
    }
    else if (statusCode == 400)
    {
        [self.view makeToast:@"Bad Request due to invalid parameters."];
    }
    else if (statusCode == 401)
    {
        [self.view makeToast:@"Unauthorized access."];
    }
}

-(void)ConnectionDidFail:(NSString *)nState Data:(NSString *)nData
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [self.view makeToast:@"Internal Server Error"];


}

-(void)dismisskeyboardWhenOutSideTap
{
    if ([txtview isFirstResponder]) {
        [txtview resignFirstResponder];

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
