      //
//  BuzzDetailViewController.m
//  Thriftskool
//
//  Created by Asha on 11/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "BuzzDetailViewController.h"
#import "OpenImageViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"


@interface BuzzDetailViewController ()

@end

@implementation BuzzDetailViewController
@synthesize dicBuzzDetail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = _strTitleName;
    self.navigationItem.hidesBackButton = YES;
    
    //LeftSide Button
    UIButton *btnleftside = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleftside.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btnleftside.frame = CGRectMake(0, 0, 20.0, 30.0);
    [btnleftside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleftside setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [btnleftside addTarget:self action:@selector(btnBackBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewleftside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20.0, 30.0)];
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
    [btnBell addTarget:self action:@selector(btnBellClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewBellside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    viewBellside.bounds = CGRectOffset(viewBellside.bounds, 0, 0);
    [viewBellside addSubview:btnBell];
    UIBarButtonItem *barBell = [[UIBarButtonItem alloc]initWithCustomView:viewBellside];
    self.navigationItem.rightBarButtonItem = barBell;

    
    ///UI ============

    viewscroll = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight/2-80)];
    [self.view addSubview:viewscroll];
    
    scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/2-20)];

    UIView *viewName = [[UIView alloc]initWithFrame:CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 35)];
    viewName.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblName = [[UILabel alloc]init];//WithFrame:CGRectMake(0, lblPrice.frame.origin.y+lblPrice.frame.size.height, 320, 35)];
    lblName.frame = CGRectMake(10,0, screenWidth-20, 35);
    lblName.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblName.textColor = [UIColor whiteColor];
    [viewName addSubview:lblName];
    [self.view addSubview:viewName];
    
    
    UIView *dateview = [[UIView alloc]initWithFrame:CGRectMake(0, viewName.frame.origin.y+viewName.frame.size.height, screenWidth, 35)];
    dateview.backgroundColor = tableBackgroundColor;
    lblDate = [[UILabel alloc]init];
    lblDate.frame = CGRectMake(10,0, screenWidth/2, 35);
    lblDate.backgroundColor = tableBackgroundColor;
    lblDate.font = FontRegular16;
    lblDate.textColor = [UIColor grayColor];
    [dateview addSubview:lblDate];

    lblExpired = [[UILabel alloc]init];
    lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 35);
//    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayWithMonthName:[_arrayBuzzDetail valueForKey:@"expirydate"] firstMonth:YES];
    lblExpired.backgroundColor = tableBackgroundColor;
    lblExpired.textAlignment = NSTextAlignmentRight;
    lblExpired.font = FontRegular16;
    lblExpired.textColor = [UIColor grayColor];
   // [dateview addSubview:lblExpired];
    [self.view addSubview:dateview];

    viewReport = [[UIView alloc]init];
    viewReport.frame = CGRectMake(0,screenHeight-navBarHeight-tabBarHeight+7, screenWidth, 30);
    viewReport.backgroundColor = tableBackgroundColor;
    
    
    UIButton *btnReport = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReport.frame = CGRectMake(screenWidth-100, 5, 50, 20);
    btnReport.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    [btnReport setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnReport setTitle:@"Report" forState:UIControlStateNormal];
    [btnReport addTarget:self action:@selector(btnReportClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewReport addSubview:btnReport];
    
    UIButton *btnReportImg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReportImg.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    btnReportImg.frame = CGRectMake(screenWidth-50, 5, 15, 20);
    [btnReportImg setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnReportImg setTitle:[NSString fontAwesomeIconStringForEnum:FAExclamationCircle] forState:UIControlStateNormal];
    [btnReportImg addTarget:self action:@selector(btnReportClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewReport addSubview:btnReportImg];
    [self.view addSubview:viewReport];
    
    
    
    txtviewDecscription = [[UITextView alloc]initWithFrame:CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-20, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+viewReport.frame.size.height+tabBarHeight+20))];
    txtviewDecscription.editable = false;
    txtviewDecscription.backgroundColor = [UIColor whiteColor];
    txtviewDecscription.font = FontRegular16;
    txtviewDecscription.editable = false;
    txtviewDecscription.textColor = [UIColor grayColor];
    [self.view addSubview:txtviewDecscription];
    
    IsFromOpenImageView = false;
    
  [self setBuzzDetail];
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
    self.tabBarController.tabBar.hidden = NO;
    
    if (IsFromOpenImageView == false)
    {
        
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            

            [MBProgressHUD showHUDAddedTo:viewscroll animated:YES];
            
            NSDictionary *dict = [[NSMutableDictionary alloc]init];
            //    [dict setValue:[NSString stringWithFormat:@"%d",_buzzId] forKey:@"buzz_id"];
            if([dicBuzzDetail valueForKey:@"id"])
            {
                [dict setValue:[NSString stringWithFormat:@"%d",[[dicBuzzDetail valueForKey:@"id"] intValue]] forKey:@"buzz_id"];
            }
            else
            {
                [dict setValue:[NSString stringWithFormat:@"%d",[[dicBuzzDetail valueForKey:@"buzz_id"] intValue]] forKey:@"buzz_id"];
            }
            
            [dict setValue:[dicBuzzDetail valueForKey:@"user_id"]  forKey:@"user_id"];
            
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"buzz_detail";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"buzz_detail" withToken:NO];
            
        }
        else
        {
            [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
            
        }
    }
    else
    {
        
        
        NSUserDefaults *def =[NSUserDefaults standardUserDefaults];
        arrayBuzzImageList = [def valueForKey:@"BuzzImageInDetail"];
//        viewscroll.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-80);
       
        if (!ipadDevice) {
            viewscroll.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-80);
            scrollviewimage.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-20);
        }
        if (ipadDevice)
        {
            viewscroll.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-80);
            scrollviewimage.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-20);
            
        }

        [self ImageDisplayInscrollView:arrayBuzzImageList];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (self.tabBarController.selectedIndex != 4)
    {
        IsFromOpenImageView = true;
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

#pragma mark - Connect Delegate
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    id arrData = [nData JSONValue];
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    int statuscode = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (statuscode == 200) {
        
        if ([nState isEqualToString:@"buzz_detail"]) {
            
            self.navigationController.view.userInteractionEnabled = true;
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                NSDictionary *dict = (NSDictionary*)arrData;
                if([dict valueForKey:@"Response"])
                {
                    
                    if([[dict valueForKey:@"Response"] valueForKey:@"Details"])
                    {
                        NSArray *array = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
                        if (array.count>0)
                        {
                            dicBuzzDetail = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
                            [self setBuzzDetail];
                        }
                    }
                    if([[dict valueForKey:@"Response"] valueForKey:@"images"])
                    {
                        NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
                        NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
                        
                        for (int i = 0; i < arrayImage.count; i++) {
                            
                            NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
                            
                            if (!arrayBuzzImageList) {
                                arrayBuzzImageList = [[NSMutableArray alloc]init];
                            }
                            [arrayBuzzImageList addObject:str];
                            
                        }
                        
                        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                        [defaults setValue:arrayBuzzImageList forKey:@"BuzzImageInDetail"];
                        [defaults synchronize];
                        
                        [self ImageDisplayInscrollView:arrayBuzzImageList];
                    }
                }
            }
        }
        if ([nState isEqualToString:@"buzz_count"]) {
            self.navigationController.view.userInteractionEnabled = true;
            [self.view makeToast:@"Thank you for your help, we will work to resolve this issue immediately."];
        }
        
    }
    if (statuscode == 404) {
        
    }
    if(statuscode ==400)
    {
        HideNetworkActivityIndicator();
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];

        
    }
}
-(void)ConnectionDidFail:(NSString *)nState Data:(NSString *)nData
{
    NSLog(@"nstate %@",nState);
    NSLog(@"ndata %@", nData);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [self.view makeToast:@"Internal Server Error"];


}

#pragma mark - AlertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"Yes");
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            if([dicBuzzDetail valueForKey:@"id"])
            {
                [dict setValue:[NSString stringWithFormat:@"%d",[[dicBuzzDetail valueForKey:@"id"] intValue]] forKey:@"buzz_id"];
            }
            else
            {
                [dict setValue:[NSString stringWithFormat:@"%d",[[dicBuzzDetail valueForKey:@"buzz_id"] intValue]] forKey:@"buzz_id"];
            }
            [dict setValue:[dicBuzzDetail valueForKey:@"user_id"]  forKey:@"user_id"];
        
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"buzz_count";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"buzz_count" withToken:NO];
        }
    }
}
-(void)setBuzzDetail {
    if ([[dicBuzzDetail valueForKey:@"user_id"] intValue] == [GlobalMethod shareGlobalMethod].userID) {
        viewReport.hidden = true;
    }
    else
    {
        viewReport.hidden = false;
    }
    if([dicBuzzDetail valueForKey:@"buzz_name"])
    {
        lblName.text = [NSString stringWithFormat:@"%@",[dicBuzzDetail valueForKey:@"buzz_name"]];
    }
    else
    {
        lblName.text = [NSString stringWithFormat:@"%@",[dicBuzzDetail valueForKey:@"title"]];
    }
    
    if ([lblName.text isEqual:NULL] || [lblName.text isEqualToString:@"(null)"]) {
        lblName.text = [NSString stringWithFormat:@"%@",[dicBuzzDetail valueForKey:@"name"]];
    }
    if([dicBuzzDetail valueForKey:@"expirydate"])
    {
        lblDate.text = [NSString stringWithFormat:@"%@",[[GlobalMethod shareGlobalMethod] DateDisplayWithMonthName:[dicBuzzDetail valueForKey:@"expirydate"] firstMonth:NO]];
    }
    else if ([dicBuzzDetail valueForKey:@"notification_id"]  &&  [dicBuzzDetail valueForKey:@"create_date"])
    {
        lblDate.text = [NSString stringWithFormat:@"%@",[[GlobalMethod shareGlobalMethod] DateDisplayWithMonthName:[dicBuzzDetail valueForKey:@"create_date"] firstMonth:NO]];
   
    }
//    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[dicBuzzDetail valueForKey:@"expirydate"]];
    
//    lblExpired.text = [NSString stringWithFormat:@"%@",str];
    lblExpired.text = [self DateDisplayInCell:[dicBuzzDetail valueForKey:@"expirydate"]];

    
    if([dicBuzzDetail valueForKey:@"description"])
    {
        txtviewDecscription.text = [dicBuzzDetail valueForKey:@"description"];
    }
}

-(NSString*)DateDisplayInCell:(NSString*)strDate
{
    //current Date -------------
    NSDate *startDate = [NSDate date];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSCalendar *calendar123 = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalendar.calendarIdentifier];
    //    calendar123.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* components123 = [calendar123 components:flags fromDate:startDate];
    startDate = [calendar123 dateFromComponents:components123];
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-LLL-yy";
    
    
    //End Date -------------
    
    
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
    //    [dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *endDate =  [dateformate dateFromString:strDate];
    
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd"];
        endDate =  [dateformate dateFromString:strDate];
    }
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        endDate =  [dateformate dateFromString:strDate];
    }
    
    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    format1.dateFormat = @"EE, LLL dd";
    NSLog(@"%@", [format1 stringFromDate:endDate]);
    NSString* dateStr = [format1 stringFromDate:endDate];
    
    
    NSDateComponents *components;
    NSInteger days;
    
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: startDate toDate: endDate options: 0];
    days = [components day];
    
    
    NSString *str;
    if (days < 0) {
        str = @"Expired";
    }
    else if (days == 0)
    {
        str = @"Today";
    }
    //    else if (days == 1)
    //    {
    //        str = [NSString stringWithFormat:@"Expires in %ld Day",(long)days];
    //    }
    else
    {
        str = [NSString stringWithFormat:@"Expires on %@",dateStr];
    }
    return str;
    
    
}

#pragma mark - Button Click event
-(void)btnBellClicked
{
    IsFromOpenImageView = true;
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];
    
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

-(void)ImageDisplayInscrollView:(NSMutableArray*)ImageArray
{
    scrollviewimage.showsHorizontalScrollIndicator = false;
    int x = 0 ;
    
    for (int i = 0; i < ImageArray.count; i++) {
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(x, 0,screenWidth,scrollviewimage.frame.size.height)];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,ipadDevice?0:0, screenWidth,scrollviewimage.frame.size.height-60)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        imgview.contentMode = UIViewContentModeScaleAspectFill;
        
        MBProgressHUD *mbHud;
        if (mbHud.alpha == 0) {
            //perform hide
        }
        else
        {
            //perfrom show
            [MBProgressHUD showHUDAddedTo:imgview animated:YES];
        }
        
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
            imgview.contentMode = UIViewContentModeScaleAspectFill;

            
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
                     imgview.contentMode = UIViewContentModeScaleAspectFill;

                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     
                     UIImageView *imgviewNew = imgview;
                     [MBProgressHUD hideAllHUDsForView:imgviewNew animated:YES];
                     [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];

                     
                     [scrollviewimage setNeedsDisplay];
                 }
             }];
        }
        

        
        imgview.tag = i;
        imgview.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapOnImage:)];
        [imgview addGestureRecognizer:tap];
        [View addSubview:imgview];
        [scrollviewimage addSubview:View];
        x = View.frame.origin.x+View.frame.size.width;
        scrollviewimage.contentSize = CGSizeMake(x,50);
        [viewscroll addSubview:scrollviewimage];

    }
    
    if (ImageArray.count< 1) {
        [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height-60)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];
        
    }

    
}

-(void)TapOnImage:(UITapGestureRecognizer*)tap
{
    UIImageView *img = (UIImageView*)tap.view;
    
    OpenImageViewController *imgviewOpenObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenImageViewController"];
//    imgviewOpenObj.image = img.image;
    IsFromOpenImageView = true;
//    imgviewOpenObj.strUrlImage = [arrayBuzzImageList objectAtIndex:img.tag];
//    
//    if (imgviewOpenObj.image.size.width>screenWidth && imgviewOpenObj.image.size.height > screenHeight) {
//        imgviewOpenObj.image = [self imageResize:img.image andResizeTo:CGSizeMake(screenWidth, screenHeight)];
//    }
    imgviewOpenObj.indexpage = (int)img.tag;
    imgviewOpenObj.arrayImage = arrayBuzzImageList;
    //    [self.navigationController pushViewController:imgviewOpenObj animated:YES];
    [self presentViewController:imgviewOpenObj animated:YES completion:nil];//    [self.navigationController pushViewController:imgviewOpenObj animated:YES];
    
}
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)btnReportClicked:(id)sender
{
    
    UIAlertView *buzzReportAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"Dou you want to report this post." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [buzzReportAlert show];
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
