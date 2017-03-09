//
//  BuzzViewController.m
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "BuzzViewController.h"
#import "CreateCampusBuzzViewController.h"
#import "SelectCategoryPostLIstTableViewCell.h"
#import "BuzzDetailViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"

@interface BuzzViewController ()

@end

@implementation BuzzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //LeftSide Button
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
    btnAdd.frame = CGRectMake(0, 0, 15.0, 30.0);
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAdd setTitle:[NSString fontAwesomeIconStringForEnum:FAPlus] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(btnAddClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20.0, 30.0)];
    viewAdd.bounds = CGRectOffset(viewAdd.bounds, 0, 0);
    [viewAdd addSubview:btnAdd];
    UIBarButtonItem *barleftside = [[UIBarButtonItem alloc]initWithCustomView:viewAdd];
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
//    self.navigationItem.rightBarButtonItem = barBell;
//    self.navigationItem.rightBarButtonItem.badgeValue = @"5";
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(incrementBadge:)
                                   userInfo:nil
                                    repeats:YES];

    
    tblBuzzList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tblBuzzList.showsVerticalScrollIndicator = false;
    IsFromBuzzDetailPage = false;
    tblBuzzList.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;
    

    
    footerHud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    footerHud.tag = 10;
    
    footerHud.frame = CGRectMake(0, 0.0,44.0, 44.0);
    
    footerHud.hidesWhenStopped = YES;
    
    tblBuzzList.tableFooterView = footerHud;
    
    if (!lblNoList) {
        lblNoList = [[UILabel alloc]init];
    }
    lblNoList.frame = CGRectMake(10, (self.view.frame.size.height-104)/2, screenWidth-20, 40);
    lblNoList.text =  NSLocalizedString(@"Blank_buzz_list", nil);
    lblNoList.numberOfLines = 2;
    lblNoList.font = FontRegular;
    lblNoList.textColor = txtFieldTextColor;
    lblNoList.textAlignment = NSTextAlignmentCenter;
    lblNoList.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:lblNoList];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];

}


-(void)viewWillAppear:(BOOL)animated
{
//    btnSortingClicked = false;
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = false;

    self.navigationItem.title = @"CAMPUS BUZZ";
    lblNoList.hidden = YES;

    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        
        if (IsFromBuzzDetailPage == false)
        {
            if (arrayAllBuzzListDetail.count>0) {
                [arrayAllBuzzListDetail removeAllObjects];
            }

            isLoadingMore = NO;
            [self BuzzListInformation:0 end:10];
        }
        else
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            arrayBuzzImageList = [defaults valueForKey:@"BuzzImageList"];
            NSData *data = [defaults objectForKey:@"ResponseBuzzList"];
            arrayAllBuzzListDetail = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            if (arrayAllBuzzListDetail.count<1) {
                lblNoList.hidden = NO;
                
            }
            
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }

    
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"tab bar tag %ld",(long)self.tabBarController.selectedIndex);
    
    [tblBuzzList reloadData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"tab bar tag %ld",(long)self.tabBarController.selectedIndex);
    
    if (self.tabBarController.selectedIndex != 4) {
        IsFromBuzzDetailPage = false;
        arrayBuzzImageList = nil;
        arrayAllBuzzListDetail = nil;
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
    
    if (self.tabBarController.selectedIndex == 4)
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

#pragma mark - UITableview method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayAllBuzzListDetail.count;
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
    cell1.imgviewpost.tag = indexPath.row;
    cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];

    NSString *strImage = [[arrayAllBuzzListDetail valueForKey:@"imagepathurl"] objectAtIndex:indexPath.row];
    
    if (![strImage hasSuffix:@"<null>"])
    {
        NSURL *url = [NSURL URLWithString:strImage];
        NSString *cacheFilename = [url lastPathComponent];
        
        int index = (int)([url pathComponents].count)-3;
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

    cell1.lblTitle.text = [[arrayAllBuzzListDetail valueForKey:@"buzz_name"] objectAtIndex:indexPath.row];
//    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[[arrayAllBuzzListDetail valueForKey:@"expirydate"] objectAtIndex:indexPath.row]];
    NSString *str = [self DateDisplayInCell:[[arrayAllBuzzListDetail valueForKey:@"expirydate"] objectAtIndex:indexPath.row]];

    if ([str isEqualToString:@"Expired"]) {
        cell1.lblExpDate.textColor = [UIColor redColor];
    }
    else
    {
        cell1.lblExpDate.textColor = [UIColor blackColor];
    }
    cell1.lblExpDate.text = str;
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
        BuzzDetailViewController *buzzDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"BuzzDetailViewController"];
        IsFromBuzzDetailPage = false;
        // buzzDetailObj.buzzId = [[[arrayAllBuzzListDetail valueForKey:@"buzz_id"] objectAtIndex:indexPath.row] intValue];
        buzzDetailObj.dicBuzzDetail = [arrayAllBuzzListDetail objectAtIndex:indexPath.row];
        buzzDetailObj.strTitleName = @"BUZZ DETAIL";
        // buzzDetailObj.userId = _userID;
        
        if (arrayAllBuzzListDetail.count>0) {
            [arrayAllBuzzListDetail removeAllObjects];
        }
        [tblBuzzList reloadData];
        [self.navigationController pushViewController:buzzDetailObj animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
}

#pragma mark - navigation button method

-(void)btnAddClicked
{
    IsFromBuzzDetailPage = false;
    CreateCampusBuzzViewController *createcampusbuzzObj = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateCampusBuzzViewController"];
    createcampusbuzzObj.userID = _userID;
    createcampusbuzzObj.universityID = _universityID;
    [self.navigationController pushViewController:createcampusbuzzObj animated:YES];
}

-(void)btnBellClicked:(id)sender
{
    IsFromBuzzDetailPage = true;
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];

}
-(void)btnSortingClicked:(id)sender
{
    btnSortingClicked = true;
    
    if (!actionSheet) {
        actionSheet.tapBtn = _btnSelectedIndex;
        actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];
        
    }
    else
    {
        actionSheet.tapBtn = _btnSelectedIndex+1;
        actionSheet = [actionSheet initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];
        
    }
    
    
    [actionSheet showAlert];
    

}

-(void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld", (long)buttonIndex);
    
    _btnSelectedIndex = (int)buttonIndex;
    
    if (buttonIndex == 0) {
        
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayAllBuzzListDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllBuzzListDetail = [NSMutableArray arrayWithArray:sArray];
        [tblBuzzList reloadData];
        
    }
    if (buttonIndex == 1) {
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayAllBuzzListDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllBuzzListDetail = [NSMutableArray arrayWithArray:sArray];
        [tblBuzzList reloadData];
        
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
    format1.dateFormat = @"EEEE, LLLL dd";
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
        str = [NSString stringWithFormat:@"%@",dateStr];
    }
    return str;
    
    
}
#pragma mark - WebService Method


-(void)BuzzListInformation:(int)st end:(int)ed
{
    NSLog(@"loading start %d and End %d",st,ed);

    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        if(ed<=10)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
        }
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",_universityID] forKey:@"university_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",st] forKey:@"start"];
        [dict setValue:[NSString stringWithFormat:@"%d",ed] forKey:@"end"];
        
        
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"campus_buzz_list";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"campus_buzz_list" withToken:NO];
    }
    else
    {
        [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        [self loadMoreCompleted];
    }
    
}
#pragma mark - Load More method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    if (!isLoadingMore) {
        CGFloat scrollPosition = ([arrayAllBuzzListDetail count]*cellHeight)  - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight] && ([arrayAllBuzzListDetail count]*cellHeight)>=[self footerLoadMoreHeight]) {
            
            
            [self loadMore];
        }
    }
}
- (CGFloat) footerLoadMoreHeight
{
    return (tblBuzzList.frame.size.height-DEFAULT_HEIGHT_OFFSET);
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
    tblBuzzList.tableFooterView = footerHud;
    [footerHud startAnimating];
//    [self BuzzListInformation:(int)[arrayAllBuzzListDetail count] end:(int)[arrayAllBuzzListDetail count]+10];
    [self BuzzListInformation:(int)[arrayAllBuzzListDetail count] end:10];
    
}
- (void) loadMoreCompleted
{
    
    tblBuzzList.tableFooterView = nil;
    [footerHud stopAnimating];
    isLoadingMore = NO;
    
   
    [tblBuzzList reloadData];
    
}

#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    int statuscode = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    if (statuscode == 200)
    {
        if ([nState isEqualToString:@"campus_buzz_list"])
        {
//            if(arrayAllBuzzListDetail.count>0)
//            {
//                [arrayAllBuzzListDetail removeAllObjects];
//            }
            
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                
                NSMutableDictionary *dicBuzzList = (NSMutableDictionary*)arrData;
                NSString *strImagepath=@"";
                if([[dicBuzzList valueForKey:@"Response"] valueForKey:@"imagepath"])
                {
                    strImagepath = [[dicBuzzList valueForKey:@"Response"] valueForKey:@"imagepath"];
                    
                }
                if([[dicBuzzList valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    id allData = [[dicBuzzList valueForKey:@"Response"] valueForKey:@"Details"];
                    
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if(!arrayAllBuzzListDetail)
                        {
                            arrayAllBuzzListDetail=[[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        
                        NSArray *arrayImage2 = [[[dicBuzzList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
                        
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [arrayAllBuzzListDetail addObject:objPostDic];
                        }
                    }
                    
                }
                
                
                NSArray *arrayImage = [[[dicBuzzList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
                
                for (int i = 0; i < arrayImage.count; i++) {
                    
                    NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage objectAtIndex:i]];
                    if (!arrayBuzzImageList) {
                        arrayBuzzImageList = [[NSMutableArray alloc]init];
                    }
                    [arrayBuzzImageList addObject:str];
                    
                }
                
                
                if (btnSortingClicked == true)
                {
                    NSLog(@"sorting clicked");
                    if (_btnSelectedIndex == 0) {
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayAllBuzzListDetail mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayAllBuzzListDetail = [NSMutableArray arrayWithArray:sArray];

                    }
                    else if (_btnSelectedIndex ==1)
                    {
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayAllBuzzListDetail mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayAllBuzzListDetail = [NSMutableArray arrayWithArray:sArray];
                    }
                }

                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:arrayBuzzImageList forKey:@"BuzzImageList"];
                [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:arrayAllBuzzListDetail] forKey:@"ResponseBuzzList"];
                
                
                [defaults synchronize];
                
                
                self.navigationController.view.userInteractionEnabled = true;
                self.tabBarController.view.userInteractionEnabled = true;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self loadMoreCompleted];
                
                if (arrayAllBuzzListDetail.count<1) {
                    lblNoList.hidden = NO;
                    
                }
                else
                {
                    lblNoList.hidden = YES;
                }
            }
            
        }
    }
    else if (statuscode == 201)
    {
        
        
    }
    
    else if (statuscode == 404)
    {
        
        if (arrayAllBuzzListDetail.count<1) {
            lblNoList.hidden = NO;
        }
        
    }
    else if (statuscode == 401)
    {
        
        
    }
    else if (statuscode == 400)
    {
        [self.view makeToast:@"Bad Request."];
    }
    
    if(statuscode != 200)
    {
        
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
