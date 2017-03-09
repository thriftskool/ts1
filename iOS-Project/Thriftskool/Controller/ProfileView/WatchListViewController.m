//
//  WatchListViewController.m
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "WatchListViewController.h"
#import "SelectCategoryPostLIstTableViewCell.h"
#import "WatchListDetailViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"



@interface WatchListViewController ()

@end

@implementation WatchListViewController
@synthesize watchdetailObj;

- (void)viewDidLoad {

    [super viewDidLoad];
    appDelegate.tabviewControllerObj.profileObj.watchlistobj = self;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"WATCH LIST";
    
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
    btnsort.frame = CGRectMake(0,1, 20.0, 20.0);
    [btnsort addTarget:self action:@selector(btnSortingClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnSortView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 20, 22)];
    btnSortView.bounds = CGRectOffset(btnSortView.bounds, 0,0);
    [btnSortView addSubview:btnsort];
    UIBarButtonItem *sortBtn = [[UIBarButtonItem alloc]initWithCustomView:btnSortView];
    
    self.navigationItem.rightBarButtonItems = @[bellBtn,sortBtn];
    
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
    
    
    tblWatchList.showsVerticalScrollIndicator = false;

    tblWatchList.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;

    IsFromWatchDetailPage = false;
    lblNoList.hidden = YES;
    footerHud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    footerHud.tag = 10;
    
    footerHud.frame = CGRectMake(0, 0.0,44.0, 44.0);
    
    footerHud.hidesWhenStopped = YES;
    
    tblWatchList.tableFooterView = footerHud;
    
    
    
    if (!lblNoList) {
        lblNoList = [[UILabel alloc]init];
    }
    lblNoList.frame = CGRectMake(10, (self.view.frame.size.height-104)/2, screenWidth-20, 40);
    lblNoList.text = NSLocalizedString(@"Blank_watch_list", nil);
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
    btnFavClicked  = false;
    lblNoList.hidden = YES;

    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    if (IsFromWatchDetailPage == false)
    {
        if (arrayMain.count>0) {
            [arrayMain removeAllObjects];
        }
        isLoadingMore = NO;
        [self WatchListInformation:0 end:10];
    }
    else
    {
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        arrayMain =  [defaults valueForKey:@"allWatchListDetails"];
        arrayAllImages = [defaults valueForKey:@"watchListImages"];
        
        
        if (arrayMain.count<1)
        {
            lblNoList.hidden = NO;
        }

    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [tblWatchList reloadData];
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
-(void)btnFavClicked:(UIButton *)btn
{
    btnFavClicked = true;

    btnFavTag = (int)btn.tag;
    NSLog(@"btn fav clicked %@",btn);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //    if ([[_dictSelectedWatchListDetail valueForKey:@"favorite"] isEqual:@"1"])
    if (btn.selected == true)
    {
        btn.selected = false;
        [btn setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
        [self postData:(int)btn.tag status:0];
    }
    else
    {
        btn.selected = true;
        [btn setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
        [self postData:(int)btn.tag status:1];
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
        
        
        NSArray *array = [arrayMain objectAtIndex:tag];
        //
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        //        [dict setValue:[array valueForKey:@"user_id"] forKey:@"user_id"];
        
        if(array != nil)
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
            [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
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
-(void)btnBellClicked
{
 
    IsFromWatchDetailPage = true;
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

-(void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld", (long)buttonIndex);
    
    btnSelectedIndex = (int)buttonIndex;
    
    if (buttonIndex == 0) {
        NSLog(@"price - High to low");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        
        NSArray *sortedArray = [arrayMain mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMain = [NSMutableArray arrayWithArray:sArray];
        NSLog(@"sortedArray %@",arrayMain);
        [tblWatchList reloadData];
        
    }
    if (buttonIndex == 1)
    {
        NSLog(@"price - low to high");

        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayMain mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMain = [NSMutableArray arrayWithArray:sArray];
        NSLog(@"sortedArray %@",arrayMain);
        [tblWatchList reloadData];
        
    }
    if (buttonIndex == 2) {
        
        NSLog(@"Expiry date - sooner to later");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayMain mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMain = [NSMutableArray arrayWithArray:sArray];
        NSLog(@"sortedArray %@",arrayMain);
        [tblWatchList reloadData];
        
    }
    if (buttonIndex == 3) {
        NSLog(@"Expiry date - later to sooner");
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayMain mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayMain = [NSMutableArray arrayWithArray:sArray];
        NSLog(@"sortedArray %@",arrayMain);
        [tblWatchList reloadData];
    }
    
    
    
}

#pragma mark - Load More method
-(void)WatchListInformation:(int)st end:(int)ed
{
    lblNoList.hidden = YES;
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        if(ed<=10)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
        }
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
        [dict setObject:@"1" forKey:@"chr_fav"];
        [dict setValue:[NSString stringWithFormat:@"%d",st] forKey:@"start"];
        [dict setValue:[NSString stringWithFormat:@"%d",ed] forKey:@"end"];
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"favorite_list";
        [[ConnectionServer sharedConnectionWithDelegate:self]GetStartUp:dict caseName:@"favorite_list" withToken:NO];
    }
    else
    {
        [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        [self loadMoreCompleted];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    if (!isLoadingMore) {
        CGFloat scrollPosition = ([arrayMain count]*cellHeight)  - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight] && ([arrayMain count]*cellHeight)>=[self footerLoadMoreHeight]) {
            
            
            NSLog(@"load more");
            [self loadMore];
        }
    }
}
- (CGFloat) footerLoadMoreHeight
{
    return (tblWatchList.frame.size.height-DEFAULT_HEIGHT_OFFSET);
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
    tblWatchList.tableFooterView = footerHud;
    [footerHud startAnimating];
    [self WatchListInformation:(int)[arrayMain count] end:(int)[arrayMain count]+10];
}
- (void) loadMoreCompleted
{
    
    tblWatchList.tableFooterView = nil;
    [footerHud stopAnimating];
    isLoadingMore = NO;
    [tblWatchList reloadData];
    
    
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
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    int statuscode = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (statuscode == 200)
    {
        if ([nState isEqualToString:@"favorite_list"])
        {
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                NSMutableDictionary *dicWatchList = (NSMutableDictionary*)arrData;
                NSString *strImagepath=@"";
                if([[dicWatchList valueForKey:@"Response"] valueForKey:@"imagepath"])
                {
                    strImagepath = [[dicWatchList valueForKey:@"Response"] valueForKey:@"imagepath"];
                    
                }
                else if ([[dicWatchList valueForKey:@"Response"] valueForKey:@"buzz_imagepath"])
                {
                    strImagepath = [[dicWatchList valueForKey:@"Response"] valueForKey:@"buzz_imagepath"];
                    
                }
                if([[dicWatchList valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    id allData = [[dicWatchList valueForKey:@"Response"] valueForKey:@"Details"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if(!arrayMain)
                        {
                            arrayMain=[[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicWatchList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [arrayMain addObject:objPostDic];
                        }
                    }
                    
                }
                if([[dicWatchList valueForKey:@"Response"] valueForKey:@"Details_buzz"])
                {
                    id allData = [[dicWatchList valueForKey:@"Response"] valueForKey:@"Details_buzz"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if(!arrayMain)
                        {
                            arrayMain=[[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicWatchList valueForKey:@"Response"] valueForKey:@"Details_buzz"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [arrayMain addObject:objPostDic];
                        }
                    }
                    
                }
                if(!arrayAllImages)
                {
                    arrayAllImages = [[NSMutableArray alloc]init];
                }
                
                NSArray *arrayImage = [arrayMain valueForKey:@"image"];
                
                for (int i = 0; i < arrayImage.count; i++) {
                    NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage objectAtIndex:i]];
                    [arrayAllImages addObject:str];
                }
                
                
                if (btnSortingClicked == true) {
                    if (btnSelectedIndex == 0) {
                        NSLog(@"price - High to low");
                        
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        
                        NSArray *sortedArray = [arrayMain mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMain = [NSMutableArray arrayWithArray:sArray];
                        NSLog(@"sortedArray %@",arrayMain);
                        [tblWatchList reloadData];
                        
                    }
                    if (btnSelectedIndex == 1) {
                        
                        NSLog(@"price - low to high");
                        
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayMain mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMain = [NSMutableArray arrayWithArray:sArray];
                        NSLog(@"sortedArray %@",arrayMain);
                        
                    }
                    if (btnSelectedIndex == 2) {
                        
                        NSLog(@"Expiry date - sooner to later");
                        
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayMain mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMain = [NSMutableArray arrayWithArray:sArray];
                        NSLog(@"sortedArray %@",arrayMain);
                        
                    }
                    if (btnSelectedIndex == 3) {
                        NSLog(@"Expiry date - later to sooner");
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayMain mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayMain = [NSMutableArray arrayWithArray:sArray];
                        NSLog(@"sortedArray %@",arrayMain);
                        
                    }
                    
                }
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setValue:arrayMain forKey:@"allWatchListDetails"];
                [defaults setValue:arrayAllImages forKey:@"watchListImages"];
                [defaults synchronize];
                
                
                self.navigationController.view.userInteractionEnabled = true;
                self.tabBarController.view.userInteractionEnabled = true;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self loadMoreCompleted];
                
                 lblNoList.hidden = YES;
                if (arrayMain.count<1)
                {
                    lblNoList.hidden = NO;
                    
                }
            }
        }
        
    }
    else if (statuscode == 204)
    {
        [self.view makeToast:NSLocalizedString(@"Favorite_button_click_remove", nil)];
        
        [arrayMain removeObjectAtIndex:btnFavTag];
        [tblWatchList reloadData];
        
    }
    
    else if (statuscode == 404)
    {
        if (arrayMain.count<1)
        {
            lblNoList.hidden = NO;
            
        }
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
    NSLog(@"nstate %@",nState);
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
    return arrayMain.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%d",@"SelectCategorycell",(int)indexPath.row];
    
    SelectCategoryPostLIstTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[SelectCategoryPostLIstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier];
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 5)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:separatorLineView];
        
        UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-5, screenWidth, 5)];/// change size as you need.
        bottomline.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:bottomline];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    
    NSDictionary *dicWatch = [arrayMain objectAtIndex:indexPath.row];
    
    cell1.lblTitle.text =  [dicWatch valueForKey:@"post_name"];
    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[dicWatch valueForKey:@"expirydate"]];
    cell1.lblExpDate.text = str;
    
    NSString *strPrice = [dicWatch valueForKey:@"price"];
    NSRange range = [strPrice rangeOfString:@"$"];
    if (range.location == NSNotFound) {
        cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",strPrice];
    }
    else
    {
        cell1.lblPrice.text = [NSString stringWithFormat:@"%@",strPrice];
        
    }
    
    cell1.imgviewpost.image = nil;
    cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];

    NSString *strImage = [[arrayMain valueForKey:@"imagepathurl"] objectAtIndex:indexPath.row];
    
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
    else
    {
        cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];
    }
    
    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
    [cell1.btnfav addTarget:self action:@selector(btnFavClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell1.btnfav.selected = true;
    cell1.btnfav.tag = indexPath.row;
    
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
        
        IsFromWatchDetailPage = false;
        //    WatchListDetailViewController *
        watchdetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"WatchListDetailViewController"];
        watchdetailObj.dictSelectedWatchListDetail = [arrayMain objectAtIndex:indexPath.row];
        watchdetailObj.userID = _userID;
        watchdetailObj.strUserName = _strUserName;
        watchdetailObj.btnfavSelected = true;
        
        if (arrayMain.count>0) {
            [arrayMain removeAllObjects];
        }
        [tblWatchList reloadData];
        [self.navigationController pushViewController:watchdetailObj animated:YES];
    }
    else
    {
        //        [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        UILabel *alertMessage =  [alert.subviews objectAtIndex:1];
        alertMessage.textColor = [UIColor redColor];
        [alert show];
        
    }

}
#pragma mark -
- (NSString*)DateDisplayInCell:(NSString*)strDate str:(NSString*)buzzstr
{
    //current Date -------------
    
    NSDate *startDate = [NSDate date];
    NSLog(@"%@", startDate); // 2014-02-20 11:36:20 +0000
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSCalendar *calendar123 = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalendar.calendarIdentifier];
    calendar123.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* components123 = [calendar123 components:flags fromDate:startDate];
    startDate = [calendar123 dateFromComponents:components123];
    NSLog(@"startDate %@", startDate); // 2014-02-20 00:00:00 +0000
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-LLL-yy";
    NSLog(@"%@", [format stringFromDate:startDate]);
    
    
    //End Date -------------
    
    
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
    [dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //    if ([buzzstr isEqualToString:@"buzz"])
    //    {
    //         [dateformate setDateFormat:@"yyyy-MM-dd"];
    //    }
    //    else{
    [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //    }
    NSDate *endDate =  [dateformate dateFromString:strDate];
    
    
    NSLog(@"strDate %@",strDate);
    NSLog(@"endDate %@",endDate);
    NSLog(@"startdate %@",startDate);
    
    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    format1.dateFormat = @"dd-LLL-yyyy";
    NSLog(@"%@", [format1 stringFromDate:endDate]);
    
    NSDateComponents *components;
    NSInteger days;
    
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: startDate toDate: endDate options: 0];
    days = [components day];
    
    
    NSString *str;
    if (days < 0 ) {
        str = [NSString stringWithFormat:@"Expired" ];
    }
    else{
        str = [NSString stringWithFormat:@"Exp.in %ld Days",(long)days];
    }
    return str;
    
    
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
