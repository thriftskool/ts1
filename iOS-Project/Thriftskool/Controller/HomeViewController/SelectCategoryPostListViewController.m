//
//  SelectCategoryPostListViewController.m
//  Thriftskool
//
//  Created by Asha on 03/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "SelectCategoryPostListViewController.h"
#import "SelectCategoryPostLIstTableViewCell.h"
#import "BuzzDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "DealDetailViewController.h"
#import "MessageDetailViewController.h"


//#import "CustomActionSheet.h"

@interface SelectCategoryPostListViewController ()

@end

@implementation SelectCategoryPostListViewController
@synthesize  selectDetailObj,SelectCategory,dicSearchList;

- (void)viewDidLoad {

    
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
//    self.navigationItem.title = [_strSelectedCategoryName uppercaseString];
    
    
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
    
    
    //sorting Button
    UIButton *btnsort = [UIButton buttonWithType:UIButtonTypeCustom];
    btnsort.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    btnsort.frame = CGRectMake(0, 0, 30, 22);
    [btnsort setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnsort setTitle:[NSString fontAwesomeIconStringForEnum:FAsliders] forState:UIControlStateNormal];
    [btnsort addTarget:self action:@selector(btnSortingClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewSort = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 22)];
    viewSort.bounds = CGRectOffset(viewSort.bounds, 0, 0);
    [viewSort addSubview:btnsort];
    UIBarButtonItem *barSort = [[UIBarButtonItem alloc]initWithCustomView:viewSort];
    
    self.navigationItem.rightBarButtonItems = @[barBell,barSort];
    
    
    
    // tblselectcatList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    FromPostDetailPage = false;
    tblselectcatList.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;
    
//    refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tblselectcatList.frame.size.width, 50)];
//    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
//    refreshControl.tintColor = [UIColor blackColor];
//    NSMutableAttributedString *attr= [[NSMutableAttributedString alloc]initWithString:@"Pull to refresh..." attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName ,nil]];
//    refreshControl.attributedTitle =attr;// [[NSAttributedString alloc] initWithString:@"Pull to refresh..."];
//    [tblselectcatList addSubview:refreshControl];
    
    footerHud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    footerHud.tag = 10;
    
    footerHud.frame = CGRectMake(0, 0.0,44.0, 44.0);
    
    footerHud.hidesWhenStopped = YES;
    
    tblselectcatList.tableFooterView = footerHud;
    
    if (!lblNoList) {
        lblNoList = [[UILabel alloc]init];
    }
    lblNoList.frame = CGRectMake(10, (self.view.frame.size.height-104)/2, screenWidth-20, 40);
    
    lblNoList.numberOfLines = 2;
    lblNoList.font = FontRegular;
    lblNoList.textColor = txtFieldTextColor;
    lblNoList.textAlignment = NSTextAlignmentCenter;
    lblNoList.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:lblNoList];
    
    
    tblselectcatList.showsVerticalScrollIndicator = false;
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
    btnFavClicked  = false;
    lblNoList.hidden = YES;
    self.tabBarController.tabBar.hidden = false;
    self.navigationController.navigationBar.hidden = NO;

//    UIViewController *fromViewController = [[[self navigationController] transitionCoordinator] viewControllerForKey:UITransitionContextFromViewControllerKey];
    
//    if ([[self.navigationController viewControllers] containsObject:fromViewController])
    

    if (_clickedResendBtn == false)
    {
        NSString *uppercase = [_strSelectedCategoryName uppercaseString];
        self.navigationItem.title =  uppercase;

        NSLog(@"Select category btn clicked");
        isLoadingMore = NO;
        self.navigationController.navigationBar.hidden = NO;
        
        if([arrayAllDetail count]>0)
        {
            [arrayAllDetail removeAllObjects];
            [tblselectcatList reloadData];
        }
        
        if(SelectCategory==1)
        {
            lblNoList.text = NSLocalizedString(@"Blank_category_list", nil);
            appDelegate.tabviewControllerObj.homeviewObj.selectcatpostlistObj =  self;
            
            if (FromPostDetailPage == false)
            {
                if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
                    
                    [self CategoryListInformation:nil start:0 end:10];
                }
                else
                {
                    [self.view makeToast:@"Check Internet Connection"];
                }
            }
            else
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                arrayPostImageList = [defaults valueForKey:@"PostImageList"];
                arrayTitleList =   [defaults valueForKey:@"TitleList"];
                arrayExpDateList =  [defaults valueForKey:@"ExpDateList"];
                arrayPriceList =  [defaults valueForKey:@"PriceList"];
                //        arrayAllDetail = [defaults valueForKey:@"ResponseAllDetail"];
                NSData *data = [defaults objectForKey:@"ResponseAllDetail"];
                arrayAllDetail = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                
                if (arrayAllDetail.count<1) {
                    lblNoList.hidden = NO;
                }
                
                
            }
        }
        else
        {
            lblNoList.text = NSLocalizedString(@"Blank_search_result_list", nil);
            self.navigationItem.title = @"SEARCH RESULTS";
            
            [self CategoryListInformation:dicSearchList start:0 end:10];
        }
    }
    else
    {
        NSLog(@"Resend btn clicked");

        lblNoList.text = NSLocalizedString(@"Blank_recentlyAdded_list", nil);
        self.navigationItem.title =  @"RECENTLY ADDED";
        if([arrayAllDetail count]>0)
        {
            [arrayAllDetail removeAllObjects];
            [tblselectcatList reloadData];
        }

        
        [self CategoryListInformation:dicSearchList start:0 end:10];
        
        
    }
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [tblselectcatList reloadData];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
-(void)viewDidDisappear:(BOOL)animated
{
//    FromPostDetailPage = true;
    NSLog(@"%s",__PRETTY_FUNCTION__);
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
#pragma mark - Click Button Method
-(void)btnFavClicked:(UIButton *)btn
{
    btnFavClicked = true;
    NSLog(@"btn fav clicked %@",btn);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //    if ([[_dictSelectedWatchListDetail valueForKey:@"favorite"] isEqual:@"1"])
    if (btn.selected == true)
    {
        btn.selected = false;
        [btn setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
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
#pragma mark - PostDataTo server
-(void)postData:(int)tag status:(int)status
{
    NSLog(@"user id %d",_userID);
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;
        
        
        NSArray *array = [arrayAllDetail objectAtIndex:tag-1];
//
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        //        [dict setValue:[array valueForKey:@"user_id"] forKey:@"user_id"];
        
        if(array == nil)
        {
            [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
            
            if ([array valueForKey:@"post_id"] == nil) {
                [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
                
            }
            else{
                [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
            }
        }
        else
        {
            [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
            if ([array valueForKey:@"post_id"] == nil) {
                [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
                
            }
            else{
            [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
            }
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
-(void)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)btnSortingClicked:(id)sender
{
    NSLog(@"sorting");
    btnSortingClicked = true;
    
    if (!actionSheet)
    {
        actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Price - High to Low", @"Price - Low to High", @"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];

    }
    else
    {
        actionSheet.tapBtn = btnSelectedIndex+1;
        actionSheet = [actionSheet initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Price - High to Low", @"Price - Low to High", @"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];

    }
    
    
    [actionSheet showAlert];

}

-(void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld", (long)buttonIndex);
    
    btnSelectedIndex = (int)buttonIndex;
    
    if (buttonIndex == 0) {
        NSLog(@"price - High to low");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        
        NSArray *sortedArray = [arrayAllDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
        [tblselectcatList reloadData];

    }
    if (buttonIndex == 1) {
        
        NSLog(@"price - low to high");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayAllDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
        [tblselectcatList reloadData];

    }
    if (buttonIndex == 2) {
        
        NSLog(@"Expiry date - sooner to later");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayAllDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
        [tblselectcatList reloadData];

    }
    if (buttonIndex == 3) {
        NSLog(@"Expiry date - later to sooner");
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayAllDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
        [tblselectcatList reloadData];

    }



}

#pragma mark - WebService Method
- (void)refresh:(UIRefreshControl *)sender
{
    // ... your refresh code
    if([arrayAllDetail count]>0)
    {
        [arrayAllDetail removeAllObjects];
        
        isLoadingMore = NO;
    }
    [self CategoryListInformation:dicSearchList start:0 end:10];
}

-(void)CategoryListInformation:(NSDictionary*)dicParameter start:(int)st end:(int)ed
{
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        if (_clickedResendBtn == true) {
            if (st>=20) {
                [self loadMoreCompleted];
                return;
            }
        }
        if(ed<=10)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            self.navigationController.view.userInteractionEnabled = false;
             self.tabBarController.view.userInteractionEnabled = false;
        }
        if (_clickedResendBtn == false)
        {
            if(SelectCategory==0)
            {
                
                NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                dict = [dicParameter mutableCopy];
                //            [dict setValue:[NSString stringWithFormat:@"%d",_universityID] forKey:@"university_id"];
                //            [dict setValue:[NSString stringWithFormat:@"%@",_postCatID] forKey:@"search_text"];
                [dict setValue:[NSString stringWithFormat:@"%d",st] forKey:@"start"];
                [dict setValue:[NSString stringWithFormat:@"%d",ed] forKey:@"end"];
                NSLog(@"dict search paramter %@",dict);
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"searchList";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"search" withToken:YES];
            }
            else
            {
                NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",_universityID] forKey:@"university_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",_postCatID] forKey:@"post_cat_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",st] forKey:@"start"];
                [dict setValue:[NSString stringWithFormat:@"%d",ed] forKey:@"end"];
                NSLog(@"dict %@",dict);
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_list";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_list" withToken:YES];
            }
        }
        else if (_clickedResendBtn == true)
        {
            {
                NSLog(@"Resend btn clicked");

                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",_universityID] forKey:@"university_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",st] forKey:@"start"];
                [dict setValue:[NSString stringWithFormat:@"%d",ed] forKey:@"end"];

//                [dict setValue:@"30" forKey:@"user_id"];
//                [dict setValue:@"14" forKey:@"university_id"];
//                [dict setValue:@"0" forKey:@"start"];
//                [dict setValue:@"20" forKey:@"end"];
                
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"latest_post_list";
                [[ConnectionServer sharedConnectionWithDelegate:self]GetStartUp:dict caseName:@"latest_post_list" withToken:NO];
            }
        }
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"InternetAvailable", nil)];
        [self loadMoreCompleted];
    }
    
}

#pragma mark - UITableview method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayAllDetail.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%d",@"SelectCategorycell",(int)indexPath.row];
    
    SelectCategoryPostLIstTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        cell1 = [[SelectCategoryPostLIstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier];
        cell1.btnfav.tag = indexPath.row+1;
//        cell1.btnfav.selected = false;
        //
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 5)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:separatorLineView];
        
        UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-5, screenWidth, 5)];/// change size as you need.
        bottomline.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:bottomline];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        //  cell1.imgviewpost.tag = indexPath.row;
        cell1.imgviewpost.tag = indexPath.row;

        
    }
    
    //    cell1.imgviewpost.image = [UIImage imageWithData:[arrayPostImageList objectAtIndex:indexPath.row]];
    NSDictionary *dicPostObj = [arrayAllDetail objectAtIndex:indexPath.row];
    if (_clickedResendBtn == true) {
        cell1.lblTitle.text = [dicPostObj valueForKey:@"post_name"];

    }
    else
    {
        if(SelectCategory==0)
        {
            cell1.lblTitle.text = [dicPostObj valueForKey:@"title"];
        }
        else
        {
            cell1.lblTitle.text = [dicPostObj valueForKey:@"post_name"];
        }
    }
    //[arrayTitleList objectAtIndex:indexPath.row];
    
//    NSString *strexpiry = [self DateDisplayInCell:[dicPostObj valueForKey:@"expirydate"] index:indexPath.row];
    
        if ([[dicPostObj valueForKey:@"status"] isEqualToString:@"1"])
        {
            cell1.lblExpDate.text = @"Expired";
        }
        
        else if ([[dicPostObj valueForKey:@"status"] isEqualToString:@"2"])
        {
            cell1.lblExpDate.text = @"Closed";
        }
        else
        {
            NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[dicPostObj valueForKey:@"expirydate"]];
            cell1.lblExpDate.text = str;
        }

    
    
    if ([cell1.lblExpDate.text isEqualToString:@"Expired"] || [cell1.lblExpDate.text isEqualToString:@"Closed"]) {
        cell1.lblExpDate.textColor =[UIColor redColor];
        
    }
    else
    {
        cell1.lblExpDate.textColor = [UIColor blackColor];
        
    }

    
//    cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",[dicPostObj valueForKey:@"price"]];
    if([[dicPostObj valueForKey:@"price"] isEqualToString:@""])
    {
        cell1.lblPrice.text = @"";
    }
    else
    {
        cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",[dicPostObj valueForKey:@"price"]];
    }
    cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];
    
    
    NSString *strImage = [dicPostObj valueForKey:@"imagepathurl"];//[arrayPostImageList objectAtIndex:indexPath.row];
    
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

        id image = [LazyLoadingImage imageDataFromPath:cachePath];
        if(image)
        {
            cell1.imgviewpost.image = (UIImage*)image;
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     cell1.imgviewpost.image = [UIImage imageWithData:data];
                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     
                     
                 }
                 else
                 {
                     
                 }
             }];
        }
        
    }
    
    
    /*cell1.lblTitle.text = [arrayTitleList objectAtIndex:indexPath.row];
     NSString *str = [self DateDisplayInCell:[arrayExpDateList objectAtIndex:indexPath.row] index:indexPath.row];
     cell1.lblExpDate.text = str;
     cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",[arrayPriceList objectAtIndex:indexPath.row]];*/
    
    cell1.btnfav.hidden = true;
    if(SelectCategory!=0 || _clickedResendBtn == true)
    {
        cell1.btnfav.hidden = false;
        [cell1.btnfav addTarget:self action:@selector(btnFavClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell1.btnfav setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        
        {
            if (btnFavClicked == false)
            {
                NSString *str = [[arrayAllDetail valueForKey:@"favorite"] objectAtIndex:indexPath.row];
                NSLog(@"str %@",str);
                
                if([str isKindOfClass:[NSNull class]])
                {
                    str = @"0";
                }
                
                if ([str isEqualToString:@"1"]) {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
                    cell1.btnfav.selected = true;
                }
                else
                {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
                    cell1.btnfav.selected = false;
                    
                }
            }
            else
            {
                if (cell1.btnfav.selected == false)
                {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
                }
                else
                {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
                }

            }
        }
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
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        FromPostDetailPage = false;
        if (_clickedResendBtn == true) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            //    [dict setValue:arrayExpDateList forKey:@"Expdate"];
            [dict setValue:[arrayPostImageList objectAtIndex:indexPath.row] forKey:@"ImageList"];
            //    [dict setValue:arrayPriceList forKey:@"PriceList"];
            //    [dict setValue:arrayTitleList forKey:@"TitleList"];
            
            if (btnFavClicked == true)
            {
                for(NSMutableDictionary *dict in arrayAllDetail)
                {
                    int idUser = [[[arrayAllDetail objectAtIndex:indexPath.row] valueForKey:@"post_id"] intValue];
                    
                    if([[dict objectForKey:@"post_id"]integerValue]== idUser)
                    {
                        //                    if ([[dict valueForKey:@"favorite"]isEqualToString:@"0"])
                        
                        NSString *str = [dict valueForKey:@"favorite"];
                        
                        if ([str isKindOfClass:[NSNull class]])
                        {
                            str = @"0";
                        }
                        
                        if ([str isEqualToString:@"0"])
                        {
                            [dict setObject:@"1" forKey:@"favorite"];
                        }
                        else
                        {
                            [dict setObject:@"0" forKey:@"favorite"];
                            
                        }
                    }
                }
                
            }
            
            [dict setValue:[arrayAllDetail objectAtIndex:indexPath.row] forKey:@"ResponseAllDetail"];
            
            //    SelectCategoryPostDetailViewController *
            selectDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostDetailViewController"];
            selectDetailObj.dictDetail = dict;
            selectDetailObj.strNavigationTitle = @"POST DETAIL";
            selectDetailObj.userID = _userID;
            selectDetailObj.strUserName = _strUserName;
            selectDetailObj.postCatID=_postCatID;
            selectDetailObj.universityID=_universityID;
            [self.navigationController pushViewController:selectDetailObj animated:YES];

            
        }
        else
        {
            
            if(SelectCategory==1)
            {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                //    [dict setValue:arrayExpDateList forKey:@"Expdate"];
                [dict setValue:[arrayPostImageList objectAtIndex:indexPath.row] forKey:@"ImageList"];
                //    [dict setValue:arrayPriceList forKey:@"PriceList"];
                //    [dict setValue:arrayTitleList forKey:@"TitleList"];
                
                if (btnFavClicked == true)
                {
                    for(NSMutableDictionary *dict in arrayAllDetail)
                    {
                        int idUser = [[[arrayAllDetail objectAtIndex:indexPath.row] valueForKey:@"post_id"] intValue];
                        
                        if([[dict objectForKey:@"post_id"]integerValue]== idUser)
                        {
                            //                    if ([[dict valueForKey:@"favorite"]isEqualToString:@"0"])
                            
                            NSString *str = [dict valueForKey:@"favorite"];
                            
                            if ([str isKindOfClass:[NSNull class]])
                            {
                                str = @"0";
                            }
                            
                            if ([str isEqualToString:@"0"])
                            {
                                [dict setObject:@"1" forKey:@"favorite"];
                            }
                            else
                            {
                                [dict setObject:@"0" forKey:@"favorite"];
                                
                            }
                        }
                    }
                    
                }
                
                [dict setValue:[arrayAllDetail objectAtIndex:indexPath.row] forKey:@"ResponseAllDetail"];
                
                //    SelectCategoryPostDetailViewController *
                selectDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostDetailViewController"];
                selectDetailObj.dictDetail = dict;
                selectDetailObj.strNavigationTitle = _strSelectedCategoryName;
                selectDetailObj.userID = _userID;
                selectDetailObj.strUserName = _strUserName;
                selectDetailObj.universityID=_universityID;
                selectDetailObj.postCatID=_postCatID;
                [self.navigationController pushViewController:selectDetailObj animated:YES];
            }
            else
            {
                if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
                    NSDictionary *dicSearchListObj = [arrayAllDetail objectAtIndex:indexPath.row];
                    
                    NSString *strListType = [dicSearchListObj valueForKey:@"type"];
                    
                    if([strListType isEqualToString:@"CB"])
                    {
                        if ([[dicSearchListObj valueForKey:@"user_id"] intValue] == [GlobalMethod shareGlobalMethod].userID)
                        {
                            MyPostDetailViewController *mypostDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostDetailViewController"];
                            mypostDetailObj.dictPostDetail = [dicSearchListObj mutableCopy];
                            mypostDetailObj.strTitleName = @"BUZZ DETAILS";
                            [self.navigationController pushViewController:mypostDetailObj animated:YES];
                            
                        }
                        else
                        {
                            BuzzDetailViewController *buzzDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"BuzzDetailViewController"];
                            // buzzDetailObj.buzzId = [[[arrayAllBuzzListDetail valueForKey:@"buzz_id"] objectAtIndex:indexPath.row] intValue];
                            buzzDetailObj.dicBuzzDetail = dicSearchListObj;
                            buzzDetailObj.strTitleName = @"BUZZ DETAILS";
                            [self.navigationController pushViewController:buzzDetailObj animated:YES];
                        }
                    }
                    else if ([strListType isEqualToString:@"PM"])
                    {
                        if ([[dicSearchListObj valueForKey:@"user_id"] intValue] == [GlobalMethod shareGlobalMethod].userID)
                        {
                            MyPostDetailViewController *mypostDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostDetailViewController"];
                            mypostDetailObj.dictPostDetail = [dicSearchListObj mutableCopy];
                            mypostDetailObj.strTitleName = @"POST DETAILS";
                            [self.navigationController pushViewController:mypostDetailObj animated:YES];
                            
                        }
                        else
                        {
                            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                            [dict setValue:[arrayPostImageList objectAtIndex:indexPath.row] forKey:@"ImageList"];
                            [dict setValue:[arrayAllDetail objectAtIndex:indexPath.row] forKey:@"ResponseAllDetail"];
                            
                            //    SelectCategoryPostDetailViewController *
                            selectDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostDetailViewController"];
                            selectDetailObj.dictDetail = dict;
                            selectDetailObj.strNavigationTitle = @"POST DETAILS";
                            selectDetailObj.userID = _userID;
                            selectDetailObj.strUserName = _strUserName;
                            selectDetailObj.postCatID=_postCatID;
                            selectDetailObj.universityID=_universityID;
                            [self.navigationController pushViewController:selectDetailObj animated:YES];
                        }
                        
                    }
                    else if ([strListType isEqualToString:@"CD"])
                    {
                        DealDetailViewController *dealdetailObj= [self.storyboard instantiateViewControllerWithIdentifier:@"DealDetailViewController"];
                        dealdetailObj.dicDealDetail = [dicSearchListObj mutableCopy];
                        dealdetailObj.strTitleName = @"DEAL DETAIL";
                        [self.navigationController pushViewController:dealdetailObj animated:YES];
                    }
                }
                else
                {
                    [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
                    
                }
            }
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

    }

}
#pragma mark - Load More method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView                                              // any offset changes

{
    if (!isLoadingMore) {
        CGFloat scrollPosition = ([arrayAllDetail count]*cellHeight)  - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight] && ([arrayAllDetail count]*cellHeight)>=[self footerLoadMoreHeight]) {
            
            
            NSLog(@"load more");
            [self loadMore];
        }
    }
}
- (CGFloat) footerLoadMoreHeight
{
    return (tblselectcatList.frame.size.height-DEFAULT_HEIGHT_OFFSET);
}
- (BOOL) loadMore
{
    if (isLoadingMore)
        return NO;
    
    [self willBeginLoadingMore];
    isLoadingMore = YES;
    //  [self loadMoreCompleted];
    return YES;
}
- (void) willBeginLoadingMore
{
    tblselectcatList.tableFooterView = footerHud;
    [footerHud startAnimating];
    
    if(SelectCategory==1)
    {
        [self CategoryListInformation:nil start:(int)[arrayAllDetail count] end:10];
    }
    else
    {
        [self CategoryListInformation:dicSearchList start:(int)[arrayAllDetail count] end:10];
        
    }
}
- (void) loadMoreCompleted
{
    
    tblselectcatList.tableFooterView = nil;
    [footerHud stopAnimating];
    isLoadingMore = NO;
    [tblselectcatList reloadData];
    
    
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

    
    [tblselectcatList layoutIfNeeded];
    [refreshControl endRefreshing];
    dictCatpostList = (NSMutableDictionary*)arrData;
    if([dictCatpostList isKindOfClass:[NSMutableDictionary class]])
    {
        int statuscode = [[[dictCatpostList valueForKey:@"Response"] valueForKey:@"status"] intValue];
        
        
        if (strstatuscode == 500) {
            [self.view makeToast:@"Internal server error"];
        }
        if (statuscode == 200)
        {
            if ([nState isEqualToString:@"post_list"])
            {
                [self loadListDetail:dictCatpostList];
            }
            if ([nState isEqualToString:@"latest_post_list"])
            {
                [self loadListDetail:dictCatpostList];
            }

        }
        else if (statuscode == 201)
        {
            if ([nState isEqualToString:@"searchList"])
            {
                [self loadListDetail:dictCatpostList];
            }
            
        }
        
        else if (statuscode == 404)
        {
            lblNoList.hidden = NO;
        }
        else if (statuscode == 401)
        {
            
        }
        else if (statuscode == 400)
        {
        }
        
        else if (statuscode == 500)
        {
        }
        if(statuscode != 200)
        {
            self.navigationController.view.userInteractionEnabled = true;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self loadMoreCompleted];
            if (statuscode == 4041)
            {
                isLoadingMore = YES;
            }
            else if (statuscode == 204)
            {
//                [self viewWillAppear:YES];
                if (favBtnStatus == 1)
                    
                {
                    [self.view makeToast:NSLocalizedString(@"Favorite_button_click_add", nil)];
                    
                }
                else
                {
                    [self.view makeToast:NSLocalizedString(@"Favorite_button_click_remove", nil)];
                    
                }
                
            }
        }
        
    }
    else
    {
        self.navigationController.view.userInteractionEnabled = true;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self loadMoreCompleted];
    }
}

- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;
{
    self.tabBarController.view.userInteractionEnabled = true;

    self.navigationController.view.userInteractionEnabled = true;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    [tblselectcatList layoutIfNeeded];
    [refreshControl endRefreshing];
    NSLog(@"nstate %@",nState);
    
    
}
-(void)loadListDetail:(id)detail
{
    NSLog(@"dictUniversityList %@",detail);
    NSString *strImagePath=@"";
    if (_clickedResendBtn == true)
    {
        arrayTitleList = [[[detail valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"post_name"];
        strImagePath = [[detail valueForKey:@"Response"] valueForKey:@"imagepath"];

    }
    else
    {
        if(SelectCategory == 0)
        {
            arrayTitleList = [[[detail valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"title"];
            strImagePath = [[detail valueForKey:@"Response"] valueForKey:@"URL"];
            
        }
        else
        {
            arrayTitleList = [[[detail valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"post_name"];
            strImagePath = [[detail valueForKey:@"Response"] valueForKey:@"imagepath"];
            
        }
    }
    arrayExpDateList = [[[detail valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"expirydate"];
    arrayPriceList = [[[detail valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"price"];
    // arrayAllDetail = [[dictCatpostList valueForKey:@"Response"] valueForKey:@"Details"];
    NSArray *arrayImage = [[[detail valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
    
    id allData = [[detail valueForKey:@"Response"] valueForKey:@"Details"];
    if([allData isKindOfClass:[NSMutableArray class]])
    {
        if(!arrayAllDetail)
        {
            arrayAllDetail=[[NSMutableArray alloc]init];
        }
        NSArray *allPostDetail = (NSArray*)allData;
        for (int i = 0; i < allPostDetail.count; i++) {
            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
            NSString *strImage=@"";
            
            if (_clickedResendBtn == true)
            {
                strImage= [NSString stringWithFormat:@"%@%@",strImagePath,[arrayImage objectAtIndex:i]];
            }
            else
            {
                
                if(SelectCategory == 0)
                {
                    strImage= [NSString stringWithFormat:@"%@%@%@",strImagePath,[objPostDic valueForKey:@"imagepath"],[arrayImage objectAtIndex:i]];
                }
                else
                {
                    strImage= [NSString stringWithFormat:@"%@%@",strImagePath,[arrayImage objectAtIndex:i]];
                    
                }
            }
            [objPostDic setValue:strImage forKey:@"imagepathurl"];
            [arrayAllDetail addObject:objPostDic];
        }
    }
    
    for (int i = 0; i < arrayImage.count; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%@%@",strImagePath,[arrayImage objectAtIndex:i]];
        if (!arrayPostImageList) {
            arrayPostImageList = [[NSMutableArray alloc]init];
        }
        [arrayPostImageList addObject:str];
        //
    }
    
    if (btnSortingClicked == true) {
        if (btnSelectedIndex == 0) {
            NSLog(@"price - High to low");
            
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO selector:@selector(localizedStandardCompare:)];
            NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
            
            NSArray *sortedArray = [arrayAllDetail mutableCopy];
            NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
            arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
            
        }
        if (btnSelectedIndex == 1) {
            
            NSLog(@"price - low to high");
            
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES selector:@selector(localizedStandardCompare:)];
            NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
            NSArray *sortedArray = [arrayAllDetail mutableCopy];
            NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
            arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
            
        }
        if (btnSelectedIndex == 2) {
            
            NSLog(@"Expiry date - sooner to later");
            
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
            NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
            NSArray *sortedArray = [arrayAllDetail mutableCopy];
            NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
            arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
            
        }
        if (btnSelectedIndex == 3) {
            NSLog(@"Expiry date - later to sooner");
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
            NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
            NSArray *sortedArray = [arrayAllDetail mutableCopy];
            NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
            arrayAllDetail = [NSMutableArray arrayWithArray:sArray];
            
        }
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:arrayPostImageList forKey:@"PostImageList"];
    [defaults setValue:arrayTitleList forKey:@"TitleList"];
    [defaults setValue:arrayExpDateList forKey:@"ExpDateList"];
    [defaults setValue:arrayPriceList forKey:@"PriceList"];
    //            [defaults setValue:arrayAllDetail forKey:@"ResponseAllDetail"];
    [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:arrayAllDetail] forKey:@"ResponseAllDetail"];
    
    [defaults synchronize];
    self.navigationController.view.userInteractionEnabled = true;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self loadMoreCompleted];
    if([arrayAllDetail count]>0)
    {
        lblNoList.hidden = YES;
    }
    else
    {
        lblNoList.hidden = NO;
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
