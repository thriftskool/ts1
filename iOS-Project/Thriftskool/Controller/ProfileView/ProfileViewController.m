//
//  ProfileViewController.m
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileTableViewCell.h"
#import "MyPostsViewController.h"
#import "MessagesViewController.h"
#import "EditProfileViewController.h"
#import "ChangePasswordViewController.h"
#import "StartScreenViewController.h"
#import "SendMessageViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"



#define mypostTextColor      [UIColor colorWithRed:224.0/255.0 green:66.0/255.0 blue:65.0/255.0 alpha:1.0]
#define watchListTextColor   [UIColor colorWithRed:23.0/255.0 green:121.0/255.0 blue:134.0/255.0 alpha:1.0]
#define messagesTextColor    [UIColor colorWithRed:244.0/255.0 green:165.0/255.0 blue:38.0/255.0 alpha:1.0]
#define EditProfileTextColor [UIColor colorWithRed:69.0/255.0 green:195.0/255.0 blue:233.0/255.0 alpha:1.0]
#define changepwdTextColor   [UIColor colorWithRed:134.0/255.0 green:10.0/255.0 blue:62.0/255.0 alpha:1.0]
#define contactAppTextColor  [UIColor colorWithRed:13.0/255.0 green:147.0/255.0 blue:22.0/255.0 alpha:1.0]
#define signoutTextColor     [UIColor colorWithRed:22.0/255.0 green:79.0/255.0 blue:193.0/255.0 alpha:1.0]
#define inviteFriendsColor   [UIColor colorWithRed:234.0/255.0 green:74.0/255.0 blue:28.0/255.0 alpha:1.0]


@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize watchlistobj,editprofileobj,mypostobj;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate.tabviewControllerObj.profileObj = self;
    
    // Do any additional setup after loading the view.
    
    arrayProfileList = [[NSArray alloc]initWithObjects:@"",@"My Posts",@"Watch List",@"Messages",@"Invite Friends",@"Edit Profile",@"Change Password",@"Contact App Admin",@"Sign-out", nil];
    
    arrayTextColorList = [[NSArray alloc]initWithObjects:@"",mypostTextColor,watchListTextColor,messagesTextColor,inviteFriendsColor,EditProfileTextColor,changepwdTextColor,contactAppTextColor,signoutTextColor, nil];
    
    arrayImageList = [[NSArray alloc]initWithObjects:@"",@"myposts.png",@"watch-list-43x43.png",@"messages.png",@"Invite Friends.png",@"edit-profile.png",@"change-password.png",@"contact-app.png",@"sing-out.png", nil];

    
    //Rigth Side Button
    UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    btnright.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btnright setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnright setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    btnright.frame = CGRectMake(0,1, 30.0, 20.0);
    [btnright addTarget:self action:@selector(btnrightClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnRightBellView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 30, 22)];
    btnRightBellView.bounds = CGRectOffset(btnRightBellView.bounds, 0,0);
    [btnRightBellView addSubview:btnright];
    UIBarButtonItem *bellBtn = [[UIBarButtonItem alloc]initWithCustomView:btnRightBellView];
    self.navigationItem.rightBarButtonItem = bellBtn;

    
    tblProfileView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tblProfileView.showsVerticalScrollIndicator = false;
    tblProfileView.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;
//    tblProfileView.separatorColor = [UIColor redColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];

    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(incrementBadge:)
                                   userInfo:nil
                                    repeats:YES];

}


-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [tblProfileView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = false;

    NSLog(@"%s",__PRETTY_FUNCTION__);
     self.navigationController.navigationBar.hidden = NO;
     self.navigationItem.title=@"MY PROFILE";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *arrtemp=[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"loginArray"]];
   // NSData *data = [[defaults objectForKey:@"loginArray"]objectForKey:@"Response"];
    arrayLoginDetails=[arrtemp valueForKey:@"Response"];
   // arrayLoginDetails = [NSKeyedUnarchiver unarchiveObjectWithData:data];

//    arrayLoginDetails = [[defaults valueForKey:@"loginArray"] valueForKey:@"Response"];
    if (arrayLoginDetails == nil)
    {
        arrayLoginDetails = [defaults valueForKey:@"loginArray"];
    }

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
    
    if (self.tabBarController.selectedIndex == 2)
    {
//        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber-1;
        
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
}
-(void)btnrightClicked
{
    NSLog(@"bell clicked");
    MessagesViewController *objMsgVC1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC1.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC1 animated:YES];
}


#pragma mark-UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 140;
    }
    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%d",@"SelectCategorycell",(int)indexPath.row];
    
    ProfileTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[ProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,60)];
        imgview.backgroundColor = [UIColor clearColor];
        cell1.selectedBackgroundView  = imgview;
        
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 10)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:separatorLineView];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    
    if (indexPath.row == 0) {
        cell1.backgroundColor = tableBackgroundColor;
        cell1.accessoryType = UITableViewCellAccessoryNone;
        
        cell1.lblUserData.text = [NSString stringWithFormat:@"%@ \n\n%@",[arrayLoginDetails valueForKey:@"user_name"],[arrayLoginDetails valueForKey:@"university_name"]];
        
        float numberOfLines = cell1.lblUserData.frame.size.height/ cell1.lblUserData.font.lineHeight;
        cell1.lblUserData.numberOfLines = numberOfLines;
        
        NSString *strpath = [NSString stringWithFormat:@"%@%@",[arrayLoginDetails valueForKey:@"profileimgpath"],[arrayLoginDetails valueForKey:@"profile_img"]];

        cell1.imageUniversity.image = [UIImage imageNamed:@"lodingicon.png"];
        if (![[arrayLoginDetails valueForKey:@"profile_img"] hasSuffix:@"<null>"])
        {
            NSURL *url = [NSURL URLWithString:strpath];
            NSString *cacheFilename = [url lastPathComponent];
//            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
            int index = (int)[url pathComponents].count-3;
            NSString *folderName =[[url pathComponents] objectAtIndex:index];
            
            NSLog(@"folderName %@",folderName);
            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];

            
            id image = [LazyLoadingImage imageDataFromPath:cachePath];
            if(image)
            {
                cell1.imageUniversity.image = (UIImage*)image;
            }
            else
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                 {
                     if (connectionError == nil)
                     {
                         cell1.imageUniversity.image = [UIImage imageWithData:data];
                         [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     }
                 }];
            }
            
        }
        
        cell1.imageProfile.hidden = YES;
    }
    else {
        cell1.backgroundColor = [UIColor whiteColor];
        cell1.imageUniversity.hidden = YES;
        cell1.lblUserData.hidden = YES;
        cell1.lblProfileData.text = [arrayProfileList objectAtIndex:indexPath.row];
        cell1.lblProfileData.textColor = [arrayTextColorList objectAtIndex:indexPath.row];
        cell1.imageProfile.image = [UIImage imageNamed:[arrayImageList objectAtIndex:indexPath.row]];
    }
    return cell1;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];  
        
    }
    
    if ([tableView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        
        cell.preservesSuperviewLayoutMargins = NO;
        
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 1) {
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
            
            mypostobj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostsViewController"];
            mypostobj.userID = _userID;
            [self.navigationController pushViewController:mypostobj animated:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
        
    }
        else if (indexPath.row == 2) {
            if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {

            watchlistobj = [self.storyboard instantiateViewControllerWithIdentifier:@"WatchListViewController"];
            watchlistobj.userID = _userID;
            watchlistobj.strUserName = _strUsername;
            [self.navigationController pushViewController:watchlistobj animated:YES];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }

        }
        else if (indexPath.row == 3) {
            if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
            if(!objMsgVC)
            {
                objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
            }
            //        objMsgVC.userId = _userID;
            //        objMsgVC.strUserName = _strUsername;
            objMsgVC.SelectMsgType = 1;
            [self.navigationController pushViewController:objMsgVC animated:YES];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }
            
        }
        else if (indexPath.row == 4)
        {
            NSMutableArray *array = [[NSMutableArray alloc]init];
            [self sendSMS:@"Hey! Download ThriftSkool :) https://itunes.apple.com/in/developer/thriftskool/id1042614301?mt=8" recipientList:array];
            
//            https://itunes.apple.com/in/app/thriftskool-cash-in-on-campus!/id1042614302?mt=8
//            https://itunes.apple.com/in/developer/thriftskool/id1042614301?mt=8
            
        }

        else if (indexPath.row == 5) {
            editprofileobj = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
            editprofileobj.strEmail = [arrayLoginDetails valueForKey:@"email_id"];
            editprofileobj.strUserName = [arrayLoginDetails valueForKey:@"user_name"];
            editprofileobj.strUniversityName = [arrayLoginDetails valueForKey:@"university_name"];
            editprofileobj.userID = [[arrayLoginDetails valueForKey:@"login_id"] intValue];
            editprofileobj.strUniversityImageName = [arrayLoginDetails valueForKey:@"university_image"] ;
            editprofileobj.dicProfileDetail=(NSDictionary*)arrayLoginDetails;
            [self.navigationController pushViewController:editprofileobj animated:YES];
        }
        else if (indexPath.row == 6) {
            ChangePasswordViewController *changepwdobj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
            changepwdobj.userId = [[arrayLoginDetails valueForKey:@"login_id"] intValue];
            [self.navigationController pushViewController:changepwdobj animated:YES];
        }
        else if (indexPath.row == 7) {
            SendMessageViewController *sendviewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SendMessageViewController"];
            sendviewObj.IsContactBtnClicked = true;
            
            [self.navigationController pushViewController:sendviewObj animated:YES];
        }

        else if (indexPath.row == 8)
        {
            NSLog(@"Sign out");
            UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to sign out?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"No",@"Yes", nil];
            [alertview show];
        }
    
}

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }

        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
//        [self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
        else if (result == MessageComposeResultSent)
            NSLog(@"Message sent");
            else 
                NSLog(@"Message failed");
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setBool:false forKey:@"userLogin"];
        [defaults synchronize];
        
        StartScreenViewController *loginpage = [self.storyboard instantiateViewControllerWithIdentifier:@"StartScreenViewController"];
        [self presentViewController:loginpage animated:YES completion:nil];
        
        if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0)
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }

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
