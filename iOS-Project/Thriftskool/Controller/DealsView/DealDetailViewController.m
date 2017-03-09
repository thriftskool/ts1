//
//  DealDetailViewController.m
//  Thriftskool
//
//  Created by Asha on 11/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "DealDetailViewController.h"
#import "OpenImageViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"


@interface DealDetailViewController ()

@end

@implementation DealDetailViewController
@synthesize dicDealDetail;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _strTitleName;
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
    
    
    ///UI ============

    viewscroll = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screenWidth, screenHeight/2-80)];
    //    viewscroll.backgroundColor = [UIColor blueColor];
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
    
    
    UIView *dateview = [[UIView alloc]initWithFrame:CGRectMake(0, viewName.frame.origin.y+viewName.frame.size.height, screenWidth, 30)];
    dateview.backgroundColor = tableBackgroundColor;
    lblDate = [[UILabel alloc]init];//WithFrame:CGRectMake(0, lblName.frame.origin.y+lblName.frame.size.height, navWidth/2, 35)];
    lblDate.frame = CGRectMake(10,0, screenWidth/2, 30);
   
    lblDate.font = FontRegular16;
    lblDate.textColor = [UIColor grayColor];
    lblDate.backgroundColor = tableBackgroundColor;
    
    [dateview addSubview:lblDate];
    
    lblExpired = [[UILabel alloc]init];//WithFrame:CGRectMake(navWidth/2, lblName.frame.origin.y+lblName.frame.size.height, navWidth/2, 35)];
    lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 30);
    lblExpired.backgroundColor = tableBackgroundColor;
    lblExpired.textAlignment = NSTextAlignmentRight;
    lblExpired.font = FontRegular16;
    lblExpired.textColor = [UIColor grayColor];
    [dateview addSubview:lblExpired];
    [self.view addSubview:dateview];
    
    
    

    
    txtviewDecscription = [[UITextView alloc]initWithFrame:CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5,screenWidth-20,ipadDevice?200:screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+btnViewCode.frame.size.height+tabBarHeight+20))];
    
    txtviewDecscription.textColor = [UIColor grayColor];
    txtviewDecscription.backgroundColor = [UIColor whiteColor];
    txtviewDecscription.font = FontRegular16;
    txtviewDecscription.editable = false;
    [self.view addSubview:txtviewDecscription];
    
    btnViewCode = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2-50,ipadDevice?txtviewDecscription.frame.origin.y+txtviewDecscription.frame.size.height+5:screenHeight-navBarHeight-tabBarHeight+7, 100, 28)];
    [btnViewCode setTitle:@"View Code" forState:UIControlStateNormal];
    btnViewCode.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnViewCode.titleLabel.font = FontRegular16;
    [btnViewCode setBackgroundColor:NavigationBarBgColor];
    btnViewCode.layer.cornerRadius = 6.0;
    [btnViewCode addTarget:self action:@selector(btnViewCodeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnViewCode];
    IsFromOpenImageView = false;
    [self setDealDetail];
    
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
    self.tabBarController.tabBar.hidden = false;

    viewscroll.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-80);
    scrollviewimage.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-20);
    
    if (IsFromOpenImageView == false)
    {
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
            
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            
            
            [MBProgressHUD showHUDAddedTo:scrollviewimage animated:YES];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            [dict setValue:[dicDealDetail valueForKey:@"user_id"] forKey:@"user_id"];
            if([dicDealDetail valueForKey:@"deal_id"])
            {
                [dict setValue:[dicDealDetail valueForKey:@"deal_id"] forKey:@"deal_id"];
            }
            else
            {
                [dict setValue:[dicDealDetail valueForKey:@"id"] forKey:@"deal_id"];
            }
            
            NSLog(@"dict %@",dict);
            
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"deal_detail";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"deal_detail" withToken:NO];
        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        }
    }
    else
    {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        arrayImageList = [defaults valueForKey:@"DealImages"];
        [self ImageDisplayInscrollView:arrayImageList];


    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    IsFromOpenImageView = true;
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
#pragma mark - Connection delegate
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    NSArray *arrData = [nData JSONValue];
    NSLog(@"array %@",arrData);
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (strstatuscode == 200) {
        
        if ([nState isEqualToString:@"deal_detail"]) {
            
            self.navigationController.view.userInteractionEnabled = true;
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                NSDictionary *dict = (NSDictionary*)arrData;
                if([[dict valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    dicDealDetail = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
                    [self setDealDetail];
                }
                if([[dict valueForKey:@"Response"] valueForKey:@"images"])
                {
                    
                    NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
                    NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
                    
                    for (int i = 0; i < arrayImage.count; i++) {
                        
                        NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
                        
                        if (!arrayImageList) {
                            arrayImageList = [[NSMutableArray alloc]init];
                        }
                        [arrayImageList addObject:str];
                    }
                    
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setValue:arrayImageList forKey:@"DealImages"];
                    [defaults synchronize];
                    
                    [self ImageDisplayInscrollView:arrayImageList];
                }
            }
        }
        
        if ([nState isEqualToString:@"dealcode_count"]) {
            self.navigationController.view.userInteractionEnabled = true;
            NSDictionary *dict = (NSDictionary*)arrData;
            NSLog(@"dict deal code %@",dict);
            
            
        }
    }
}

-(void)ConnectionDidFail:(NSString *)nState Data:(NSString *)nData
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [self.view makeToast:@"Internal Server Error"];


}
-(void)setDealDetail
{
    if([dicDealDetail valueForKey:@"deal_name"])
    {
        lblName.text = [NSString stringWithFormat:@"%@",[dicDealDetail valueForKey:@"deal_name"]];
    }
    else
    {
        lblName.text = [NSString stringWithFormat:@"%@",[dicDealDetail valueForKey:@"title"]];
    }
    if([dicDealDetail valueForKey:@"crate_date"])
    {
        lblDate.text = [NSString stringWithFormat:@"%@",[[GlobalMethod shareGlobalMethod] DateDisplayWithMonthName:[dicDealDetail valueForKey:@"expirydate"] firstMonth:NO]];
    }
    else if ([dicDealDetail valueForKey:@"create_date"])
    {
        lblDate.text = [NSString stringWithFormat:@"%@",[[GlobalMethod shareGlobalMethod] DateDisplayWithMonthName:[dicDealDetail valueForKey:@"expirydate"] firstMonth:NO]];

    }
    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[dicDealDetail valueForKey:@"expirydate"]];
    
    lblExpired.text = [NSString stringWithFormat:@"%@",str];
    if([dicDealDetail valueForKey:@"description"])
    {
        txtviewDecscription.text = [dicDealDetail valueForKey:@"description"];
    }
}

#pragma mark - CustomAlertview method

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 150)];
    
    UILabel *lbltitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 289,40)];
    lbltitle.layer.cornerRadius = 3.0;
    lbltitle.text = @"Deal Code";
    lbltitle.textAlignment = NSTextAlignmentCenter;
    lbltitle.backgroundColor = NavigationBarBgColor;
    lbltitle.textColor = [UIColor whiteColor];
    lbltitle.font = FontBold;
    [demoView addSubview:lbltitle];
    
    UILabel *lblCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 289,90)];
    lblCount.layer.cornerRadius = 3.0;
    lblCount.textAlignment = NSTextAlignmentCenter;
    if([dicDealDetail valueForKey:@"deal_code"])
    {
        lblCount.text = [dicDealDetail valueForKey:@"deal_code"];
    }

//    lblCount.backgroundColor = [UIColor yellowColor];
//    lblCount.textColor = [UIColor whiteColor];
    lblCount.font = FontRegular16;
    [demoView addSubview:lblCount];

    
    return demoView;
}

-(void)ImageDisplayInscrollView:(NSMutableArray*)ImageArray
{
    viewscroll.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-80);
    scrollviewimage.frame = CGRectMake(0, 0, screenWidth, screenHeight/2-20);

    NSLog(@"ImageArray %@",ImageArray);
    scrollviewimage.showsHorizontalScrollIndicator = false;
    int x = 0 ;
    for (int i = 0; i < ImageArray.count; i++) {
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(x, 0,screenWidth,scrollviewimage.frame.size.height)];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
//        imgview.image =[UIImage imageWithData:[ImageArray objectAtIndex:i]];
//        imgview.contentMode = UIViewContentModeScaleAspectFill;//UIViewContentModeCenter;
        
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
            
//            UIImageView *imgviewNew = imgview;
            [MBProgressHUD hideAllHUDsForView:imgview animated:YES];
            [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
            
            
//            [scrollviewimage setNeedsDisplay];
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
                     
//                     UIImageView *imgviewNew = imgview;
                     [MBProgressHUD hideAllHUDsForView:imgview animated:YES];
                     [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
                     
                     
//                     [scrollviewimage setNeedsDisplay];
                 }
             }];
        }

        
        imgview.tag = i+1;
        imgview.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapOnImage:)];
        [imgview addGestureRecognizer:tap];
        [View addSubview:imgview];
        [scrollviewimage addSubview:View];
        x = View.frame.origin.x+View.frame.size.width;
        scrollviewimage.contentSize = CGSizeMake(x,50);
        [viewscroll addSubview:scrollviewimage];

    }
    if (ImageArray.count< 1)
    {
        [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];
    }
}
-(void)TapOnImage:(UITapGestureRecognizer*)tap
{
    UIImageView *img = (UIImageView*)tap.view;
    NSLog(@"img %@",img);
    
    OpenImageViewController *imgviewOpenObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenImageViewController"];
//    imgviewOpenObj.image = img.image;
    imgviewOpenObj.indexpage = (int)img.tag;
    imgviewOpenObj.arrayImage = arrayImageList;
    [self.navigationController pushViewController:imgviewOpenObj animated:YES];
    
}

#pragma mark - UIALertView delegate



#pragma mark - navigation button method
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


#pragma mark -

-(void)btnViewCodeClicked:(id)sender
{
    NSLog(@"sender %@",sender);
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setValue:[dicDealDetail valueForKey:@"user_id"] forKey:@"user_id"];
        if([dicDealDetail valueForKey:@"deal_id"])
        {
            [dict setValue:[dicDealDetail valueForKey:@"deal_id"] forKey:@"deal_id"];
        }
        else
        {
            [dict setValue:[dicDealDetail valueForKey:@"id"] forKey:@"deal_id"];
        }
        
        NSLog(@"dict %@",dict);
        
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"dealcode_count";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"dealcode_count" withToken:NO];

        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        
        // Add some custom content to the alert view
        [alertView setContainerView:[self createDemoView]];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Cancel", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];

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
