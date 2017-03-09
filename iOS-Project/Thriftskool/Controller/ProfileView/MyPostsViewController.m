//
//  MyPostsViewController.m
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "MyPostsViewController.h"
#import "SelectCategoryPostLIstTableViewCell.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"


@interface MyPostsViewController ()

@end

@implementation MyPostsViewController
@synthesize mypostDetailObj;

- (void)viewDidLoad {
    
    appDelegate.tabviewControllerObj.profileObj.mypostobj = self;
    [super viewDidLoad];

    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"MY POSTS";

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
    
    
    //sorting
    UIButton *btnsort = [UIButton buttonWithType:UIButtonTypeCustom];
    btnsort.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btnsort setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnsort setTitle:[NSString fontAwesomeIconStringForEnum:FAsliders] forState:UIControlStateNormal];
    btnsort.frame = CGRectMake(0,1, 25.0, 20.0);
    [btnsort addTarget:self action:@selector(btnSortingClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnSortView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 25, 22)];
    btnSortView.bounds = CGRectOffset(btnSortView.bounds, 0,0);
    [btnSortView addSubview:btnsort];
    UIBarButtonItem *sortBtn = [[UIBarButtonItem alloc]initWithCustomView:btnSortView];
    
    // Delete
    btndelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btndelete.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btndelete setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btndelete setTitle:[NSString fontAwesomeIconStringForEnum:FACheckSquareO] forState:UIControlStateNormal];
    btndelete.frame = CGRectMake(0,1, 25, 20.0);
    [btndelete addTarget:self action:@selector(btnDeleteClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnDeleteView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 25, 22)];
    //        btnDeleteView.backgroundColor = [UIColor blueColor];
    
    btnDeleteView.bounds = CGRectOffset(btnDeleteView.bounds, 0,0);
    [btnDeleteView addSubview:btndelete];
    UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc]initWithCustomView:btnDeleteView];


    self.navigationItem.rightBarButtonItems = @[bellBtn,sortBtn,deleteBtn];

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
    
    
    tblMyPostList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tblMyPostList.showsVerticalScrollIndicator = false;
    tblMyPostList.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;

    IsFromPostDetailPage = false;
   
    
    footerHud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    footerHud.tag = 10;
    
    footerHud.frame = CGRectMake(0, 0.0,44.0, 44.0);
    
    footerHud.hidesWhenStopped = YES;
    
    tblMyPostList.tableFooterView = footerHud;
    
    if (!lblNoList) {
        lblNoList = [[UILabel alloc]init];
    }
    lblNoList.frame = CGRectMake(10, (self.view.frame.size.height-104)/2, screenWidth-20, 40);
    lblNoList.text =  NSLocalizedString(@"Blank_post_list", nil);
    lblNoList.numberOfLines = 2;
    lblNoList.font = FontRegular;
    lblNoList.textColor = txtFieldTextColor;
    lblNoList.textAlignment = NSTextAlignmentCenter;
    lblNoList.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:lblNoList];

    btnSortingClicked = false;
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
    isDeleteBtnClicked = false;
    [btndelete setTitle:[NSString fontAwesomeIconStringForEnum:FACheckSquareO] forState:UIControlStateNormal];

    self.tabBarController.tabBar.hidden = false;

     lblNoList.hidden = YES;
    if (IsFromPostDetailPage == false)
    {
        if (arrayMainPost.count>0) {
            [arrayMainPost removeAllObjects];
        }
        isLoadingMore = NO;
        start = 0;
        [self PostListInformation:0 end:10];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [defaults objectForKey:@"MyPostDetails"];
        arrayMainPost = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        arrayAllImages = [defaults valueForKey:@"ImagesMyPost"];
        
        if (arrayMainPost.count<1)
        {
            lblNoList.hidden = NO;
            
        }
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [tblMyPostList reloadData];
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
//        MyPostDetailViewController *
        mypostDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostDetailViewController"];
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

-(void)btnSortingClicked
{
    btnSortingClicked = true;
    NSLog(@"sorting");
    
    if (!actionSheet) {
        actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Price - High to Low", @"Price - Low to High", @"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];
        
    }
    else
    {
        actionSheet.tapBtn = btnSelectedIndex+1;
        actionSheet = [actionSheet initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Price - High to Low", @"Price - Low to High", @"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];
        
    }
    
    
    [actionSheet showAlert];
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
-(void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld", (long)buttonIndex);
    
    btnSelectedIndex = (int)buttonIndex;
    
    if (buttonIndex == 0) {
        NSLog(@"price - High to low");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        
        NSArray *sortedArray = [arrayMainPost mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
        [tblMyPostList reloadData];
        
    }
    if (buttonIndex == 1) {
        
        NSLog(@"price - low to high");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayMainPost mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
        [tblMyPostList reloadData];
        
    }
    if (buttonIndex == 2) {
        
        NSLog(@"Expiry date - sooner to later");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayMainPost mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
        
        [tblMyPostList reloadData];
        
    }
    if (buttonIndex == 3) {
        NSLog(@"Expiry date - later to sooner");
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayMainPost mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
        [tblMyPostList reloadData];
        
    }
    
    
    
}

-(void)PostListInformation:(int)st end:(int)ed
{
    start = start+ed;
    NSLog(@"Mypost  start %d and end %d",st,ed);
    lblNoList.hidden = YES;
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        if(ed<=10)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
        }
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//        [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",st] forKey:@"start"];
        [dict setValue:[NSString stringWithFormat:@"%d",ed] forKey:@"end"];
        NSLog(@"my post dict %@",dict);
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"my_post_list";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"my_post_list" withToken:NO];
    }
    else
    {
        [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        [self loadMoreCompleted];
    }
    
}

-(void)btnDeleteClicked
{
    NSLog(@"Delete btn clicked");
    if (isDeleteBtnClicked == false)
    {
        isDeleteBtnClicked = true;
        NSLog(@"isDeleteBtnClicked = true;");
        [btndelete setTitle:[NSString fontAwesomeIconStringForEnum:FAtrash] forState:UIControlStateNormal];
        
        for (int i =0 ; i<arrayMainPost.count; i++)
        {
            for(NSMutableDictionary *dict in arrayMainPost)
            {
                {
                    [dict setObject:@"0" forKey:@"isPostDelete"];
                }
            }
        }
    }
    else
    {
        isDeleteBtnClicked = false;
        [btndelete setTitle:[NSString fontAwesomeIconStringForEnum:FACheckSquareO] forState:UIControlStateNormal];
        
        NSLog(@"isDeleteBtnClicked = false");
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            //        self.navigationController.view.userInteractionEnabled = false;
            //        self.tabBarController.view.userInteractionEnabled = false;
            //        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            if (!checkmarkArray) {
                checkmarkArray = [[NSMutableArray alloc]init];
                NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
                [dict1 setValue:[arrayMainPost valueForKey:@"post_id"] forKey:@"post"];
                [dict1 setValue:[arrayMainPost valueForKey:@"buzz_id"] forKey:@"buzz"];
                
                if (checkmarkArray.count>0) {
                    [checkmarkArray removeAllObjects];
                }
//                [checkmarkArray addObject:dict1];

            }
//            if (checkmarkArray.count<1) {
////                checkmarkArray = [arrayMainPost valueForKey:@"post_id"];
//                NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
//                [dict1 setValue:[arrayMainPost valueForKey:@"post_id"] forKey:@"post"];
//                [dict1 setValue:[arrayMainPost valueForKey:@"buzz_id"] forKey:@"buzz"];
//                
//                if (checkmarkArray.count>0) {
//                    [checkmarkArray removeAllObjects];
//                }
//                [checkmarkArray addObject:dict1];
//
//            }
            NSArray *arraybuzz;
            NSArray *arraypost;
            if (checkmarkArray.count>0)
            {
                arraybuzz = [[checkmarkArray valueForKey:@"buzz"] objectAtIndex:0];
                arraypost  = [[checkmarkArray valueForKey:@"post"] objectAtIndex:0];
            }
            if (arraypost.count <1 && arraybuzz.count<1) {
                
                [self.view makeToast:@"Please select any one post or buzz"];
                tempArray = nil;
            }
            else
            {
                
                self.navigationController.view.userInteractionEnabled = false;
                self.tabBarController.view.userInteractionEnabled = false;
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];

            
            NSLog(@"checkmarkArray 1 %@",checkmarkArray);
//            [checkmarkArray removeObjectIdenticalTo:[NSNull null]];
//            NSLog(@"checkmarkArray2 %@",checkmarkArray);


            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:[[checkmarkArray valueForKey:@"post"] objectAtIndex:0] forKey:@"post_id"];
            [dict setValue:[[checkmarkArray valueForKey:@"buzz"] objectAtIndex:0] forKey:@"buzz_id"];
//            [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_id"];
            NSLog(@"dict %@",dict);
            
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName =@"delete_post";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"delete_post" withToken:NO];
            for (int i =0 ; i<arrayMainPost.count; i++)
            {
                for(NSMutableDictionary *dict in arrayMainPost)
                {
                    {
                        [dict setObject:@"0" forKey:@"isPostDelete"];
                    }
                }
            }
            }
        }
        else
        {
            [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        }
        
    }
    
    [tblMyPostList reloadData];
    
}

-(void)btnCheckmarkClicked:(UIButton*)btn
{
    NSLog(@"Checkmark btn clicked");
    //    if (checkmarkSelected == true)
    
    if (btn.selected == true)
    {
//        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];

        //        checkmarkSelected= false;
        btn.selected = false;
        
        if (!checkmarkArray) {
            checkmarkArray = [[NSMutableArray alloc]init];
        }
        if (!tempArray) {
            tempArray = [[NSMutableArray alloc]init];
            tempArray = [arrayMainPost mutableCopy];
            
        }
        NSLog(@"tempArray %@",tempArray);
        //    NSArray *array = [[_arraymsgList valueForKey:@"thread_id"] objectAtIndex:btn.tag];
        int threadValue;
        NSArray *array = [arrayMainPost objectAtIndex:btn.tag];
        if (!arrayUnselectedmsg) {
            arrayUnselectedmsg = [[NSMutableArray alloc]init];
            
        }
        [arrayUnselectedmsg addObject:array];
        
        //    if ([[arrayMainPost valueForKey:@"post_id"] objectAtIndex:btn.tag])
        if ([array valueForKey:@"post_id"])
        {
            threadValue = [[[arrayMainPost valueForKey:@"post_id"] objectAtIndex:btn.tag] intValue];//[[[_arraymsgList objectAtIndex:btn.tag] valueForKey:@"thread_id"] intValue];
        }
        else
        {
            threadValue = [[[arrayMainPost valueForKey:@"buzz_id"] objectAtIndex:btn.tag] intValue];//[[[_arraymsgList objectAtIndex:btn.tag] valueForKey:@"thread_id"] intValue];
            
        }
        
        //    int index = [tempArray indexOfObject:[NSString stringWithFormat:@"%d",threadValue]];
        
        int index;
        
        if ([tempArray valueForKey:@"post_id"])
        {
            index = (int)[[tempArray valueForKey:@"post_id"] indexOfObject:[NSString stringWithFormat:@"%d",threadValue]];
        }
        
        if (index > tempArray.count)
        {
            index = (int)[[tempArray valueForKey:@"buzz_id"] indexOfObject:[NSString stringWithFormat:@"%d",threadValue]];
            
        }
        
        [tempArray removeObjectAtIndex:index];

        
    }
    else
    {
        if (!tempArray) {
            tempArray = [[NSMutableArray alloc]init];
        }

        if (!checkmarkArray) {
            checkmarkArray = [[NSMutableArray alloc]init];
        }

        
        //        checkmarkSelected = true;
        btn.selected = true;
//        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateNormal];

        if ([[arrayMainPost objectAtIndex:btn.tag] valueForKey:@"post_id"])
        {
            if (![[tempArray valueForKey:@"post_id"] containsObject:[[arrayMainPost objectAtIndex:btn.tag] valueForKey:@"post_id"]]) // YES
            {
                // Do something
                NSLog(@"not in temp array");
                [tempArray addObject:[arrayMainPost objectAtIndex:btn.tag]];
            }
        }
        else
        {
            if (![[tempArray valueForKey:@"buzz_id"] containsObject:[[arrayMainPost objectAtIndex:btn.tag] valueForKey:@"buzz_id"]]) // YES
            {
                // Do something
                NSLog(@"not in temp array");
                [tempArray addObject:[arrayMainPost objectAtIndex:btn.tag]];
            }
        }
    }
    
    //    NSMutableArray *checkmarkArray = [_arraymsgList mutableCopy];
//    checkmarkArray = [tempArray valueForKey:@"post_id"];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
    [dict1 setValue:[tempArray valueForKey:@"post_id"] forKey:@"post"];
    [dict1 setValue:[tempArray valueForKey:@"buzz_id"] forKey:@"buzz"];
    
    if (checkmarkArray.count>0) {
        [checkmarkArray removeAllObjects];
    }
    [checkmarkArray addObject:dict1];
//    [[[checkmarkArray valueForKey:@"buzz"] objectAtIndex:0] removeObject:@"<null>"];
//    [[[checkmarkArray valueForKey:@"post"] objectAtIndex:0] removeObjectIdenticalTo:@"<null>"];


    
    
    for(NSMutableDictionary *dict in arrayMainPost)
    {
        int idUser;
        if ([[arrayMainPost objectAtIndex:btn.tag] valueForKey:@"post_id"]) {
            idUser = [[[arrayMainPost objectAtIndex:btn.tag] valueForKey:@"post_id"] intValue];
        }
        else
        {
            idUser = [[[arrayMainPost objectAtIndex:btn.tag] valueForKey:@"buzz_id"] intValue];

        }
        
        if([[dict valueForKey:@"post_id"]integerValue]== idUser)
        {
            //                    if ([[dict valueForKey:@"favorite"]isEqualToString:@"0"])
            
            NSString *str = [dict valueForKey:@"isPostDelete"];
            
            if ([str isKindOfClass:[NSNull class]])
            {
                str = @"0";
            }
            
            if ([str isEqualToString:@"0"])
            {
                [dict setObject:@"1" forKey:@"isPostDelete"];
            }
            else
            {
                [dict setObject:@"0" forKey:@"isPostDelete"];
                
            }
        }
        if([[dict valueForKey:@"buzz_id"]integerValue]== idUser)
        {
            //                    if ([[dict valueForKey:@"favorite"]isEqualToString:@"0"])
            
            NSString *str = [dict valueForKey:@"isPostDelete"];
            
            if ([str isKindOfClass:[NSNull class]])
            {
                str = @"0";
            }
            
            if ([str isEqualToString:@"0"])
            {
                [dict setObject:@"1" forKey:@"isPostDelete"];
            }
            else
            {
                [dict setObject:@"0" forKey:@"isPostDelete"];
                
            }
        }

    }

    
    NSLog(@"checkmarkArray %@",checkmarkArray);
    
}
#pragma mark - Load More method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    if (!isLoadingMore) {
        CGFloat scrollPosition = ([arrayMainPost count]*cellHeight)  - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight] && ([arrayMainPost count]*cellHeight)>=[self footerLoadMoreHeight]) {
            
            
            NSLog(@"load more");
            [self loadMore];
        }
    }
}
- (CGFloat) footerLoadMoreHeight
{
    return (tblMyPostList.frame.size.height-DEFAULT_HEIGHT_OFFSET);
}
- (BOOL) loadMore
{
    if (isLoadingMore)
        return NO;
    
    [self willBeginLoadingMore];
    isLoadingMore = YES;
    return YES;
}
- (void) willBeginLoadingMore
{
    tblMyPostList.tableFooterView = footerHud;
    [footerHud startAnimating];
//    [self PostListInformation:(int)[arrayMainPost count]/2 end:10];
    [self PostListInformation:start end:10];

}
- (void) loadMoreCompleted
{
    
    tblMyPostList.tableFooterView = nil;
    [footerHud stopAnimating];
    isLoadingMore = NO;
    [tblMyPostList reloadData];
    
    
}

#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    
    id arrData = [nData JSONValue];
    
    NSLog(@"my post dict respone %@",arrData);
    
    int statuscode = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }

    if (statuscode == 200)
    {
        if ([nState isEqualToString:@"my_post_list"])
        {
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                NSMutableDictionary *dicPostList = (NSMutableDictionary*)arrData;
                NSString *strImagepath=@"";
                if([[dicPostList valueForKey:@"Response"] valueForKey:@"imagepath"])
                {
                    strImagepath = [[dicPostList valueForKey:@"Response"] valueForKey:@"imagepath"];
                    
                }
                if([[dicPostList valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    id allData = [[dicPostList valueForKey:@"Response"] valueForKey:@"Details"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if(!arrayMainPost)
                        {
                            arrayMainPost=[[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicPostList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [arrayMainPost addObject:objPostDic];
                        }
                    }
                }
                
                if ([[dicPostList valueForKey:@"Response"] valueForKey:@"buzz_imagepath"])
                {
                    strImagepath = [[dicPostList valueForKey:@"Response"] valueForKey:@"buzz_imagepath"];
                    
                }

                if([[dicPostList valueForKey:@"Response"] valueForKey:@"Details_buzz"])
                {
                    id allData = [[dicPostList valueForKey:@"Response"] valueForKey:@"Details_buzz"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if(!arrayMainPost)
                        {
                            arrayMainPost=[[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicPostList valueForKey:@"Response"] valueForKey:@"Details_buzz"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [arrayMainPost addObject:objPostDic];
                        }
                    }
                    
                }
                
                
                if(!arrayAllImages)
                {
                    arrayAllImages = [[NSMutableArray alloc]init];
                }
                
                NSArray *arrayImage = [arrayMainPost valueForKey:@"image"];
                
                
                for (int i = 0; i < arrayImage.count; i++) {
                    
                    NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage objectAtIndex:i]];
                    
                    [arrayAllImages addObject:str];
                    
                }
                
                
                if (btnSortingClicked == true)
                {
                    if (btnSelectedIndex == 0) {
                        NSLog(@"price - High to low");
                        
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        
                        NSArray *sortedArray = [arrayMainPost mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
                        
                    }
                    if (btnSelectedIndex == 1) {
                        
                        NSLog(@"price - low to high");
                        
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayMainPost mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
                        
                    }
                    if (btnSelectedIndex == 2) {
                        
                        NSLog(@"Expiry date - sooner to later");
                        
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayMainPost mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
                        
                        
                    }
                    if (btnSelectedIndex == 3) {
                        NSLog(@"Expiry date - later to sooner");
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayMainPost mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMainPost = [NSMutableArray arrayWithArray:sArray];
                        
                    }
                }
                
                NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                
//                if (isDeleteBtnClicked == true)
                {
                    NSLog(@"arrayUnselectedmsg %@",arrayUnselectedmsg);
                    
                    for (int i =0 ; i<arrayMainPost.count; i++)
                    {
                        for(NSMutableDictionary *dict in arrayMainPost)
                        {
//                            if ([arrayUnselectedmsg valueForKey:@"post_id"] == [dict valueForKey:@"post_id"])
//                            {
//                                
//                                if ([[arrayUnselectedmsg valueForKey:@"isPostDelete"]isEqualToString:@"1"]) {
//                                    [dict setObject:@"1" forKey:@"isPostDelete"];
//
//                                }
//                                else
//                                {
//                                    [dict setObject:@"0" forKey:@"isPostDelete"];
//
//                                }
//                                
//                            }
//                            else
                            
//                            [tempArray removeAllObjects];
//                            [checkmarkArray removeAllObjects];
                            
                            tempArray = nil;
                            checkmarkArray = nil;

                            {
                                if (isDeleteBtnClicked == false)
                                {
                                    [dict setObject:@"0" forKey:@"isPostDelete"];
                                    
                                }
                                else
                                {
                                    [dict setObject:@"1" forKey:@"isPostDelete"];
                                }
                            }
                        }
                    }
                }

                [def setValue:[NSKeyedArchiver archivedDataWithRootObject:arrayMainPost] forKey:@"MyPostDetails"];
                [def setValue:arrayAllImages forKey:@"ImagesMyPost"];
                [def synchronize];
                
                self.navigationController.view.userInteractionEnabled = true;
                self.tabBarController.view.userInteractionEnabled = true;
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self loadMoreCompleted];
                
                if (arrayMainPost.count<1) {
                    lblNoList.hidden = NO;
                }
                
            }
            
        }
        
        if ([nState isEqualToString:@"delete_post"])
        {
            
            if (arrayMainPost.count<1) {
                lblNoList.hidden = NO;
            }
            if([arrayMainPost count]>0)
            {
                [arrayMainPost removeAllObjects];
                
            }

            [tempArray removeAllObjects];
            [checkmarkArray removeAllObjects];
            isDeleteBtnClicked = false;
            [self PostListInformation:0 end:10];
            [self.view makeToast:@"Successfully deleted."];

        }
        
    }
    else if (statuscode == 201)
    {
        
    }
    
    else if (statuscode == 404)
    {
        if (arrayMainPost.count<1) {
            lblNoList.hidden = NO;
            
        }
        
    }
    else if (statuscode == 401)
    {
    }
    else if (statuscode == 400)
    {
    }
    
    else if (strstatuscode == 500)
    {
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }
    if(statuscode != 200)
    {
        
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self loadMoreCompleted];
        if(statuscode == 4041)
        {
            isLoadingMore = YES;
        }
        
    }
}

- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;
{
    
//    NSLog(@"nstate %@",nState);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [self.view makeToast:@"Internal Server Error"];

    
}

#pragma mark - UITableview method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayMainPost.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%d",@"SelectCategorycell",(int)indexPath.row];
    
    SelectCategoryPostLIstTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        cell1 = [[SelectCategoryPostLIstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier];
//        cell1.btnfav.hidden = YES;
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 5)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:separatorLineView];
        
        UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-5, screenWidth, 5)];/// change size as you need.
        bottomline.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:bottomline];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell1.imgviewpost.tag = indexPath.row;

    }
    

    NSDictionary *dicPost = [arrayMainPost objectAtIndex:indexPath.row];
    cell1.btnfav.tag = indexPath.row;

    if (isDeleteBtnClicked == true)
    {
        if ([[dicPost valueForKey:@"isPostDelete"]  isEqual:@"1"])
        {
            //        [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];
            [cell1.btnfav setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateNormal];
            
            //        checkmarkSelected = true;
            cell1.btnfav.selected  = true;
            [cell1.btnfav addTarget:self action:@selector(btnCheckmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            //        [cell1.btnfav setTitle:@"" forState:UIControlStateNormal];
            [cell1.btnfav setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
            cell1.btnfav.selected  = false;
            [cell1.btnfav addTarget:self action:@selector(btnCheckmarkClicked:) forControlEvents:UIControlEventTouchUpInside];

            //        [cell1.btnfav setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
        }
    }
    else
    {
        [cell1.btnfav setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    

    if([dicPost valueForKey:@"post_name"])
    {
        cell1.lblTitle.text =  [dicPost valueForKey:@"post_name"];
        cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",[dicPost valueForKey:@"price"]];
        
    }
    else
    {
        cell1.lblTitle.text =  [dicPost valueForKey:@"buzz_name"];
        cell1.lblPrice.text = @"";
        
    }
    
//    cell1.lblTitle.backgroundColor = [UIColor redColor];
    if ([dicPost valueForKey:@"status"]) {
        if ([[dicPost valueForKey:@"status"] isEqualToString:@"1"]) {
            cell1.lblExpDate.text = @"Expired";
        }
        
        else if ([[dicPost valueForKey:@"status"] isEqualToString:@"2"]) {
            cell1.lblExpDate.text = @"Closed";
        }
        else
        {
            NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[dicPost valueForKey:@"expirydate"]];
            cell1.lblExpDate.text = str;
        }
    }
    else
    {
        NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[dicPost valueForKey:@"expirydate"]];
        cell1.lblExpDate.text = str;
    }
    
    if ([cell1.lblExpDate.text isEqualToString:@"Expired"] || [cell1.lblExpDate.text isEqualToString:@"Closed"])  {
        cell1.lblExpDate.textColor =[UIColor redColor];
        
    }
    else
    {
        cell1.lblExpDate.textColor = [UIColor blackColor];
        
    }
    
    NSString *strImage = [[arrayMainPost valueForKey:@"imagepathurl"] objectAtIndex:indexPath.row];
    

    //    if (![strImage isEqual:[NSNull null]])
    if (![strImage hasSuffix:@"<null>"])
    {
        NSURL *url = [NSURL URLWithString:strImage];
        NSString *cacheFilename = [url lastPathComponent];
//        NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
        int index = (int)[url pathComponents].count-3;
        NSString *folderName =[[url pathComponents] objectAtIndex:index];
        
        NSLog(@"folderName %@",folderName);
        NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];
        
        cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];

        id image = [LazyLoadingImage imageDataFromPath:cachePath];
        if(image)
        {
            cell1.imgviewpost.image = (UIImage*)image;
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     cell1.imgviewpost.image = [UIImage imageWithData:data];
                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                 }
             }];
        }
        
    }
    
    return cell1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
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
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        
        mypostDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostDetailViewController"];
        mypostDetailObj.dictPostDetail = [arrayMainPost objectAtIndex:indexPath.row];
        IsFromPostDetailPage = false;
        mypostDetailObj.SelectMsgType = 1;
        if ([mypostDetailObj.dictPostDetail valueForKey:@"buzz_id"] )
        {
            mypostDetailObj.strTitleName = @"BUZZ DETAILS";
        }
        else if ([mypostDetailObj.dictPostDetail valueForKey:@"post_id"] )
        {
        mypostDetailObj.strTitleName = @"POST DETAILS";
        }
        if (arrayMainPost.count>0) {
            [arrayMainPost removeAllObjects];
        }
        [tblMyPostList reloadData];

        
        [self.navigationController pushViewController:mypostDetailObj animated:YES];
    }
    else
    {
        //        [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSArray *array  = [arrayMainPost objectAtIndex:indexPath.row];
    NSLog(@"array %@",array);

    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        NSMutableArray *arrayBuzz =[[NSMutableArray alloc]init];
        NSMutableArray *arrayPost = [[NSMutableArray alloc]init];
        
        if ([array valueForKey:@"buzz_id"]) {
            
            [arrayBuzz addObject:[array valueForKey:@"buzz_id"]];
        }
        else
        {
            [arrayPost addObject:[array valueForKey:@"post_id"]];
        }
        
        [dict setValue:arrayPost forKey:@"post_id"];
        [dict setValue:arrayBuzz forKey:@"buzz_id"];
//        [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_id"];
        
        NSLog(@"dict %@",dict);
        
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName =@"delete_post";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"delete_post" withToken:NO];
    }
    else
    {
        
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
