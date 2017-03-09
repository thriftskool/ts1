//
//  WatchListDetailViewController.m
//  Thriftskool
//
//  Created by Asha on 09/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "WatchListDetailViewController.h"
#import "OpenImageViewController.h"
#import "SendMessageViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"


@interface WatchListDetailViewController ()

@end

@implementation WatchListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate.tabviewControllerObj.profileObj.watchlistobj.watchdetailObj = self;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"WATCH DETAIL";
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
    
//    scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/2-20)];
//    [self.view addSubview:scrollviewimage];
    
    if ([lblExpired.text isEqualToString:@"Expired"])
    {
        viewButton.hidden = YES;
    }
    else{
        viewButton.hidden = NO;
    }
    
    if ([[_dictSelectedWatchListDetail valueForKey:@"user_id"]intValue] == [GlobalMethod shareGlobalMethod].userID) {
        viewButton.hidden = YES;
    }
    else
    {
        viewButton.hidden = NO;
    }


    viewscroll = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screenWidth, screenHeight-330)];
    //    viewscroll.backgroundColor = [UIColor blueColor];
    [self.view addSubview:viewscroll];
    
    scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-270)];
    [self changeAllViewFrame];
    
    UIView *viewNameAndPrice = [[UIView alloc]initWithFrame:CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 35)];
    viewNameAndPrice.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    /*lblPrice = [[UILabel alloc]init];
    lblPrice.frame = CGRectMake(10, 0, screenWidth, 35);
    lblPrice.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblPrice.textColor = [UIColor whiteColor];
    [viewNameAndPrice addSubview:lblPrice];*/
    
    lblName = [[UILabel alloc]init];
    lblName.frame = CGRectMake(10, 0, screenWidth, 35);
    lblName.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblName.textColor = [UIColor whiteColor];
    [viewNameAndPrice addSubview:lblName];
    [self.view addSubview:viewNameAndPrice];
    
    UIView *dateview = [[UIView alloc]initWithFrame:CGRectMake(0, viewNameAndPrice.frame.origin.y+viewNameAndPrice.frame.size.height, screenWidth, 30)];
    dateview.backgroundColor = tableBackgroundColor;
    
    lblPrice = [[UILabel alloc]init];
    lblPrice.frame = CGRectMake(10, 0, screenWidth, 35);
    lblPrice.backgroundColor = tableBackgroundColor;
    [dateview addSubview:lblPrice];
    /*lblDate = [[UILabel alloc]init];
    lblDate.frame = CGRectMake(10,0, screenWidth/2, 30);
    lblDate.backgroundColor = tableBackgroundColor;
    lblDate.font = FontRegular16;
    [dateview addSubview:lblDate];*/
    
    
    lblExpired = [[UILabel alloc]init];
    lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 30);
    lblExpired.backgroundColor = tableBackgroundColor;
    lblExpired.font = FontRegular16;
    
    lblExpired.textAlignment = NSTextAlignmentRight;
    
    [dateview addSubview:lblExpired];
    [self.view addSubview:dateview];
    
    
    viewButton = [[UIView alloc]init];
    viewButton.backgroundColor = tableBackgroundColor;
    viewButton.frame = CGRectMake(0,screenHeight-navBarHeight-tabBarHeight+7, screenWidth, 30);

    
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
    btnReportImg.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    btnReportImg.frame = CGRectMake(btnReport.frame.origin.x+btnReport.frame.size.width, 5, 15, 20);
    [btnReportImg setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnReportImg setTitle:[NSString fontAwesomeIconStringForEnum:FAExclamationCircle] forState:UIControlStateNormal];
    [btnReportImg addTarget:self action:@selector(btnReportClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnReportImg];

    
    [self.view addSubview:viewButton];
    
    txtviewDecscription = [[UITextView alloc]init];
    if(viewButton.isHidden)
    {
        txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-2, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+tabBarHeight));
    }
    else{
        txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-20, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+viewButton.frame.size.height+tabBarHeight+20));
        
    }
   
    txtviewDecscription.text = @"Expire in 16 days";
    txtviewDecscription.backgroundColor = [UIColor whiteColor];
    txtviewDecscription.font = FontRegular16;
    txtviewDecscription.editable = false;
    [self.view addSubview:txtviewDecscription];
    
    

    
    //Dict Detail
    NSLog(@"dictSelectedWatchListDetail %@",_dictSelectedWatchListDetail);
    lblName.text = [_dictSelectedWatchListDetail valueForKey:@"post_name"];
    
    NSString *strPrice = [_dictSelectedWatchListDetail valueForKey:@"price"];
    NSRange range = [strPrice rangeOfString:@"$"];
    if (range.location == NSNotFound) {
        lblPrice.text = [NSString stringWithFormat:@"$%@",[_dictSelectedWatchListDetail valueForKey:@"price"]];
    }
    else
    {
        lblPrice.text = [NSString stringWithFormat:@"%@",[_dictSelectedWatchListDetail valueForKey:@"price"]];
        
    }
    
    lblDate.text = [[GlobalMethod shareGlobalMethod]DateDisplayWithMonthName:[_dictSelectedWatchListDetail valueForKey:@"expirydate"] firstMonth:NO];
    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[_dictSelectedWatchListDetail valueForKey:@"expirydate"]];
        lblExpired.text = str;
    
       txtviewDecscription.text = [_dictSelectedWatchListDetail valueForKey:@"description"];
    txtviewDecscription.font = FontRegular16;

    IsFromWatchDetailPage = false;
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
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
    if (IsFromWatchDetailPage ==false)
    {
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;

            
            [MBProgressHUD showHUDAddedTo:viewscroll animated:YES];
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            [dict setValue:[_dictSelectedWatchListDetail valueForKey:@"user_id"] forKey:@"user_id"];
            [dict setValue:[_dictSelectedWatchListDetail valueForKey:@"post_id"] forKey:@"post_id"];
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
        arrayImageId =  [defaults valueForKey:@"ImageIdArrayInDetail"];
        viewscroll.frame = CGRectMake(0, 64, screenWidth, screenHeight/2-80);
        [self ImageDisplayInscrollView:arrayImageList];
        
    }

}

-(void)viewDidDisappear:(BOOL)animated
{
//    IsFromWatchDetailPage = true;
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
#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    
    [MBProgressHUD hideAllHUDsForView:scrollviewimage animated:YES];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];

    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (strstatuscode == 200)
    {
        if ([nState isEqualToString:@"post_detail"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            
            NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
            NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
            
            for (int i = 0; i < arrayImage.count; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                if (!arrayImageList) {
                    arrayImageList = [[NSMutableArray alloc]init];
                }
                [arrayImageList addObject:str];
                
            }
            
            
            arrayImageId = [[[dict valueForKey:@"Response"] valueForKey:@"images"] valueForKey:@"image_id"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:arrayImageList forKey:@"ImageArrayInDetail"];
            [defaults setValue:arrayImageId forKey:@"ImageIdArrayInDetail"];
            [defaults synchronize];
            
            scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-270)];

            [self ImageDisplayInscrollView:arrayImageList];
            
        }
        if ([nState isEqualToString:@"make_favorite"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            NSLog(@"dict %@",dict);
//            arrayAllSelectFavBtnData = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
//            
//            NSUserDefaults *deafults = [NSUserDefaults standardUserDefaults];
//            [deafults setObject:arrayAllSelectFavBtnData forKey:@"arrayAllSelectFavBtnData"];
//            [deafults synchronize];
            
//            for(NSMutableDictionary *dict in arrayAllSelectFavBtnData)
//            {
//                int idUser = [[[arrayAllSelectFavBtnData objectAtIndex:indexPath.row] valueForKey:@"post_id"] intValue];
//                
//                if([[dict objectForKey:@"post_id"]integerValue]== idUser)
//                {
//                    //                    if ([[dict valueForKey:@"favorite"]isEqualToString:@"0"])
//                    
//                    NSString *str = [dict valueForKey:@"favorite"];
//                    
//                    if ([str isKindOfClass:[NSNull class]])
//                    {
//                        str = @"0";
//                    }
//                    
//                    if ([str isEqualToString:@"0"])
//                    {
//                        [dict setObject:@"1" forKey:@"favorite"];
//                    }
//                    else
//                    {
//                        [dict setObject:@"0" forKey:@"favorite"];
//                        
//                    }
//                }
//            }
//
//            [appDelegate.tabviewControllerObj.profileObj.watchlistobj.watchdetailObj.view makeToast:@"Updated."];
            
            if (favBtnStatus == 1)
                
            {
                _btnfavSelected = true;
                [appDelegate.tabviewControllerObj.profileObj.watchlistobj.watchdetailObj.view makeToast:NSLocalizedString(@"Favorite_button_click_add", nil)];
                
            }
            else
            {
                _btnfavSelected = false;
                [appDelegate.tabviewControllerObj.profileObj.watchlistobj.watchdetailObj.view makeToast:NSLocalizedString(@"Favorite_button_click_remove", nil)];
                
            }

            
        }
        if ([nState isEqualToString:@"post_count"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            NSLog(@"dict %@",dict);
            arrayAllSelectFavBtnData = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
            
            [self.view makeToast:@"Thank you for your help, we will work to resolve this issue immediately." ];
        }
    }
    else if (strstatuscode == 201)
    {
    }
    
    else if (strstatuscode == 404)
    {
        
    }
    else if (strstatuscode == 401)
    {
    }
    else if (strstatuscode == 400)
    {
    }
    
    else if (strstatuscode == 500)
    {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
-(void)ImageDisplayInscrollView:(NSMutableArray*)ImageArray
{
    NSLog(@"ImageArray %@",ImageArray);
    scrollviewimage.showsHorizontalScrollIndicator = false;
    int x = 0 ;
    
    
    for (int i = 0; i < ImageArray.count; i++) {
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(x, 0,screenWidth,scrollviewimage.frame.size.height)];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];

//        imgview.image =[UIImage imageWithData:[ImageArray objectAtIndex:i]];
//        imgview.contentScaleFactor = [imgview.superview contentScaleFactor];
       
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
            
            UIImageView *imgviewNew = imgview;
            [MBProgressHUD hideAllHUDsForView:imgviewNew animated:YES];
            [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
            
            
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
                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     
                     UIImageView *imgviewNew = imgview;
                     [MBProgressHUD hideAllHUDsForView:imgviewNew animated:YES];
                     [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
                     
                     
                     [scrollviewimage setNeedsDisplay];
                 }
             }];
        }

        imgview.tag = i;
        imgview.userInteractionEnabled = NO;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapOnImage:)];
//        [imgview addGestureRecognizer:tap];

        
        [View addSubview:imgview];
        [scrollviewimage addSubview:View];
        x = View.frame.origin.x+View.frame.size.width;//remove +10
        scrollviewimage.contentSize = CGSizeMake(x,215);
        [viewscroll addSubview:scrollviewimage];
        
        
    }
    if (ImageArray.count< 1) {
        [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];
  }

    
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:18.0];
    btn.frame = CGRectMake(screenWidth-50,20, 40.0, 25.0);
    btn.backgroundColor = userNameInProfile;
    
//    NSString *str = [_dictSelectedWatchListDetail valueForKey:@"favorite"];
    
    
//    if ([str isEqualToString:@"1"])
    if(_btnfavSelected==true)
    {
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
//    btn.selected = false;
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(btnFavClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewscroll addSubview:btn];
    
}

-(void)TapOnImage:(UITapGestureRecognizer*)tap
{
    IsFromWatchDetailPage = true;
    UIImageView *img = (UIImageView*)tap.view;
    NSLog(@"img %@",img);
    
    OpenImageViewController *imgviewOpenObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenImageViewController"];
//    imgviewOpenObj.image = img.image;
//    imgviewOpenObj.strUrlImage = [arrayImageList objectAtIndex:img.tag];
//    
//    if (imgviewOpenObj.image.size.width>screenWidth && imgviewOpenObj.image.size.height > screenHeight) {
//        imgviewOpenObj.image = [self imageResize:img.image andResizeTo:CGSizeMake(screenWidth, screenHeight)];
//    }
    imgviewOpenObj.indexpage = (int)img.tag;
    imgviewOpenObj.arrayImage = arrayImageList;
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



#pragma mark - btn clicked method
-(void)btnFavClicked:(UIButton *)btn
{
    NSLog(@"btn fav clicked %@",btn);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    if ([[_dictSelectedWatchListDetail valueForKey:@"favorite"] isEqual:@"1"])
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

-(void)btnReplyClicked:(id)sender
{
    NSLog(@"Reply btn clicked");
    IsContactBtnClicked = false;
    IsReplyBtnClicked = true;
    SendMessageViewController *sendMsgObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SendMessageViewController"];
    sendMsgObj.IsContactBtnClicked = false;
    sendMsgObj.postID = [[_dictSelectedWatchListDetail valueForKey:@"post_id"] intValue];
    sendMsgObj.userId = _userID;
    sendMsgObj.strPostName = [_dictSelectedWatchListDetail valueForKey:@"post_name"];
    sendMsgObj.strUserName = _strUserName;
    
    [self.navigationController pushViewController:sendMsgObj animated:YES];
}

-(void)btnContactClicked:(id)sender
{
    NSLog(@"Contact clicked");
    IsContactBtnClicked = true;
    IsReplyBtnClicked = false;
    SendMessageViewController *sendMsgObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SendMessageViewController"];
    sendMsgObj.IsContactBtnClicked = true;
    [self.navigationController pushViewController:sendMsgObj animated:YES];

}

-(void)btnReportClicked:(id)sender
{
    NSLog(@"Report clicked");
    
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

            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            [dict setValue:[_dictSelectedWatchListDetail valueForKey:@"post_id"] forKey:@"post_id"];
            [dict setValue: [_dictSelectedWatchListDetail valueForKey:@"user_id"] forKey:@"user_id"];
            
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_count";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_count" withToken:NO];
        }
    }
}


#pragma mark - PostDataTo server
-(void)postData:(int)tag status:(int)status
{
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        self.tabBarController.view.userInteractionEnabled = false;

        self.navigationController.view.userInteractionEnabled = false;
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
        [dict setValue:[_dictSelectedWatchListDetail valueForKey:@"post_id"] forKey:@"post_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",status] forKey:@"status"];
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"make_favorite";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"make_favorite" withToken:NO];
        
        
    }
    else
    {
        [appDelegate.window makeToast:NSLocalizedString(@"InternetAvailable", nil)];
        
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
