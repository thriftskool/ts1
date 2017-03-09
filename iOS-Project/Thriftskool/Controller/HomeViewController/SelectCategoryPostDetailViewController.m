//
//  SelectCategoryPostDetailViewController.m
//  Thriftskool
//
//  Created by Asha on 07/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "SelectCategoryPostDetailViewController.h"
#import "OpenImageViewController.h"
#import "SendMessageViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"
#import "PostOwnerDetailViewController.h"

@interface SelectCategoryPostDetailViewController ()

@end

@implementation SelectCategoryPostDetailViewController
@synthesize postCatID,universityID;
- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate.tabviewControllerObj.homeviewObj.selectcatpostlistObj.selectDetailObj =self;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = [_strNavigationTitle uppercaseString];
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

    
    //Bell Button
    UIButton *btnBell = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBell.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    btnBell.frame = CGRectMake(0, 0, 30, 22);
    [btnBell setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBell setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    [btnBell addTarget:self action:@selector(btnBellClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewBellside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    viewBellside.bounds = CGRectOffset(viewBellside.bounds, 0, 0);
    [viewBellside addSubview:btnBell];
    UIBarButtonItem *barBell = [[UIBarButtonItem alloc]initWithCustomView:viewBellside];
    self.navigationItem.rightBarButtonItem = barBell;

    
    //UI
    viewButton = [[UIView alloc]init];
    viewButton.backgroundColor = tableBackgroundColor;
    viewButton.frame = CGRectMake(0,screenHeight-navBarHeight-tabBarHeight+7, screenWidth, 30);
    NSArray *arrayDetail  = [_dictDetail valueForKey:@"ResponseAllDetail"];
    
    int idUser = [[arrayDetail valueForKey:@"user_id"] intValue];
    if (idUser == 0) {
        idUser = [[_dictDetail valueForKey:@"post_user_id"] intValue];
    }
    
    if (_userID == idUser) {
        viewButton.hidden = YES;
    }
    else {
        viewButton.hidden = NO;
    }

    
    
    viewscroll = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight-330)];
    viewscroll.userInteractionEnabled = YES;
    
 //   UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapOnImage:)];
    //[viewscroll addGestureRecognizer:tap];
    
//    viewscroll.backgroundColor = [UIColor blueColor];
    [self.view addSubview:viewscroll];

    //scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/2-20)];
    scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-270)];

//    scrollviewimage.backgroundColor = [UIColor yellowColor];

    [self changeAllViewFrame];
    
    UIView *viewNameAndPrice = [[UIView alloc]initWithFrame:CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 30)];
    viewNameAndPrice.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
   /* lblPrice = [[UILabel alloc]init];
    lblPrice.frame = CGRectMake(10, 5, screenWidth, 20);
    lblPrice.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblPrice.textColor = [UIColor whiteColor];
    [viewNameAndPrice addSubview:lblPrice];*/
    
    lblName = [[UILabel alloc]init];
    lblName.frame = CGRectMake(10, 5, screenWidth, 20);
    lblName.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblName.textColor = [UIColor whiteColor];
    [viewNameAndPrice addSubview:lblName];
    [self.view addSubview:viewNameAndPrice];
    
    UIView *dateview = [[UIView alloc]initWithFrame:CGRectMake(0, viewNameAndPrice.frame.origin.y+viewNameAndPrice.frame.size.height, screenWidth, 30)];
    dateview.backgroundColor = tableBackgroundColor;
    lblPrice = [[UILabel alloc]init];
    lblPrice.frame = CGRectMake(10, 5, screenWidth, 20);
    lblPrice.backgroundColor = tableBackgroundColor;
    lblPrice.textColor = [UIColor grayColor];
   /*lblDate = [[UILabel alloc]init];
    lblDate.frame = CGRectMake(10,0, screenWidth/2, 30);
    lblDate.backgroundColor = tableBackgroundColor;
    lblDate.font = FontRegular16;
    lblDate.textColor = [UIColor grayColor];*/
    [dateview addSubview:lblPrice];
    
    
    lblExpired = [[UILabel alloc]init];
    lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 30);
    lblExpired.backgroundColor = tableBackgroundColor;
    lblExpired.font = FontRegular16;
    lblExpired.textAlignment = NSTextAlignmentRight;
    lblExpired.textColor = [UIColor grayColor];
    
    [dateview addSubview:lblExpired];
    [self.view addSubview:dateview];
    
   
    
    
    //Reply Button
    UIButton *btnReply = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReply.frame = CGRectMake(20, 7, 45, 20);
    [btnReply setTitleColor:[UIColor colorWithRed:22.0/255.0 green:79.0/255.0 blue:193.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnReply setTitle:@"Reply" forState:UIControlStateNormal];
    btnReply.titleLabel.font = FontRegular16;
    [btnReply addTarget:self action:@selector(btnReplyClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnReply];
    
    UIButton *btnReplyImg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReplyImg.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    btnReplyImg.frame = CGRectMake(btnReply.frame.origin.x+btnReply.frame.size.width, 7, 15, 20);
    [btnReplyImg setTitleColor:[UIColor colorWithRed:22.0/255.0 green:79.0/255.0 blue:193.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnReplyImg setTitle:[NSString fontAwesomeIconStringForEnum:FAEnvelope] forState:UIControlStateNormal];
    [btnReplyImg addTarget:self action:@selector(btnReplyClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [viewButton addSubview:btnReplyImg];
    
    //Profile Button
    UIButton *btnProfile = [UIButton buttonWithType:UIButtonTypeCustom];
    btnProfile.frame = CGRectMake((self.view.frame.size.width-90)/2, 7, 90, 20);
//    [btnProfile setTitleColor:[UIColor colorWithRed:22.0/255.0 green:79.0/255.0 blue:193.0/255.0 alpha:1.0] forState:UIControlStateNormal];
     [btnProfile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnProfile setImage:[UIImage imageNamed:@"person-icon"] forState:UIControlStateNormal];
     [btnProfile setImageEdgeInsets:UIEdgeInsetsMake(0.0, 73.0, 2.0, 0)];
    [btnProfile setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 10)];
    [btnProfile setTitle:@"Profile" forState:UIControlStateNormal];
    btnProfile.titleLabel.font = FontRegular16;
    [btnProfile addTarget:self action:@selector(btnEditprofileClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnProfile];
    
    //Contact Button
    UIButton *btnContact = [UIButton buttonWithType:UIButtonTypeCustom];
    btnContact.frame = CGRectMake(screenWidth/2-30, 7, 60, 20);
    [btnContact setTitleColor:[UIColor colorWithRed:55.0/255.0 green:56.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnContact setTitle:@"Contact" forState:UIControlStateNormal];
    btnContact.titleLabel.font = FontRegular16;
    [btnContact addTarget:self action:@selector(btnContactClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [viewButton addSubview:btnContact];
    
    UIButton *btnContactImg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnContactImg.frame = CGRectMake(btnContact.frame.origin.x+btnContact.frame.size.width, 7, 15, 15);
    [btnContactImg setImage:[UIImage imageNamed:@"contact-icon.png"] forState:UIControlStateNormal];
    [btnContactImg addTarget:self action:@selector(btnContactClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    [viewButton addSubview:btnContactImg];
    
    //Report Button
    UIButton *btnReport = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReport.frame = CGRectMake(screenWidth-80, 5, 50, 20);
    btnReport.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    [btnReport setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnReport setTitle:@"Report" forState:UIControlStateNormal];
    [btnReport addTarget:self action:@selector(btnReportClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnReport];
    
    UIButton *btnReportImg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReportImg.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:18.0];
    btnReportImg.frame = CGRectMake(btnReport.frame.origin.x+btnReport.frame.size.width, 5, 20, 20);
    [btnReportImg setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnReportImg setTitle:[NSString fontAwesomeIconStringForEnum:FAExclamationCircle] forState:UIControlStateNormal];
    [btnReportImg addTarget:self action:@selector(btnReportClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnReportImg];
    
    
    [self.view addSubview:viewButton];
    
    txtviewDecscription = [[UITextView alloc]init];
    if(viewButton.isHidden)
    {
    txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-5, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+tabBarHeight));
    }
    else{
        txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-5, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+viewButton.frame.size.height+tabBarHeight+20));

    }
    txtviewDecscription.backgroundColor = [UIColor whiteColor];
    txtviewDecscription.font = FontRegular16;
    txtviewDecscription.editable = false;
    txtviewDecscription.textColor = [UIColor grayColor];
    [self.view addSubview:txtviewDecscription];
    
    
    
    
    // Add fav button

 
    IsNextPageOpen = false;
    
    if (arrayDetail !=nil)
    {
        [self setDataToPOstDetail:[_dictDetail valueForKey:@"ResponseAllDetail"]];
        if ([[[_dictDetail valueForKey:@"ResponseAllDetail"] valueForKey:@"status"]  isEqual: @"1"]) {
            btnReply.hidden = YES;
            btnReplyImg.hidden = YES;
        }
        else
        {
        btnReply.hidden = NO;
        btnReplyImg.hidden = NO;
        }

    }
    else
    {
        btnReply.hidden = YES;
        btnReplyImg.hidden = YES;

    }
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
-(void)setDataToPOstDetail:(NSMutableArray*)arrayDetail;
{
    
    lblPrice.text =[NSString stringWithFormat:@"$%@",[arrayDetail valueForKey:@"price"]];
  //  lblPrice.textColor = NavigationTitleColor;
    
    NSString *str;
    
        if ([[arrayDetail valueForKey:@"status"] isEqualToString:@"1"]) {
            str= @"Expired";
        }
        
        else if ([[arrayDetail valueForKey:@"status"] isEqualToString:@"2"]) {
            str = @"Closed";
        }
        else
        {
            if ([arrayDetail valueForKey:@"expirydate"]==nil)
            {
                str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[arrayDetail valueForKey:@"create_date"]];
            }
            else
            {
                str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[arrayDetail valueForKey:@"expirydate"]];
            }
        }

    lblDate.text = [[GlobalMethod shareGlobalMethod]DateDisplayWithMonthName:[arrayDetail valueForKey:@"expirydate"] firstMonth:NO];
    lblExpired.text = str;
    lblName.text = [arrayDetail valueForKey:@"post_name"];
    lblName.textColor = NavigationTitleColor;
    txtviewDecscription.text = [arrayDetail valueForKey:@"description"];
    txtviewDecscription.font = FontRegular16;

}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *arrayAllDetailFromList = [_dictDetail valueForKey:@"ResponseAllDetail"];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    
    if (IsNextPageOpen == false)
    {
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            
            [MBProgressHUD showHUDAddedTo:viewscroll animated:YES];
            
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            
            int postid;
            if (arrayAllDetailFromList==nil)
            {
                postid = [[_dictDetail valueForKey:@"post_id"] intValue];
                [dict setValue:[_dictDetail valueForKey:@"user_id"] forKey:@"user_id"];

            }
            else
            {
                if ([arrayAllDetailFromList valueForKey:@"post_id"] == nil) {
                    postid = [[arrayAllDetailFromList valueForKey:@"id"] intValue];
                }
                else
                {
                    postid = [[arrayAllDetailFromList valueForKey:@"post_id"] intValue];
                    
                }
                
                [dict setValue:[arrayAllDetailFromList valueForKey:@"user_id"] forKey:@"user_id"];
            }
            
            [dict setValue:[NSString stringWithFormat:@"%d",postid] forKey:@"post_id"];
            [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_uid"];
            
            NSLog(@"dict %@",dict);
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_detail";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_detail" withToken:YES];
        }
        else
        {
            [self.view makeToast:@"Check Internet Connection"];
        }
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        arrayImageList =  [defaults valueForKey:@"ImageArrayInDetail"];
        arrayImageId = [defaults valueForKey:@"ImageIdArrayInDetail"];
        viewscroll.frame = CGRectMake(0, 64, screenWidth, screenHeight/2-80);
//        viewscroll.backgroundColor =[UIColor redColor];
//        scrollviewimage.backgroundColor =[UIColor yellowColor];
        [self ImageDisplayInscrollView:arrayImageList];
        
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    IsNextPageOpen = true;
    
}

#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    int status = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];

    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (status == 200)
    {
        if ([nState isEqualToString:@"post_detail"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            
            NSDictionary *dict = (NSDictionary*)arrData;
            
            NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
            if([[arrData valueForKey:@"Response"] valueForKey:@"imagepath"])
            {
                strPost = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
            }
            NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];

            for (int i = 0; i < arrayImage.count; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                if (!arrayImageList) {
                    arrayImageList = [[NSMutableArray alloc]init];
                }
                [arrayImageList addObject:str];
                
            }

            _threadCount = [[[dict valueForKey:@"Response"]valueForKey:@"thread_cnt"] intValue];
             arrayImageId = [[[dict valueForKey:@"Response"] valueForKey:@"images"] valueForKey:@"image_id"];
            if (!_arrayPostDetail) {
                _arrayPostDetail = [[NSMutableArray alloc]init];
            }
            _arrayPostDetail = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:arrayImageList forKey:@"ImageArrayInDetail"];
            [defaults setValue:arrayImageId forKey:@"ImageIdArrayInDetail"];
            [defaults synchronize];
            
            [self setDataToPOstDetail:_arrayPostDetail];
            [self ImageDisplayInscrollView:arrayImageList];
            
        }
        if ([nState isEqualToString:@"post_count"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            NSLog(@"dict %@",dict);
            arrayAllSelectFavBtnData = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
            
            [self.view makeToast:@"Thank you for your help, we will work to resolve this issue immediately." ];
        }

        if ([nState isEqualToString:@"go_to_message_list_from_reply"])
        {
            NSDictionary *dict = (NSDictionary*)arrData;
            NSLog(@"dict %@",dict);
        }
        
    }
    else if (status == 204)
    {
        HideNetworkActivityIndicator();
        if ([nState isEqualToString:@"make_favorite"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            NSLog(@"dict %@",dict);
            arrayAllSelectFavBtnData = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
            
            NSUserDefaults *deafults = [NSUserDefaults standardUserDefaults];
            [deafults setObject:arrayAllSelectFavBtnData forKey:@"arrayAllSelectFavBtnData"];
            [deafults synchronize];
        }
        
        if (favBtnStatus == 1)
        
        {
            [self.view makeToast:NSLocalizedString(@"Favorite_button_click_add", nil)];

        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"Favorite_button_click_remove", nil)];

        }
        
    }
    
    else if (status == 404)
    {
        HideNetworkActivityIndicator();

    }
    else if (status == 401)
    {
        HideNetworkActivityIndicator();
    }
    else if (status == 400)
    {
        HideNetworkActivityIndicator();
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];

    }
    
    else if (status == 500)
    {
        HideNetworkActivityIndicator();
    }
    
}

- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;
{
    
    NSLog(@"nstate %@",nState);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];

    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [self.view makeToast:@"Internal Server Error"];

    
}

#pragma mark - btn clicked method
-(void)btnFavClicked:(UIButton *)btn
{
//     NSArray *array = [_dictDetail valueForKey:@"ResponseAllDetail"];
    NSLog(@"user id %d",_userID);
    NSLog(@"btn fav clicked %@",btn);
    
//     if ([[array valueForKey:@"favorite"] isEqual:@"1"])
    if (btn.selected == true)
    {
        btn.selected = false;
        [btn setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
        [self postData:(int)btn.tag status:0];
        favBtnStatus = 0;
    }
    else
    {
        btn.selected = true;
        [btn setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
        [self postData:(int)btn.tag status:1];
        favBtnStatus = 1;

    }
}


-(void)btnBellClicked:(id)sender
{
    NSLog(@"bell clicked");
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];

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

-(void)ImageDisplayInscrollView:(NSMutableArray*)ImageArray
{
    NSLog(@"ImageArray %@",ImageArray);
    
//    viewscroll = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight/2-80)];
//    scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/2-20)];

    scrollviewimage.showsHorizontalScrollIndicator = false;
    int x = 0 ;
    scrollviewimage.pagingEnabled = YES;
    for (int i = 0; i < ImageArray.count; i++) {
        
        CGFloat pageWidth = scrollviewimage.frame.size.width;
        int page = floor((scrollviewimage.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        NSLog(@"page %d",page);

        
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(x, 0,screenWidth,scrollviewimage.frame.size.height)];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.tag = i;
        imgview.image =  [UIImage imageNamed:@"lodingicon.png"];
//        imgview.contentMode = UIViewContentModeScaleAspectFill;

        MBProgressHUD *mbHud;
        if (mbHud.alpha == 0) {
            //perform hide
            
        }
        else
        {
            //perfrom show
            [MBProgressHUD showHUDAddedTo:imgview animated:YES];

            
        }
//        [MBProgressHUD showHUDAddedTo:imgview animated:YES];
//      imgview.image =[UIImage imageWithData:[ImageArray objectAtIndex:i]];
        NSURL *url = [NSURL URLWithString:[ImageArray objectAtIndex:i]];
        NSString *cacheFilename = [url lastPathComponent];
//        NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
        int index = (int)[url pathComponents].count-3;
        NSString *folderName =[[url pathComponents] objectAtIndex:index];
        
        NSLog(@"folderName %@",folderName);
        NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];

        id image = [LazyLoadingImage imageDataFromPath:cachePath];

        if(image)
        {
            imgview.image = (UIImage*)image;
//            imgview.contentMode = UIViewContentModeScaleAspectFill;

            
            UIImageView *imgviewNew = imgview;
            [MBProgressHUD hideAllHUDsForView:imgviewNew animated:YES];
            
            [scrollviewimage setNeedsDisplay];
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     imgview.image = [UIImage imageWithData:data];
//                     imgview.contentMode = UIViewContentModeScaleAspectFill;

                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     
                     UIImageView *imgviewNew = imgview;
                     [MBProgressHUD hideAllHUDsForView:imgviewNew animated:YES];

                     [scrollviewimage setNeedsDisplay];
                 }
             }];
        }

//        imgview.contentScaleFactor = [imgview.superview contentScaleFactor];
//        imgview.tag = i;
        imgview.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapOnImage:)];
//        [imgview addGestureRecognizer:tap];
        
        [View addSubview:imgview];
        scrollviewimage.delegate = self;
        [scrollviewimage addSubview:View];
        x = View.frame.origin.x+View.frame.size.width;
        scrollviewimage.contentSize = CGSizeMake(x,200);
        [viewscroll addSubview:scrollviewimage];
        
    }
    
    if (ImageArray.count< 1) {
        [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];
        
    }

    
     NSArray *array = [_dictDetail valueForKey:@"ResponseAllDetail"];
    
    if (![[array valueForKey:@"user_id"] isEqualToString:@"0"])
    {
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:18.0];
    btn.frame = CGRectMake(screenWidth-50,20, 40.0, 25.0);
    btn.backgroundColor = userNameInProfile;
    
    NSString *str = [array valueForKey:@"favorite"];
    if ([str isKindOfClass:[NSNull class]])
    {
        str = @"0";
    }
    
    if ([str isEqualToString:@"1"]) {

        btn.selected = true;
        [btn setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
        
    }
    else
    {
        btn.selected = false;
        [btn setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
        
    }
    btn.layer.cornerRadius = 4.0;
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(btnFavClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewscroll addSubview:btn];
    }
    

}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollviewimage.frame.size.width;
    int page = floor((scrollviewimage.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"page %d",page);
}


-(void)TapOnImage:(UITapGestureRecognizer*)tap
{
    UIImageView *img = (UIImageView*)tap.view;
    NSLog(@"img %@",img);
    IsNextPageOpen = true;
    OpenImageViewController *imgviewOpenObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenImageViewController"];
    
//    imgviewOpenObj.image = [self imageResize:img.image andResizeTo:CGSizeMake(img.image.size.width/2, img.image.size.height/2)];
//    imgviewOpenObj.strUrlImage = [arrayImageList objectAtIndex:img.tag];
//    
//    if (imgviewOpenObj.image.size.width>screenWidth && imgviewOpenObj.image.size.height > screenHeight) {
//         imgviewOpenObj.image = [self imageResize:img.image andResizeTo:CGSizeMake(screenWidth, screenHeight)];
//    }

    imgviewOpenObj.indexpage = (int)img.tag;
    imgviewOpenObj.arrayImage = arrayImageList;
    //    [self.navigationController pushViewController:imgviewOpenObj animated:YES];
    [self presentViewController:imgviewOpenObj animated:YES completion:nil];
    
}
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)btnEditprofileClicked:(id)sender
{
    if (![GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    PostOwnerDetailViewController *objPostDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"PostOwnerDetailViewController"];
    if(_arrayPostDetail)
    {
    objPostDetail.owner_id=[[_arrayPostDetail valueForKey:@"user_id"] intValue];
    }
    else{
        NSArray *arrayAllDetailFromList = [_dictDetail valueForKey:@"ResponseAllDetail"];

        objPostDetail.owner_id=[[arrayAllDetailFromList valueForKey:@"user_id"] intValue];
    }
    objPostDetail.universityID=universityID;
    objPostDetail.postCatID=postCatID;
    objPostDetail.strUserName=_strUserName;
    objPostDetail.strPostimagePath = strPost;
    [self.navigationController pushViewController:objPostDetail animated:YES];
    
}
-(void)btnReplyClicked:(id)sender
{
    IsNextPageOpen = true;
    NSLog(@"Reply btn clicked");
    NSArray *array = [_dictDetail valueForKey:@"ResponseAllDetail"];
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        if (_threadCount == 1)
        {
            MessageDetailViewController *msgDetailViewObj =[self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
            
            if ([[array valueForKey:@"post_id"] intValue]) {
                msgDetailViewObj.postID = [[array valueForKey:@"post_id"] intValue];
            }
            else
            {
                msgDetailViewObj.postID = [[array valueForKey:@"id"] intValue];
            }
            msgDetailViewObj.FromReplyBtn = true;
            
            if ([array valueForKey:@"post_name"]) {

            msgDetailViewObj.strPostName = [array valueForKey:@"post_name"];
            }
            else
            {
                msgDetailViewObj.strPostName = [array valueForKey:@"title"];

            }
            msgDetailViewObj.readID = [[array valueForKey:@"user_id"] intValue];
            [self.navigationController pushViewController:msgDetailViewObj animated:YES];
            
        }
        else
        {
            SendMessageViewController *sendMsgObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SendMessageViewController"];
            sendMsgObj.IsContactBtnClicked = false;
            
            if ([[array valueForKey:@"post_id"] intValue]) {
                sendMsgObj.postID = [[array valueForKey:@"post_id"] intValue];

            }
            else
            {
                sendMsgObj.postID = [[array valueForKey:@"id"] intValue];

            }
            
            sendMsgObj.userId = _userID;
            sendMsgObj.strUserName = [GlobalMethod shareGlobalMethod].strUserName;
            
            if ([array valueForKey:@"post_name"]) {
                sendMsgObj.strPostName = [array valueForKey:@"post_name"];
            }
            else
            {
                sendMsgObj.strPostName = [array valueForKey:@"title"];

            }
            [self.navigationController pushViewController:sendMsgObj animated:YES];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
}

-(void)btnContactClicked:(id)sender
{
    NSLog(@"Contact clicked");
    IsNextPageOpen = true;
    SendMessageViewController *sendMsgObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SendMessageViewController"];
    sendMsgObj.IsContactBtnClicked = true;
    [self.navigationController pushViewController:sendMsgObj animated:YES];
    
}

-(void)btnReportClicked:(id)sender
{
    NSLog(@"Report clicked");
    IsNextPageOpen = true;
    
    UIAlertView *watchReportAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"Dou you want to report this post." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [watchReportAlert show];
    
}
#pragma mark - AlertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"Yes");
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
            
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;

            NSArray *array = [_dictDetail valueForKey:@"ResponseAllDetail"];

            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            if (array ==nil) {
                [dict setValue:[_dictDetail valueForKey:@"post_id"] forKey:@"post_id"];
                [dict setValue: [_dictDetail valueForKey:@"user_id"] forKey:@"user_id"];

            }
            else
            {
            [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
            [dict setValue: [array valueForKey:@"user_id"] forKey:@"user_id"];
            }
            
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_count";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_count" withToken:NO];
        }
    }
}


#pragma mark - PostDataTo server
-(void)postData:(int)tag status:(int)status
{
    NSLog(@"user id %d",_userID);
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;

        
        NSArray *array = [_dictDetail valueForKey:@"ResponseAllDetail"];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//        [dict setValue:[array valueForKey:@"user_id"] forKey:@"user_id"];
        
        if(array != nil)
        {
            [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
            
            if ([array valueForKey:@"post_id"] == nil) {
                if ([_dictDetail valueForKey:@"id"] != nil)
                {
                    [dict setValue:[_dictDetail valueForKey:@"id"] forKey:@"post_id"];
                }
                else{
                [dict setValue:[array valueForKey:@"id"] forKey:@"post_id"];
                }
                
            }
            else{
                [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
            }
        }
        else
        {
            [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
            [dict setValue:[_dictDetail valueForKey:@"post_id"] forKey:@"post_id"];
        }
        [dict setValue:[NSString stringWithFormat:@"%d",status] forKey:@"status"];
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"make_favorite";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"make_favorite" withToken:NO];
        
        
    }
    else
    {
        [appDelegate.window makeToast:NSLocalizedString(@"InternetAvailable", nil)];
        
    }
    
}

#pragma mark-change Frame
-(void)changeAllViewFrame
{
    if(viewButton.hidden)
    {
        CGRect rectScrollViewImg = scrollviewimage.frame;
        rectScrollViewImg.size.height=rectScrollViewImg.size.height+viewButton.frame.size.height+20;
        scrollviewimage.frame = rectScrollViewImg;
        
        CGRect rectScrll = viewscroll.frame;
        rectScrll.size.height=rectScrll.size.height+viewButton.frame.size.height+20;
        viewscroll.frame = rectScrll;
        
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
