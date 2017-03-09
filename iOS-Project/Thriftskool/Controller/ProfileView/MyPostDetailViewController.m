//
//  MyPostDetailViewController.m
//  Thriftskool
//
//  Created by Asha on 09/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "MyPostDetailViewController.h"
#import "OpenImageViewController.h"
#import "EditPostViewController.h"
#import "CreateCampusBuzzViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"



@interface MyPostDetailViewController ()

@end

@implementation MyPostDetailViewController
@synthesize SelectMsgType;

- (void)viewDidLoad {
//    appDelegate.tabviewControllerObj.profileObj.mypostobj.mypostDetailObj = self;
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = _strTitleName;
    self.navigationItem.hidesBackButton = YES;
    
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
    
   
    //UI
    
//    scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight/2-20)];
//    [self.view addSubview:scrollviewimage];

    viewscroll = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screenWidth, screenHeight-330)];
    //    viewscroll.backgroundColor = [UIColor blueColor];
    [self.view addSubview:viewscroll];
    
    scrollviewimage = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-270)];

   /* lblPrice = [[UILabel alloc]init];
    lblPrice.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblPrice.textColor = [UIColor whiteColor];
    [self.view addSubview:lblPrice];*/
    
    lblName = [[UILabel alloc]init];
    lblName.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblName.textColor = [UIColor whiteColor];

    [self.view addSubview:lblName];
    
    UIView *dateview = [[UIView alloc]initWithFrame:CGRectMake(0, lblName.frame.origin.y+lblName.frame.size.height, screenWidth, 30)];
    dateview.backgroundColor = tableBackgroundColor;
    
    lblPrice = [[UILabel alloc]init];
    lblPrice.backgroundColor = tableBackgroundColor;
    lblPrice.textColor = [UIColor grayColor];
    lblPrice.font = FontRegular16;
    [dateview addSubview:lblPrice];

    
    /*lblDate = [[UILabel alloc]init];
    lblDate.backgroundColor = tableBackgroundColor;
    lblDate.textColor = [UIColor grayColor];
    lblDate.font = FontRegular16;
    [dateview addSubview:lblDate];*/


    lblExpired = [[UILabel alloc]init];
    lblExpired.backgroundColor = tableBackgroundColor;
    lblExpired.font = FontRegular16;
    lblExpired.textColor = [UIColor grayColor];
    lblExpired.textAlignment = NSTextAlignmentRight;

    [dateview addSubview:lblExpired];
    [self.view addSubview:dateview];


    viewButton = [[UIView alloc]init];
    viewButton.backgroundColor = tableBackgroundColor;

    //EditPost Button
//    UIButton *
    btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEdit.frame = CGRectMake(8, 7, 65, 20);
    [btnEdit setTitleColor:[UIColor colorWithRed:22.0/255.0 green:79.0/255.0 blue:193.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnEdit setTitle:@"Edit Post" forState:UIControlStateNormal];
    btnEdit.titleLabel.font = FontRegular16;
    [btnEdit addTarget:self action:@selector(btnEditPostClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnEdit];

//    UIButton *
    btnEditImg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEditImg.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    btnEditImg.frame = CGRectMake(btnEdit.frame.origin.x + btnEdit.frame.size.width, 7, 15, 20);
    [btnEditImg setTitleColor:[UIColor colorWithRed:22.0/255.0 green:79.0/255.0 blue:193.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnEditImg setTitle:[NSString fontAwesomeIconStringForEnum:FAPencilSquareO] forState:UIControlStateNormal];
    [btnEditImg addTarget:self action:@selector(btnEditPostClicked:) forControlEvents:UIControlEventTouchUpInside];

    [viewButton addSubview:btnEditImg];
    
    
    //Change status Button
    UIButton *btnChangeStatus = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnChangeStatus.frame = CGRectMake(btnEditImg.frame.origin.x + btnEditImg.frame.size.width+35, 7, 105, 20);
    btnChangeStatus.frame = CGRectMake(screenWidth/2-50, 7,80, 20);

    [btnChangeStatus setTitleColor:[UIColor colorWithRed:55.0/255.0 green:56.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//    [btnChangeStatus setTitle:@"Change Status" forState:UIControlStateNormal];
    btnChangeStatus.titleLabel.font = FontRegular16;
    [btnChangeStatus addTarget:self action:@selector(btnChangeStatusClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnChangeStatus];
    
    UIButton *btnChangeStatusImg = [UIButton buttonWithType:UIButtonTypeCustom];
    btnChangeStatusImg.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    btnChangeStatusImg.frame = CGRectMake(btnChangeStatus.frame.origin.x+btnChangeStatus.frame.size.width, 7, 15, 20);
    [btnChangeStatusImg setTitleColor:[UIColor colorWithRed:55.0/255.0 green:56.0/255.0 blue:55.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnChangeStatusImg setTitle:[NSString fontAwesomeIconStringForEnum:FAtrash] forState:UIControlStateNormal];
    [btnChangeStatusImg addTarget:self action:@selector(btnChangeStatusClicked:) forControlEvents:UIControlEventTouchUpInside];
    [viewButton addSubview:btnChangeStatusImg];

    [self.view addSubview:viewButton];
    
    txtviewDecscription = [[UITextView alloc]init];
    txtviewDecscription.backgroundColor = [UIColor whiteColor];
    txtviewDecscription.textColor = [UIColor grayColor];
    txtviewDecscription.font = FontRegular16;
    txtviewDecscription.editable = false;
    [self.view addSubview:txtviewDecscription];

    
    NSString *str = [_dictPostDetail valueForKey:@"imagepathurl"];
    NSRange range = [str rangeOfString:@"campus_buzz_gallery"];
    
    //Dict Detail
    if ([_dictPostDetail valueForKey:@"buzz_id"] || [[_dictPostDetail valueForKey:@"type"] isEqualToString:@"CB"])
    {
        [btnEdit setTitle:@"Edit buzz" forState:UIControlStateNormal];
        [btnChangeStatus setTitle:@"Delete buzz" forState:UIControlStateNormal];
        self.navigationItem.title = @"BUZZ DETAILS";

        btnEdit.tag = 1;

        strStatusName = @"buzz";
        lblPrice.hidden = YES;
        viewButton.hidden = NO;
        
        lblName.frame = CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 35);
        lblDate.frame = CGRectMake(5,0, screenWidth/2, 30);
        lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 30);
        dateview.frame = CGRectMake(0, lblName.frame.origin.y+lblName.frame.size.height, screenWidth, 30);
        viewButton.frame = CGRectMake(0,screenHeight-navBarHeight-tabBarHeight+7, screenWidth, 30);
        txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-20, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+viewButton.frame.size.height+tabBarHeight+20));
    }
    else if ([_dictPostDetail valueForKey:@"post_id"] || [[_dictPostDetail valueForKey:@"type"] isEqualToString:@"PM"])
    {
        [btnEdit setTitle:@"Edit post" forState:UIControlStateNormal];
        [btnChangeStatus setTitle:@"Delete post" forState:UIControlStateNormal];

        self.navigationItem.title = @"POST DETAILS";
        btnEdit.tag = 2;
        strStatusName = @"post";
        lblPrice.hidden = NO;
        viewButton.hidden = NO;
        viewButton.frame = CGRectMake(0,screenHeight-navBarHeight-tabBarHeight+7, screenWidth, 30);
        
        lblName.frame = CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 35);
        lblPrice.frame = CGRectMake(5, 0, screenWidth/2, 30);
        lblDate.frame = CGRectMake(5,0, screenWidth/2, 30);
        lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 30);
        dateview.frame = CGRectMake(0, lblName.frame.origin.y+lblName.frame.size.height, screenWidth, 30);
        txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-20, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+viewButton.frame.size.height+tabBarHeight+20));
    }
    else if (range.length != NSNotFound && range.length>0)
    {
        [btnEdit setTitle:@"Edit buzz" forState:UIControlStateNormal];
        [btnChangeStatus setTitle:@"Delete buzz" forState:UIControlStateNormal];
        self.navigationItem.title = @"BUZZ DETAILS";
        
        btnEdit.tag = 1;
        
        strStatusName = @"buzz";
        lblPrice.hidden = YES;
        viewButton.hidden = NO;
        
        lblName.frame = CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 35);
        lblDate.frame = CGRectMake(5,0, screenWidth/2, 30);
        lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 30);
        dateview.frame = CGRectMake(0, lblName.frame.origin.y+lblName.frame.size.height, screenWidth, 30);
        viewButton.frame = CGRectMake(0,screenHeight-navBarHeight-tabBarHeight+7, screenWidth, 30);
        txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-20, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+viewButton.frame.size.height+tabBarHeight+20));
    }
    else
    {
        [btnEdit setTitle:@"Edit post" forState:UIControlStateNormal];
        [btnChangeStatus setTitle:@"Delete post" forState:UIControlStateNormal];
        
        self.navigationItem.title = @"POST DETAILS";
        btnEdit.tag = 2;
        strStatusName = @"post";
        lblPrice.hidden = NO;
        viewButton.hidden = NO;
        viewButton.frame = CGRectMake(0,screenHeight-navBarHeight-tabBarHeight+7, screenWidth, 30);
//        lblPrice.frame = CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 35);
        lblName.frame = CGRectMake(0, scrollviewimage.frame.origin.y+scrollviewimage.frame.size.height, screenWidth, 35);
        lblPrice.frame = CGRectMake(5,0, screenWidth/2, 30);
        lblExpired.frame = CGRectMake(screenWidth/2,0, screenWidth/2-10, 30);
        dateview.frame = CGRectMake(0, lblName.frame.origin.y+lblName.frame.size.height, screenWidth, 30);
        txtviewDecscription.frame = CGRectMake(5, dateview.frame.origin.y+dateview.frame.size.height+5, screenWidth-20, screenHeight-(dateview.frame.origin.y+dateview.frame.size.height+viewButton.frame.size.height+tabBarHeight+20));
        [self setPostDetail];
    }
    IsFromOpenImageView = false;
    
//
    
   int  status12 = [[_dictPostDetail valueForKey:@"status"] intValue];
    if (status12 !=0) {
        btnEdit.hidden = YES;
        btnEditImg.hidden = YES;
    }
    else
    {
        btnEdit.hidden = NO;
        btnEditImg.hidden = NO;
    }


    if ([_dictPostDetail valueForKey:@"notification_id"]) {
        SelectMsgType = 0;
    }
    else
    {
        SelectMsgType = 1;

    }
    
    if(SelectMsgType==0)
    {
        btnEdit.hidden = YES;
        btnEditImg.hidden = YES;

    }
    
    if (_dictPostDetail.count > 1)
    {
        [self setPostDetail];

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

-(void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    
    if (IsFromOpenImageView == false) {
        
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            
            [MBProgressHUD showHUDAddedTo:viewscroll animated:YES];
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            NSString *str = [_dictPostDetail valueForKey:@"imagepathurl"];
            NSRange range = [str rangeOfString:@"campus_buzz_gallery"];

            if(SelectMsgType==0)
            {
                NSLog(@"notification");
                
                [dict setValue: [_dictPostDetail valueForKey:@"user_id"] forKey:@"user_id"];
                [dict setValue:[_dictPostDetail valueForKey:@"notification_id"] forKey:@"notification_id"];
                [dict setValue:[_dictPostDetail valueForKey:@"reference_id"] forKey:@"reference_id"];
                [dict setValue:[NSString stringWithFormat:@"2"] forKey:@"notification_type"];
                [dict setValue:@"Y" forKey:@"chr_read"];
                
                NSLog(@"notification %@",dict);
                
                if([_dictPostDetail valueForKey:@"buzz_id"] || [[_dictPostDetail valueForKey:@"type"] isEqualToString:@"CB"])
                {
                        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"notification_buzzdetail";
                        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"notification_buzzdetail" withToken:NO];
                }
                else if ([_dictPostDetail valueForKey:@"post_id"])
                {
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"notification_postdetail";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"notification_postdetail" withToken:NO];
                }
                else if (range.length != NSNotFound && range.length>0)
                {
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"notification_buzzdetail";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"notification_buzzdetail" withToken:NO];

                }
                else
                {
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"notification_postdetail";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"notification_postdetail" withToken:NO];

                }
            }
            else
            {
                if([_dictPostDetail valueForKey:@"buzz_id"])
                {
                    [dict setValue:[_dictPostDetail valueForKey:@"buzz_id"] forKey:@"buzz_id"];
                    
                }
                else if([_dictPostDetail valueForKey:@"post_id"])
                {
                    [dict setValue:[_dictPostDetail valueForKey:@"post_id"] forKey:@"post_id"];
                }
                else if([_dictPostDetail valueForKey:@"id"])
                {
                    if([_dictPostDetail valueForKey:@"buzz_id"] || [[_dictPostDetail valueForKey:@"type"] isEqualToString:@"CB"])
                    {
                        [dict setValue:[_dictPostDetail valueForKey:@"id"] forKey:@"buzz_id"];
                    }
                    else
                    {
                        [dict setValue:[_dictPostDetail valueForKey:@"id"] forKey:@"post_id"];
                        
                    }
                }
                
                [dict setValue: [_dictPostDetail valueForKey:@"user_id"] forKey:@"user_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_uid"];
                
                
                            if([_dictPostDetail valueForKey:@"buzz_id"] || [[_dictPostDetail valueForKey:@"type"] isEqualToString:@"CB"] )
                            {
                                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"buzz_detail";
                                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"buzz_detail" withToken:NO];
                            }
                            else
                            {
                                [dict setValue:[_dictPostDetail valueForKey:@"notification_id"] forKey:@"notification_id"];
                                [dict setValue:@"Y" forKey:@"chr_read"];
                                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_detail";
                                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_detail" withToken:NO];
                            }
            }
        }
        else
        {
            [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        }
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        arrayImageList =  [defaults valueForKey:@"ImageArrayInDetail"];
        arrayImageId = [defaults valueForKey:@"ImageIdArrayInDetail"];
        viewscroll.frame = CGRectMake(0, 20, screenWidth, screenHeight/2-80);
//        viewscroll.backgroundColor =[UIColor redColor];
//        scrollviewimage.backgroundColor =[UIColor yellowColor];
        [self ImageDisplayInscrollView:arrayImageList];

    }
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
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
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];

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

#pragma mark - methods

-(void)ImageDisplayInscrollView:(NSMutableArray*)ImageArray
{
    scrollviewimage.showsHorizontalScrollIndicator = false;
    
    int x = ipadDevice?0:0 ;
    
    for (int i = 0; i < ImageArray.count; i++) {
        UIView *View = [[UIView alloc]initWithFrame:CGRectMake(x, 0,screenWidth,scrollviewimage.frame.size.height)];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
//        imgview.image =[UIImage imageWithData:[ImageArray objectAtIndex:i]];
//        imgview.contentMode = UIViewContentModeScaleAspectFill;//UIViewContentModeCenter;
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
            imgview.image = nil;
            imgview.image = (UIImage*)image;
            imgview.contentMode = UIViewContentModeScaleAspectFill;

            
//            UIImageView *imgviewNew = imgview;
            [MBProgressHUD hideAllHUDsForView:imgview animated:YES];
            [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
//
//            
//            [scrollviewimage setNeedsDisplay];
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     imgview.image = nil;
                     imgview.image = [UIImage imageWithData:data];
                     imgview.contentMode = UIViewContentModeScaleAspectFill;

                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
//                     
//                     UIImageView *imgviewNew = imgview;
                     [MBProgressHUD hideAllHUDsForView:imgview animated:YES];
                     [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
//
//                     
//                     [scrollviewimage setNeedsDisplay];
                 }
             }];
        }

        
        imgview.tag = i;
        imgview.userInteractionEnabled = NO;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapOnImage:)];
//        [imgview addGestureRecognizer:tap];
//        
        [View addSubview:imgview];
      [scrollviewimage addSubview:View];
        x = View.frame.origin.x+View.frame.size.width+10;
        scrollviewimage.contentSize = CGSizeMake(x,ipadDevice?200:100);
        [viewscroll addSubview:scrollviewimage];
    }
    if (ImageArray.count< 1) {
        [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];
        
    }

}

-(void)TapOnImage:(UITapGestureRecognizer*)tap
{
    UIImageView *img = (UIImageView*)tap.view;
    NSLog(@"img %@",img);
    
    OpenImageViewController *imgviewOpenObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenImageViewController"];

//    imgviewOpenObj.image = [self imageResize:img.image andResizeTo:CGSizeMake(img.image.size.width/3, img.image.size.height/3)];
    if ([_dictPostDetail valueForKey:@"buzz_id"] || [[_dictPostDetail valueForKey:@"type"] isEqualToString:@"CB"])
    {
        imgviewOpenObj.arrayImage = arrayBuzzImageList;

    }
    else
    {
        imgviewOpenObj.arrayImage = arrayImageList;

    }
//    arrayBuzzImageList
    imgviewOpenObj.indexpage = (int)img.tag;
    IsFromOpenImageView = true;

    [self.navigationController pushViewController:imgviewOpenObj animated:YES];
//    [self presentViewController:imgviewOpenObj animated:YES completion:nil];
    
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
-(void)btnEditPostClicked:(UIButton*)sender
{
    NSLog(@"sender button %@",sender);

//    if ([sender.titleLabel.text isEqualToString:@"Edit post"])
    {
        IsFromOpenImageView = true;
        NSLog(@"Edit post");

        EditPostViewController *editpost = [self.storyboard instantiateViewControllerWithIdentifier:@"EditPostViewController"];
        editpost.userID = [[_dictPostDetail valueForKey:@"user_id"] intValue];
        
        if([_dictPostDetail valueForKey:@"post_id"])
        {
            editpost.postID = [[_dictPostDetail valueForKey:@"post_id"] intValue];
            editpost.universityID = [[_dictPostDetail valueForKey:@"post_id"] intValue];
        }
        else if([_dictPostDetail valueForKey:@"id"])
        {
            editpost.postID = [[_dictPostDetail valueForKey:@"id"] intValue];
            editpost.universityID = [[_dictPostDetail valueForKey:@"id"] intValue];
        }
        else if([_dictPostDetail valueForKey:@"buzz_id"])
        {
            editpost.postID = [[_dictPostDetail valueForKey:@"buzz_id"] intValue];
            editpost.universityID = [[_dictPostDetail valueForKey:@"buzz_id"] intValue];
        }
        
        if ([sender.titleLabel.text isEqualToString:@"Edit post"])
        {
           editpost.strTitleName = @"EDIT POST";
        }
        else
        {
            editpost.strTitleName = @"EDIT BUZZ";
        }
        
        [self.navigationController pushViewController:editpost animated:YES];
    }
}

-(void)btnChangeStatusClicked:(id)sender
{
    NSLog(@"change status %@",sender);
    
     status = [[_dictPostDetail valueForKey:@"status"] intValue];
    
//    if (status == 0)
//    {
//        
//        CustomActionSheet *actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Change status" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Expire",@"Closed",@"Delete", nil];
//        [actionSheet showAlert];
//
//        
//
//    }
//    else if (status == 1)
//    {
//        CustomActionSheet *actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Change status" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Closed",@"Delete", nil];
//        [actionSheet showAlert];
//
//        
//
//    }
//    if (status == 2)
//    {
        CustomActionSheet *actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Change status" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        [actionSheet showAlert];

//    }
    
    
    
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSLog(@"Expiry");
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            
            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
            [dict setValue: [_dictPostDetail valueForKey:@"user_id"] forKey:@"user_id"];
            if([_dictPostDetail valueForKey:@"post_id"])
            {
                [dict setValue:[_dictPostDetail valueForKey:@"post_id"] forKey:@"post_id"];
            }
            else if([_dictPostDetail valueForKey:@"id"])
            {
                [dict setValue:[_dictPostDetail valueForKey:@"id"] forKey:@"post_id"];
            }
            else if([_dictPostDetail valueForKey:@"buzz_id"])
            {
                [dict setValue:[_dictPostDetail valueForKey:@"buzz_id"] forKey:@"buzz_id"];
            }
            
            //            if (status == 0)
            //            {
            //
            //                if (buttonIndex == 0)
            //                {
            //                    NSLog(@"Expired");
            //                    [dict setValue:@"1" forKey:@"status"];
            //                }
            //                else if (buttonIndex == 1)
            //                {
            //                    NSLog(@"close");
            //                    [dict setValue:@"2" forKey:@"status"];
            //
            //                }
            //                else if (buttonIndex == 2)
            //                {
            //                    NSLog(@"delete");
            //                    [dict setValue:@"3" forKey:@"status"];
            //                }
            //
            //             }
            //             else if (status == 1)
            //             {
            //                 if (buttonIndex == 0) {
            //                     NSLog(@"close");
            //                     [dict setValue:@"2" forKey:@"status"];
            //
            //                 }
            //                 else if (buttonIndex == 1)
            //                 {
            //                     NSLog(@"delete");
            //                     [dict setValue:@"3" forKey:@"status"];
            //                 }
            //
            //             }
            //             else
            //                 if (status == 2)
            {
                
                
                NSLog(@"delete");
                [dict setValue:@"3" forKey:@"status"];
                
                if ([strStatusName isEqualToString:@"buzz"])
                {
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"buzz_status";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"buzz_status" withToken:NO];
                    
                }
                else
                {
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"update_status";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"update_status" withToken:NO];
                }
                
                
            }
            
        }
        else
        {
            
            [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        }
    }
    
}

-(void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld", (long)buttonIndex);
    btnIndex = (int)buttonIndex;
    
       if (buttonIndex != -1)
       {
           if ([_dictPostDetail valueForKey:@"buzz_id"]) {
               UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to delete this buzz?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
               [alert show];

           }
           else
           {
           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to delete this post?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
           [alert show];
           }
       }
    
}



#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    int status1 = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    [MBProgressHUD hideAllHUDsForView:scrollviewimage animated:YES];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [MBProgressHUD hideAllHUDsForView:viewscroll animated:YES];

    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (status1 == 200)
    {
        if ([nState isEqualToString:@"post_detail"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                NSDictionary *dict = (NSDictionary*)arrData;
                if([[dict valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    _dictPostDetail = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
                    [self setPostDetail];
                }
                if([[dict valueForKey:@"Response"] valueForKey:@"images"])
                {
                    NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
                    NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
                    
                    if (arrayImageList.count>0)
                    {
                        [arrayImageList removeAllObjects];
                    }

                    for (int i = 0; i < arrayImage.count; i++) {
                        
                        NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
                        //                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                        if (!arrayImageList) {
                            arrayImageList = [[NSMutableArray alloc]init];
                        }
                        
                        [arrayImageList addObject:str];
                        
                    }
                    
                    
                    arrayImageId = [[[dict valueForKey:@"Response"] valueForKey:@"images"] valueForKey:@"image_id"];
                    arrayAllMyPostData = [[dict valueForKey:@"Response"]valueForKey:@"Details"];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setValue:arrayImageList forKey:@"ImageArrayInDetail"];
                    [defaults setValue:arrayImageId forKey:@"ImageIdArrayInDetail"];
                    [defaults setValue:arrayAllMyPostData forKey:@"AllMyPostData"];
                    [defaults synchronize];
                    
                    viewscroll.frame = CGRectMake(0, 20, screenWidth, screenHeight/2-80);
                    [self setPostDetail];

                    [self ImageDisplayInscrollView:arrayImageList];
                }
            }
        }
        
        if ([nState isEqualToString:@"buzz_detail"])
        {
            
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            
            NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
            NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
            
            if (arrayBuzzImageList.count>0)
            {
                [arrayBuzzImageList removeAllObjects];
            }

            for (int i = 0; i < arrayImage.count; i++) {

                NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
//                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                if (!arrayBuzzImageList) {
                    arrayBuzzImageList = [[NSMutableArray alloc]init];
                }
                [arrayBuzzImageList addObject:str];
                
            }
            
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setValue:arrayBuzzImageList forKey:@"BuzzImageInMyPost"];
            [defaults synchronize];
            
//            if (_dictPostDetail == nil || _dictPostDetail.count < 1)
            {
//                if([[dict valueForKey:@"Response"] valueForKey:@"Details"])
//                {
//                    _dictPostDetail = [[dict valueForKey:@"Response"] valueForKey:@"Details"];
//                    [self setPostDetail];
//                }
            }
            txtviewDecscription.text = [[[dict valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"description"];

            [self ImageDisplayInscrollView:arrayBuzzImageList];
            
        }
        if ([nState isEqualToString:@"notification_buzzdetail"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            
            NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
            NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
            
            if (arrayBuzzImageList.count>0)
            {
                [arrayBuzzImageList removeAllObjects];
            }
            
            for (int i = 0; i < arrayImage.count; i++) {
                
                NSString *str;
                //                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                if (strImagepath == nil) {
                    str = [_dictPostDetail valueForKey:@"imagepathurl"];
                }
                else
                {
                    str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
                }
                if (!arrayBuzzImageList) {
                    arrayBuzzImageList = [[NSMutableArray alloc]init];
                }
                [arrayBuzzImageList addObject:str];
                
            }
            
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setValue:arrayBuzzImageList forKey:@"BuzzImageInMyPost"];
            [defaults synchronize];
            
            if([[dict valueForKey:@"Response"] valueForKey:@"Details"])
            {
                _dictPostDetail = [[[dict valueForKey:@"Response"] valueForKey:@"Details"] objectAtIndex:0];
                [self setPostDetail];
            }
            [self ImageDisplayInscrollView:arrayBuzzImageList];

        }
        if ( [nState isEqualToString:@"notification_postdetail"])
        {
        
            self.navigationController.view.userInteractionEnabled = true;
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                NSDictionary *dict = (NSDictionary*)arrData;
                if([[dict valueForKey:@"Response"] valueForKey:@"images"])
                {
                    NSArray *arrayImage = [[dict valueForKey:@"Response"] valueForKey:@"images"];
                    NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
                    if (strImagepath == nil) {
                        strImagepath = [[_dictPostDetail valueForKey:@"imagepathurl"] stringByDeletingLastPathComponent];
                        strImagepath = [NSString stringWithFormat:@"%@/",strImagepath];
                    }

                    
                    if (arrayImageList.count>0)
                    {
                        [arrayImageList removeAllObjects];
                    }
                    
                    for (int i = 0; i < arrayImage.count; i++) {
                        
                        NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[[arrayImage objectAtIndex:i] valueForKey:@"image"]];
                        //                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                        if (!arrayImageList) {
                            arrayImageList = [[NSMutableArray alloc]init];
                        }
                        
                        [arrayImageList addObject:str];
                        
                    }
                    
                    
                    arrayImageId = [[[dict valueForKey:@"Response"] valueForKey:@"images"] valueForKey:@"image_id"];
                    arrayAllMyPostData = [[dict valueForKey:@"Response"]valueForKey:@"Details"];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setValue:arrayImageList forKey:@"ImageArrayInDetail"];
                    [defaults setValue:arrayImageId forKey:@"ImageIdArrayInDetail"];
                    [defaults setValue:arrayAllMyPostData forKey:@"AllMyPostData"];
                    [defaults synchronize];
                    
                    viewscroll.frame = CGRectMake(0, 20, screenWidth, screenHeight/2-80);
                    [self setPostDetail];
                    
                    [self ImageDisplayInscrollView:arrayImageList];
                }
                if([[dict valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    
                    _dictPostDetail = [[[dict valueForKey:@"Response"] valueForKey:@"Details"] objectAtIndex:0];
                    [self setPostDetail];
                }
                
            }

        }

    }
    else if (status1 == 204)
    {
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
        
        if ([nState isEqualToString:@"update_status"] || [nState isEqualToString:@"buzz_status"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            NSDictionary *dict = (NSDictionary*)arrData;
            NSLog(@"dict %@",dict);
            
            
//            if (status == 0)
//            {
//                if (btnIndex == 0)
//                {
//                    NSLog(@"Expired");
//                    [_dictPostDetail setValue:@"1" forKey:@"status"];
//                    [self.view makeToast:[NSString stringWithFormat:@"Your %@ has been expired.",strStatusName]];
//                }
//                else if (btnIndex == 1)
//                {
//                    NSLog(@"close");
//                    [_dictPostDetail setValue:@"2" forKey:@"status"];
//                    [self.view makeToast:[NSString stringWithFormat:@"Your %@ has been closed.",strStatusName]];
//                    
//                }
//                else if (btnIndex == 2)
//                {
//                    NSLog(@"delete");
//                    [_dictPostDetail setValue:@"3" forKey:@"status"];
//                    [self.view makeToast:[NSString stringWithFormat:@"Your %@ has been deleted.",strStatusName]];
//                    
//                }
//                
//            }
//            else if (status == 1)
//            {
//                if (btnIndex == 0) {
//                    NSLog(@"close");
//                    [_dictPostDetail setValue:@"2" forKey:@"status"];
//                    [self.view makeToast:[NSString stringWithFormat:@"Your %@ has been closed.",strStatusName]];
//                    
//                }
//                else if (btnIndex == 1)
//                {
//                    NSLog(@"delete");
//                    [_dictPostDetail setValue:@"3" forKey:@"status"];
//                    [self.view makeToast:[NSString stringWithFormat:@"Your %@ has been deleted.",strStatusName]];
//                }
//                
//            }
//            else if (status == 2)
            {
                if (btnIndex == 0)
                {
                    NSLog(@"delete");
                    [_dictPostDetail setValue:@"3" forKey:@"status"];
                    [self.view makeToast:[NSString stringWithFormat:@"Your %@ has been deleted.",strStatusName]];
                    lblExpired.text = @"Deleted";
                }
            }
            
        }
    }

    else if (status1 == 404)
    {
        
    }
    else if (status1 == 401)
    {
    }
    else if (status1 == 400)
    {
    }
    
    else if (strstatuscode == 500)
    {
        [MBProgressHUD hideAllHUDsForView:scrollviewimage animated:YES];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;

        HideNetworkActivityIndicator();
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,-20, screenWidth,scrollviewimage.frame.size.height)];
        imgview.image = [UIImage imageNamed:@"lodingicon.png"];
        [viewscroll addSubview:imgview];

    }
}

- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;
{
        NSLog(@"nstate %@",nState);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = YES;
    [self.view makeToast:@"Internal Server Error"];

}

-(void)setPostDetail

{
    if([_dictPostDetail valueForKey:@"buzz_name"])
    {
        lblName.text = [NSString stringWithFormat:@"  %@",[_dictPostDetail valueForKey:@"buzz_name"]];
    }
    else if([_dictPostDetail valueForKey:@"post_name"])
    {
        lblName.text = [NSString stringWithFormat:@"  %@",[_dictPostDetail valueForKey:@"post_name"]];
    }
    else if([_dictPostDetail valueForKey:@"name"])
    {
        lblName.text = [NSString stringWithFormat:@"  %@",[_dictPostDetail valueForKey:@"name"]];
    }
    else
    {
        lblName.text = [NSString stringWithFormat:@"  %@",[_dictPostDetail valueForKey:@"title"]];
    }
//    if([_dictPostDetail valueForKey:@"crate_date"])
//    {
//        lblDate.text = [NSString stringWithFormat:@"  %@",[[GlobalMethod shareGlobalMethod] DateDisplayWithMonthName:[_dictPostDetail valueForKey:@"crate_date"] firstMonth:YES]];
//    }
//    if([_dictPostDetail valueForKey:@"expirydate"])
    
    {
        NSString  *strdate = [_dictPostDetail valueForKey:@"expirydate"];
//        if (strdate == nil)
//        {
//            strdate = [[_dictPostDetail valueForKey:@"expirydate"]objectAtIndex:0];
//        }
        
        if (strdate) {
            lblDate.text = [NSString stringWithFormat:@" %@",[[GlobalMethod shareGlobalMethod] DateDisplayWithMonthName:strdate firstMonth:NO]];
        }
    }

    
    if([_dictPostDetail valueForKey:@"price"])
    {
        lblPrice.text =  [NSString stringWithFormat:@"  $%@",[_dictPostDetail valueForKey:@"price"]];
    }
    
    if ([[_dictPostDetail valueForKey:@"status"] isEqualToString:@"1"]) {
        lblExpired.text = @"Expired";
        btnEdit.hidden = YES;
        
    }
    
    else if ([[_dictPostDetail valueForKey:@"status"] isEqualToString:@"2"]) {
        lblExpired.text = @"Closed";
         btnEdit.hidden = YES;

    }
    else
    {
        if ([_dictPostDetail valueForKey:@"expirydate"])
        {
        NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[_dictPostDetail valueForKey:@"expirydate"]];
        lblExpired.text = str;
            if ([lblExpired.text isEqualToString:@"Expired"]) {
                btnEdit.hidden = YES;
                btnEditImg.hidden = YES;
            }
            else
            {
                btnEdit.hidden = NO;
                btnEditImg.hidden = NO;

            }

        }
    }
    if(SelectMsgType==0)
    {
        btnEdit.hidden = YES;
        btnEditImg.hidden = YES;
        
    }

//    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[_dictPostDetail valueForKey:@"expirydate"]];
//    lblExpired.text = [NSString stringWithFormat:@"%@    ",str];
    
    if([_dictPostDetail valueForKey:@"description"])
    {
        txtviewDecscription.text = [_dictPostDetail valueForKey:@"description"];
    }
}

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
