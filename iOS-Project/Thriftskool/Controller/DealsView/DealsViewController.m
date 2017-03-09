//
//  DetailsViewController.m
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "DealsViewController.h"
#import "DealDetailViewController.h"
#import "SelectCategoryPostLIstTableViewCell.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"



@interface DealsViewController ()

@end

@implementation DealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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


    IsFromDealsDetailsview = false;
    tblDealList.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;

    
    footerHud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    footerHud.tag = 10;
    
    footerHud.frame = CGRectMake(0, 0.0,44.0, 44.0);
    
    footerHud.hidesWhenStopped = YES;
    
    tblDealList.tableFooterView = footerHud;
    
    if (!lblNoList) {
        lblNoList = [[UILabel alloc]init];
    }
    lblNoList.frame = CGRectMake(10, (self.view.frame.size.height-104)/2, screenWidth-20, 40);
    lblNoList.text =  NSLocalizedString(@"Blank_deal_list", nil);
    lblNoList.numberOfLines = 2;
    lblNoList.font = FontRegular;
    lblNoList.textColor = txtFieldTextColor;
    lblNoList.textAlignment = NSTextAlignmentCenter;
    lblNoList.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:lblNoList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(incrementBadge:)
                                   userInfo:nil
                                    repeats:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = false;

    self.navigationItem.title = @"CAMPUS DEALS";
    
    
        lblNoList.hidden = YES;
        
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            if (IsFromDealsDetailsview == false)
            {
                if (arrayAllDealDetail.count>0) {
                    [arrayAllDealDetail removeAllObjects];
                }
                isLoadingMore = NO;
                [self DealListInformation:0 end:10];
            }
            else
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                arrayDealImageslist =  [defaults valueForKey:@"DealImageList"];
                //        arrayAllDealDetail =  [defaults valueForKey:@"AllDealDetail"];
                NSData *data = [defaults objectForKey:@"AllDealDetail"];
                arrayAllDealDetail = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                
                if (arrayAllDealDetail.count<1) {
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
    [tblDealList reloadData];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(void)viewDidDisappear:(BOOL)animated
{
//    if (self.tabBarController.selectedIndex != 3) {
//        IsFromDealsDetailsview = false;
//    }
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

    if (self.tabBarController.selectedIndex == 3)
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
#pragma mark - UITableview deleagte

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arrayName = [arrayAllDealDetail valueForKey:@"deal_name"];
    return arrayName.count;
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
    
    cell1.imgviewpost.image = nil;
    cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];

    NSString *strImage = [[arrayAllDealDetail valueForKey:@"imagepathurl"] objectAtIndex:indexPath.row];
    
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
    
    
    cell1.lblTitle.text = [[arrayAllDealDetail valueForKey:@"deal_name"] objectAtIndex:indexPath.row];
    NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[[arrayAllDealDetail valueForKey:@"expirydate"] objectAtIndex:indexPath.row]];
    cell1.lblExpDate.text = str;
    if ([cell1.lblExpDate.text isEqualToString:@"Expired"]) {
        cell1.lblExpDate.textColor =[UIColor redColor];
        
    }
    else
    {
        cell1.lblExpDate.textColor = [UIColor blackColor];
        
    }

    return cell1;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        IsFromDealsDetailsview = true;
        DealDetailViewController *dealdetailObj= [self.storyboard instantiateViewControllerWithIdentifier:@"DealDetailViewController"];
        dealdetailObj.dicDealDetail = [arrayAllDealDetail  objectAtIndex:indexPath.row];
        dealdetailObj.strTitleName = @"DEAL DETAIL";
        [self.navigationController pushViewController:dealdetailObj animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
}
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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

#pragma mark - WebService Method


-(void)DealListInformation:(int)st end:(int)ed
{
    NSLog(@"deal list start %d and end %d",st,ed);
    
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
        
        
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"campus_deal_list";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"campus_deal_list" withToken:NO];
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
        CGFloat scrollPosition = ([arrayAllDealDetail count]*cellHeight)  - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight] && ([arrayAllDealDetail count]*cellHeight)>=[self footerLoadMoreHeight]) {
            
            
            NSLog(@"load more");
            [self loadMore];
        }
    }
}
- (CGFloat) footerLoadMoreHeight
{
    return (tblDealList.frame.size.height-DEFAULT_HEIGHT_OFFSET);
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
    tblDealList.tableFooterView = footerHud;
    [footerHud startAnimating];
    [self DealListInformation:(int)[arrayAllDealDetail count] end:10];
}
- (void) loadMoreCompleted
{
    
    tblDealList.tableFooterView = nil;
    [footerHud stopAnimating];
    isLoadingMore = NO;
    [tblDealList reloadData];
    
    
}

#pragma mark - Connection Delegate
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    id arrData = [nData JSONValue];
    
    
    int statuscode = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    if (statuscode == 200)
    {
        if ([nState isEqualToString:@"campus_deal_list"])
        {
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                
                NSMutableDictionary *dicdealList = (NSMutableDictionary*)arrData;
                NSString *strImagepath=@"";
                if([[dicdealList valueForKey:@"Response"] valueForKey:@"imagepath"])
                {
                    strImagepath = [[dicdealList valueForKey:@"Response"] valueForKey:@"imagepath"];
                    
                }
                if([[dicdealList valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    id allData = [[dicdealList valueForKey:@"Response"] valueForKey:@"Details"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if(!arrayAllDealDetail)
                        {
                            arrayAllDealDetail=[[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
//                        NSArray *arrayImage2 = [[[dicdealList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
                        NSArray *arrayImage2 = [allPostDetail valueForKey:@"image"];

                        
                        for (int i = 0; i < allPostDetail.count; i++)
                        {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [arrayAllDealDetail addObject:objPostDic];
                        }
                    }
                    
                }
                
                NSArray *arrayImage = [arrayAllDealDetail valueForKey:@"image"];
                
                
                for (int i = 0; i < arrayImage.count; i++) {
                    
                    NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage objectAtIndex:i]];
                    if (!arrayDealImageslist) {
                        arrayDealImageslist = [[NSMutableArray alloc]init];
                    }
                    [arrayDealImageslist addObject:str];
                }
                
                if (btnSortingClicked == true)
                {
                    if (btnSelectedIndex == 0)
                    {
                        
                        NSLog(@"Expiry date - sooner to later");
                        
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayAllDealDetail mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayAllDealDetail = [NSMutableArray arrayWithArray:sArray];
                        
                    }
                    if (btnSelectedIndex == 1)
                    {
                        NSLog(@"Expiry date - later to sooner");
                        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
                        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                        NSArray *sortedArray = [arrayAllDealDetail mutableCopy];
                        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                        arrayAllDealDetail = [NSMutableArray arrayWithArray:sArray];
                        
                    }
                }

                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setValue:arrayDealImageslist forKey:@"DealImageList"];
                [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:arrayAllDealDetail] forKey:@"AllDealDetail"];
                [defaults synchronize];
                
                self.navigationController.view.userInteractionEnabled = true;
                self.tabBarController.view.userInteractionEnabled = true;
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self loadMoreCompleted];
                
                if (arrayAllDealDetail.count<1) {
                    lblNoList.hidden = NO;
                    
                }
                else
                {
                    lblNoList.hidden = YES;
                    
                }
            }
        }
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
        if (statuscode == 404) {
            lblNoList.hidden = NO;
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

#pragma mark - UIButton method
-(void)btnBellClicked:(id)sender
{
    NSLog(@"bell clicked");
    IsFromDealsDetailsview = true;
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];

}
-(void)btnSortingClicked:(id)sender
{
    btnSortingClicked = true;

    NSLog(@"sorting");
    
    if (!actionSheet) {
        actionSheet = [[CustomActionSheet alloc] initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];
        
    }
    else
    {
        actionSheet.tapBtn = btnSelectedIndex+1;
        actionSheet = [actionSheet initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Expiry Date - Sooner to Later",@"Expiry Date - Later to Sooner", nil];
        
    }
    
    
    [actionSheet showAlert];

}

-(void)modalAlertPressed:(CustomActionSheet *)alert withButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld", (long)buttonIndex);
    
    btnSelectedIndex = (int)buttonIndex;
    
       if (buttonIndex == 0) {
        
        NSLog(@"Expiry date - sooner to later");
        
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:YES selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayAllDealDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllDealDetail = [NSMutableArray arrayWithArray:sArray];
        [tblDealList reloadData];
        
    }
    if (buttonIndex == 1) {
        NSLog(@"Expiry date - later to sooner");
        NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expirydate" ascending:NO selector:@selector(localizedStandardCompare:)];
        NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
        NSArray *sortedArray = [arrayAllDealDetail mutableCopy];
        NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
        arrayAllDealDetail = [NSMutableArray arrayWithArray:sArray];
        [tblDealList reloadData];
        
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
