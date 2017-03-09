//
//  MessagesViewController.m
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "MessagesViewController.h"
#import "SelectCategoryPostLIstTableViewCell.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"



@interface MessagesViewController ()

@end

@implementation MessagesViewController
@synthesize SelectMsgType;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:NavigationTitleColor,NSForegroundColorAttributeName ,
      FontRegular,NSFontAttributeName,nil]];
    [[UINavigationBar appearance]setBackgroundColor:NavigationBarBgColor];

    
    self.navigationItem.hidesBackButton = YES;
    if(SelectMsgType==0)
    {
        self.navigationItem.title = NSLocalizedString(@"Notifications", nil);
    }
    else
    {
        self.navigationItem.title = NSLocalizedString(@"Messages", nil);
        
        //Notification  Button

        UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
        btnright.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
        [btnright setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
        [btnright setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
        btnright.frame = CGRectMake(0,1, 35, 20.0);
        
        [btnright addTarget:self action:@selector(btnBellClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *btnRightBellView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 35, 22)];
//        btnRightBellView.backgroundColor = [UIColor redColor];
        btnRightBellView.bounds = CGRectOffset(btnRightBellView.bounds, 0,0);
        [btnRightBellView addSubview:btnright];
        UIBarButtonItem *bellBtn = [[UIBarButtonItem alloc]initWithCustomView:btnRightBellView];
//        self.navigationItem.rightBarButtonItem = bellBtn;
        
        //Delete Button
        
// ///       UIButton *
        btndelete = [UIButton buttonWithType:UIButtonTypeCustom];
        btndelete.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
        [btndelete setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
        [btndelete setTitle:[NSString fontAwesomeIconStringForEnum:FACheckSquareO] forState:UIControlStateNormal];
        btndelete.frame = CGRectMake(0,1, 35, 20.0);
        [btndelete addTarget:self action:@selector(btnDeleteClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *btnDeleteView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 35, 22)];
//        btnDeleteView.backgroundColor = [UIColor blueColor];

        btnDeleteView.bounds = CGRectOffset(btnDeleteView.bounds, 0,0);
        [btnDeleteView addSubview:btndelete];
        UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc]initWithCustomView:btnDeleteView];
        self.navigationItem.rightBarButtonItems = @[bellBtn,deleteBtn];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0
                                         target:self
                                       selector:@selector(incrementBadge:)
                                       userInfo:nil
                                        repeats:YES];


    }

    
    
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
    
    tblMessagesView.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;
    tblMessagesView.showsVerticalScrollIndicator = false;
    
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
    
    if(SelectMsgType==0)
    {
        tblMessagesView.tableFooterView = nil;
        lblNoList.text =  NSLocalizedString(@"Blank_my_notification_list", nil);
    }
    else
    {
        footerHud = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        footerHud.tag = 10;
        
        footerHud.frame = CGRectMake(0, 0.0,44.0, 44.0);
        
        footerHud.hidesWhenStopped = YES;
        
        tblMessagesView.tableFooterView = footerHud;
        lblNoList.text =  NSLocalizedString(@"Blank_my_message_list", nil);
    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

}

-(void)viewWillAppear:(BOOL)animated
{
    isDeleteBtnClicked = false;
    tempArray = nil;
    [btndelete setTitle:[NSString fontAwesomeIconStringForEnum:FACheckSquareO] forState:UIControlStateNormal];

    lblNoList.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    if(SelectMsgType==0)
    {
        self.tabBarController.tabBar.hidden = true;
    }
    else
    {
        self.tabBarController.tabBar.hidden = false;
        
    }
    
//    UIViewController *fromViewController = [[[self navigationController] transitionCoordinator] viewControllerForKey:UITransitionContextFromViewControllerKey];
    
//    if ([[self.navigationController viewControllers] containsObject:fromViewController])
    {
        isLoadingMore = NO;
        if([_arraymsgList count]>0)
        {
            [_arraymsgList removeAllObjects];
            [tblMessagesView reloadData];
        }
        [self MessageListInformation:0 end:10];
    }
//    else
//    {
//        if (_arraymsgList.count<1) {
//            lblNoList.hidden = NO;
//            
//        }
//        
//    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    tblMessagesView.contentOffset = CGPointMake(0, 0);
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


-(void)btnDeleteClicked
{
    NSLog(@"Delete btn clicked");

    if (isDeleteBtnClicked == false)
    {
        isDeleteBtnClicked = true;
        NSLog(@"isDeleteBtnClicked = true;");
        [btndelete setTitle:[NSString fontAwesomeIconStringForEnum:FAtrash] forState:UIControlStateNormal];
        
        for (int i =0 ; i<_arraymsgList.count; i++)
        {
            for(NSMutableDictionary *dict in _arraymsgList)
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
            
            if (!checkmarkArray) {
                checkmarkArray = [[NSMutableArray alloc]init];
//                    checkmarkArray = [_arraymsgList valueForKey:@"thread_id"];
            }
            if (checkmarkArray.count<1) {
                
                [self.view makeToast:@"Please select any one message"];
            }
            else
            {
                
                self.navigationController.view.userInteractionEnabled = false;
                self.tabBarController.view.userInteractionEnabled = false;
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];

            NSLog(@"array %@",checkmarkArray);
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:checkmarkArray forKey:@"thread_id"];
            [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_id"];

            NSLog(@"dict %@",dict);
            
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName =@"delete_thread";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"delete_thread" withToken:NO];
            for (int i =0 ; i<_arraymsgList.count; i++)
            {
                for(NSMutableDictionary *dict in _arraymsgList)
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
    
    [tblMessagesView reloadData];
    
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
            tempArray = [_arraymsgList mutableCopy];

            
        }

        NSLog(@"tempArray %@",tempArray);
        //    NSArray *array = [[_arraymsgList valueForKey:@"thread_id"] objectAtIndex:btn.tag];
        int threadValue = [[[_arraymsgList valueForKey:@"thread_id"] objectAtIndex:btn.tag] intValue];//[[[_arraymsgList objectAtIndex:btn.tag] valueForKey:@"thread_id"] intValue];
        
        //    int index = [tempArray indexOfObject:[NSString stringWithFormat:@"%d",threadValue]];
        int index = (int)[[tempArray valueForKey:@"thread_id"] indexOfObject:[NSString stringWithFormat:@"%d",threadValue]];
        
        [tempArray removeObjectAtIndex:index];
    }
    else
    {
//        checkmarkSelected = true;
        
        if (!checkmarkArray) {
            checkmarkArray = [[NSMutableArray alloc]init];
        }
        
        if (!tempArray) {
            tempArray = [[NSMutableArray alloc]init];
        }

        btn.selected = true;
//        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateNormal];
        
        if (![[tempArray valueForKey:@"post_id"] containsObject:[[_arraymsgList objectAtIndex:btn.tag] valueForKey:@"post_id"]]) // YES
        {
            // Do something
            NSLog(@"not in temp array");
            [tempArray addObject:[_arraymsgList objectAtIndex:btn.tag]];
        }
    }
    
//    NSMutableArray *checkmarkArray = [_arraymsgList mutableCopy];
//    if (checkmarkArray.count>1) {
//        [checkmarkArray removeAllObjects];
//    }
    checkmarkArray = [tempArray valueForKey:@"thread_id"];

    for(NSMutableDictionary *dict in _arraymsgList)
    {
        int idUser;
        if ([[_arraymsgList objectAtIndex:btn.tag] valueForKey:@"post_id"]) {
            idUser = [[[_arraymsgList objectAtIndex:btn.tag] valueForKey:@"post_id"] intValue];
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
        
    }

    NSLog(@"checkmarkArray %@",checkmarkArray);

}


#pragma mark - UITableview method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arraymsgList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%d",@"SelectCategorycell",(int)indexPath.row];
    
    SelectCategoryPostLIstTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    UIView* separatorLineView;
    if (cell1 == nil) {
        cell1 = [[SelectCategoryPostLIstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier];

//        cell1.btnfav.hidden =YES;
        
        UIView*separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 5)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1 addSubview:separatorLineView];
        
        UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-5, screenWidth, 5)];/// change size as you need.
        bottomline.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1 addSubview:bottomline];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
//        cell1.lblTitle.frame = CGRectMake(80, 13, screenWidth-(80+20), 36);
        
        
        
    }

//    if (isDeleteBtnClicked == true)
//    {
//        UIButton *btnCheckmark = [[UIButton alloc]initWithFrame:CGRectMake(cell1.frame.size.width - 50, 5, 40.0, 40.0)];
//        [btnCheckmark setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateNormal];
//        [btnCheckmark addTarget:self action:@selector(btnCheckmarkClicked:) forControlEvents:UIControlEventTouchUpInside];
//        checkmarkSelected = true;
//        btnCheckmark.tag = indexPath.row;
//        btnCheckmark.backgroundColor = [UIColor redColor];
//        [cell1 addSubview:btnCheckmark];
//    }
    NSDictionary *dicPost = [_arraymsgList objectAtIndex:indexPath.row];

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
            cell1.btnfav.enabled = true;

        }
        else
        {
            //        [cell1.btnfav setTitle:@"" forState:UIControlStateNormal];
            [cell1.btnfav setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
            cell1.btnfav.enabled = true;
            cell1.btnfav.selected  = false;
            [cell1.btnfav addTarget:self action:@selector(btnCheckmarkClicked:) forControlEvents:UIControlEventTouchUpInside];


            //        [cell1.btnfav setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
        }
    }
    else
        
    {
        [cell1.btnfav setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        cell1.btnfav.enabled = false;
    }


//    UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 5)];/// change size as you need.
//    separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
//    [cell1 addSubview:separatorLineView];
//    
//    UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-5, screenWidth, 5)];/// change size as you need.
//    bottomline.backgroundColor = tableBackgroundColor;// you can also put image here
//    [cell1 addSubview:bottomline];


    //  cell1.imgviewpost.image = nil;
    
    NSString *strImage = [[_arraymsgList valueForKey:@"imagepathurl"] objectAtIndex:indexPath.row];
    cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];
    
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
    
    
    //    cell1.lblTitle.font = FontRegular16;.
    //    NSString *str = [[GlobalMethod shareGlobalMethod] ExpiredDateDisplayWithMonthName:[[_arraymsgList valueForKey:@"create_date"] objectAtIndex:indexPath.row]];
    
    
    if(SelectMsgType==1)
    {
        if ([[[_arraymsgList valueForKey:@"user_id"] objectAtIndex:indexPath.row] intValue] == [GlobalMethod shareGlobalMethod].userID)
        {
            if ([[[_arraymsgList valueForKey:@"from_status"] objectAtIndex:indexPath.row] isEqualToString:@"1"])
            {
                cell1.lblTitle.textColor = txtFieldTextColor;
            }
            else
            {
                cell1.lblTitle.textColor = NavigationBarBgColor ;
            }
        }
        else
        {
            if ([[[_arraymsgList valueForKey:@"read_status"] objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
                cell1.lblTitle.textColor = txtFieldTextColor;
            }
            else
            {
                cell1.lblTitle.textColor = NavigationBarBgColor ;
            }
        }
        cell1.lblTitle.text = [[_arraymsgList valueForKey:@"post_name"] objectAtIndex:indexPath.row];
        cell1.lblPrice.hidden = NO;
        cell1.lblExpDate.hidden = NO;
        NSString *str = [self displayDateInCell:[[_arraymsgList valueForKey:@"create_date"] objectAtIndex:indexPath.row]];
        cell1.lblExpDate.text = str;
        cell1.lblExpDate.font = FontRegular14;
        NSString *strName = [[_arraymsgList valueForKey:@"user_name"] objectAtIndex:indexPath.row];
        cell1.lblPrice.text = [NSString stringWithFormat:@"~%@",strName];
        cell1.lblPrice.font = FontRegular14;
    }
    else
    {
        cell1.lblPrice.hidden = YES;
        cell1.lblExpDate.hidden = YES;
        cell1.lblTitle.font = FontRegular16;
        
        NSString *notificationType = [[_arraymsgList valueForKey:@"notification_type"] objectAtIndex:indexPath.row];
        NSDictionary *dicNotification = [_arraymsgList objectAtIndex:indexPath.row];
        
        if([notificationType isEqualToString:@"0"])
        {
            cell1.lblTitle.text = [NSString stringWithFormat:NSLocalizedString(@"NewMsg", nil),[dicNotification valueForKey:@"user_name"]];
        }
        else if([notificationType isEqualToString:@"1"])
        {
            cell1.lblTitle.text = [NSString stringWithFormat:NSLocalizedString(@"blockExpired", nil),[NSString stringWithFormat:@"post"],[dicNotification valueForKey:@"name"]];
        }
        else if([notificationType isEqualToString:@"2"])
        {
            cell1.lblTitle.text = [NSString stringWithFormat:NSLocalizedString(@"block", nil),[NSString stringWithFormat:@"post"],[dicNotification valueForKey:@"name"]];
        }
        else if([notificationType isEqualToString:@"3"])
        {
            cell1.lblTitle.text = [NSString stringWithFormat:NSLocalizedString(@"blockExpired", nil),[NSString stringWithFormat:@"buzz"],[dicNotification valueForKey:@"buzz_name"]];
        }
        else if([notificationType isEqualToString:@"4"])
        {
            cell1.lblTitle.text = [NSString stringWithFormat:NSLocalizedString(@"block", nil),[NSString stringWithFormat:@"post"],[dicNotification valueForKey:@"name"]];
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
    if(SelectMsgType==1)
    {
        MessageDetailViewController *msgDetailViewObj =[self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
//        NSString *strOwnerName = [[_arraymsgList valueForKey:@"owner_name"] objectAtIndex:indexPath.row];
        msgDetailViewObj.strPostName =  [NSString stringWithFormat:@"%@",[[_arraymsgList valueForKey:@"post_name"] objectAtIndex:indexPath.row]];
         msgDetailViewObj.readID = [[[_arraymsgList valueForKey:@"user_id"] objectAtIndex:indexPath.row] intValue];
        msgDetailViewObj.threadID = [[[_arraymsgList valueForKey:@"thread_id"] objectAtIndex:indexPath.row] intValue];
        msgDetailViewObj.postID = [[[_arraymsgList valueForKey:@"post_id"] objectAtIndex:indexPath.row] intValue];
        msgDetailViewObj.FromReplyBtn = false;
        msgDetailViewObj.arrayFromMsgViewList = [_arraymsgList objectAtIndex:indexPath.row];
        msgDetailViewObj.IsFromMsgList = true;
        //msgDetailViewObj.strUserName =  _strUserName;
        [self.navigationController pushViewController:msgDetailViewObj animated:YES];
    }
    else
    {
        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber-1;
        
        NSString *notificationType = [[_arraymsgList valueForKey:@"notification_type"] objectAtIndex:indexPath.row];
        
        NSDictionary *dicNotification = [_arraymsgList objectAtIndex:indexPath.row];
        if([notificationType isEqualToString:@"0"])
        {
            MessageDetailViewController *msgDetailViewObj =[self.storyboard instantiateViewControllerWithIdentifier:@"MessageDetailViewController"];
            msgDetailViewObj.strPostName = [[_arraymsgList valueForKey:@"post_name"] objectAtIndex:indexPath.row];
            msgDetailViewObj.readID = [[[_arraymsgList valueForKey:@"user_id"] objectAtIndex:indexPath.row] intValue];
//             msgDetailViewObj.userID = _userId;
            msgDetailViewObj.threadID = [[[_arraymsgList valueForKey:@"thread_id"] objectAtIndex:indexPath.row] intValue];
            msgDetailViewObj.postID = [[[_arraymsgList valueForKey:@"post_id"] objectAtIndex:indexPath.row] intValue];
            msgDetailViewObj.IsFromMsgList = false;
            // msgDetailViewObj.strUserName =  _strUserName;
            msgDetailViewObj.arrayFromMsgViewList = [_arraymsgList objectAtIndex:indexPath.row];

            [self.navigationController pushViewController:msgDetailViewObj animated:YES];
        }
        else //if([notificationType isEqualToString:@"1"] || [notificationType isEqualToString:@"2"])
        {
            MyPostDetailViewController *mypostDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostDetailViewController"];
            mypostDetailObj.dictPostDetail = [dicNotification mutableCopy];
            
            [self.navigationController pushViewController:mypostDetailObj animated:YES];
        }
//        else if([notificationType isEqualToString:@"3"] || [notificationType isEqualToString:@"4"])
//        {
//            BuzzDetailViewController *buzzDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"BuzzDetailViewController"];
//            // buzzDetailObj.buzzId = [[[arrayAllBuzzListDetail valueForKey:@"buzz_id"] objectAtIndex:indexPath.row] intValue];
//            buzzDetailObj.dicBuzzDetail = [dicNotification mutableCopy];
//            buzzDetailObj.strTitleName = @"BUZZ DETAIL";
//
//            [self.navigationController pushViewController:buzzDetailObj animated:YES];
//        }
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(SelectMsgType==0)
    {
        return  UITableViewCellEditingStyleNone;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    if(SelectMsgType==1)
    {
        NSArray *array  = [_arraymsgList objectAtIndex:indexPath.row];
        NSLog(@"array %@",array);
        
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
             NSMutableArray *arraydict = [[NSMutableArray alloc]init];
            [arraydict addObject:[array valueForKey:@"thread_id"]];
            
             NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:arraydict forKey:@"thread_id"];
            [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_id"];
            
            NSLog(@" delete_thread dict ==> %@",dict);
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName =@"delete_thread";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"delete_thread" withToken:NO];
            
            indexRow = (int)indexPath.row;
            
        }
        else
        {
            [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
            
        }
    }
}


#pragma mark - Load More method

-(void)MessageListInformation:(int)st end:(int)ed
{
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {

        if(ed<=10)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
        }
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue: [NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
        
        if(SelectMsgType==0)
        {
            NSLog(@"message view (thread list) _notification_dict ==> %@",dict);

            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"notification";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"notification" withToken:NO];
        }
        else
        {
            [dict setValue:[NSString stringWithFormat:@"%d",st] forKey:@"start"];
            [dict setValue:[NSString stringWithFormat:@"%d",ed] forKey:@"end"];
            
            NSLog(@"message view (thread list)get_threadlist_dict ==> %@",dict);

            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"get_threadlist";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"get_threadlist" withToken:NO];
        }
    }
    else
    {
        [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
        if(SelectMsgType==1)
        {
            [self loadMoreCompleted];
        }
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView

{
    if (!isLoadingMore && SelectMsgType==1)
    {
        CGFloat scrollPosition = ([_arraymsgList count]*cellHeight)  - scrollView.contentOffset.y;
        if (scrollPosition < [self footerLoadMoreHeight] && ([_arraymsgList count]*cellHeight)>=[self footerLoadMoreHeight]) {
            
            
            NSLog(@"load more");
            
            [self loadMore];
        }
    }
}
- (CGFloat) footerLoadMoreHeight
{
    return (tblMessagesView.frame.size.height-DEFAULT_HEIGHT_OFFSET);
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
    tblMessagesView.tableFooterView = footerHud;
    [footerHud startAnimating];
    [self MessageListInformation:(int)[_arraymsgList count] end:(int)[_arraymsgList count]+10];
}
- (void) loadMoreCompleted
{
    
    tblMessagesView.tableFooterView = nil;
    [footerHud stopAnimating];
    isLoadingMore = NO;
    [tblMessagesView reloadData];
    
    
}

#pragma mark -
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    id arrData = [nData JSONValue];
    NSLog(@"message view (thread list) respone ==> %@",arrData);
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    int statuscode = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (statuscode == 200)
    {
        if ([nState isEqualToString:@"get_threadlist"] || [nState isEqualToString:@"notification"])
        {
            
            if([arrData isKindOfClass:[NSMutableDictionary class]])
            {
                NSMutableDictionary *dicMsgList = (NSMutableDictionary*)arrData;
                NSString *strImagepath=@"";
                
                if([[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath_post"])
                {
                    strImagepath = [[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath_post"];
                    
                }
                if([[dicMsgList valueForKey:@"Response"] valueForKey:@"Result_message"])
                {
                    id allData = [[dicMsgList valueForKey:@"Response"] valueForKey:@"Result_message"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if (!_arraymsgList) {
                            _arraymsgList = [[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicMsgList valueForKey:@"Response"] valueForKey:@"Result_message"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [_arraymsgList addObject:objPostDic];
                        }
                    }
                    //Sorting result message
                    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"create_date" ascending:NO selector:@selector(localizedStandardCompare:)];
                    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                    NSArray *sortedArray = [_arraymsgList mutableCopy];
                    NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                    _arraymsgList = [NSMutableArray arrayWithArray:sArray];

                    //
                }
                if([[dicMsgList valueForKey:@"Response"] valueForKey:@"Details"])
                {
                    if([[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath"])
                    {
                        strImagepath = [[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath"];
                        
                    }
                    id allData = [[dicMsgList valueForKey:@"Response"] valueForKey:@"Details"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if (!_arraymsgList) {
                            _arraymsgList = [[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicMsgList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [_arraymsgList addObject:objPostDic];
                        }
                    }
                    
                    //Sorting result message
                    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"create_date" ascending:NO selector:@selector(localizedStandardCompare:)];
                    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                    NSArray *sortedArray = [_arraymsgList mutableCopy];
                    NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                    _arraymsgList = [NSMutableArray arrayWithArray:sArray];
                    
                    //

                }
                if([[dicMsgList valueForKey:@"Response"] valueForKey:@"Details_post"])
                {
                    if([[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath_post"])
                    {
                        strImagepath = [[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath_post"];
                        
                    }
                    id allData = [[dicMsgList valueForKey:@"Response"] valueForKey:@"Details_post"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if (!_arraymsgList) {
                            _arraymsgList = [[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicMsgList valueForKey:@"Response"] valueForKey:@"Details_post"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [_arraymsgList addObject:objPostDic];
                        }
                    }
                    
                    //Sorting result message
                    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"create_date" ascending:NO selector:@selector(localizedStandardCompare:)];
                    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                    NSArray *sortedArray = [_arraymsgList mutableCopy];
                    NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                    _arraymsgList = [NSMutableArray arrayWithArray:sArray];
                    
                    //

                }
                if([[dicMsgList valueForKey:@"Response"] valueForKey:@"Details_buzz"])
                {
                    if([[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath_buzz"])
                    {
                        strImagepath = [[dicMsgList valueForKey:@"Response"] valueForKey:@"imagepath_buzz"];
                        
                    }
                    id allData = [[dicMsgList valueForKey:@"Response"] valueForKey:@"Details_buzz"];
                    if([allData isKindOfClass:[NSMutableArray class]])
                    {
                        if (!_arraymsgList) {
                            _arraymsgList = [[NSMutableArray alloc]init];
                        }
                        NSArray *allPostDetail = (NSArray*)allData;
                        NSArray *arrayImage2 = [[[dicMsgList valueForKey:@"Response"] valueForKey:@"Details_buzz"] valueForKey:@"image"];
                        for (int i = 0; i < allPostDetail.count; i++) {
                            NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                            NSString *strImage=@"";
                            strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                            [objPostDic setValue:strImage forKey:@"imagepathurl"];
                            [_arraymsgList addObject:objPostDic];
                        }
                    }
                    //Sorting result message
                    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"create_date" ascending:NO selector:@selector(localizedStandardCompare:)];
                    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
                    NSArray *sortedArray = [_arraymsgList mutableCopy];
                    NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors];
                    _arraymsgList = [NSMutableArray arrayWithArray:sArray];
                    
                    //

                }
                
            }
            
//            tempArray = nil;
//            checkmarkArray = nil;

            for (int i =0 ; i<_arraymsgList.count; i++)
            {
                for(NSMutableDictionary *dict in _arraymsgList)
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

            if(SelectMsgType==1)
            {
                [self loadMoreCompleted];
            }
            else
            {
                [tblMessagesView reloadData];
            }
            if (_arraymsgList.count<1) {
                lblNoList.hidden = NO;
                
            }
            else
            {
                lblNoList.hidden = YES;
            }

        }
        
        if ([nState isEqualToString:@"delete_thread"]) {
            [self.view makeToast:@"Successfully deleted."];
            
            
//            [_arraymsgList removeObjectAtIndex:indexRow];
            if (_arraymsgList.count<1) {
                lblNoList.hidden = NO;
            }
            else
            {
                lblNoList.hidden = YES;
            }
            if([_arraymsgList count]>0)
            {
                [_arraymsgList removeAllObjects];
            }
            if (checkmarkArray.count>0) {
                checkmarkArray = nil;
            }
            [self MessageListInformation:0 end:10];


        }
    }
    if(statuscode != 200)
    {
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(SelectMsgType==1)
        {
            [self loadMoreCompleted];
            if(statuscode == 4041)
            {
                isLoadingMore = YES;
            }
        }
        if(statuscode == 404)
        {
            lblNoList.hidden = NO;
        }
    }
}

-(void)ConnectionDidFail:(NSString *)nState Data:(NSString *)nData{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    HideNetworkActivityIndicator();
    [self.view makeToast:@"Internal Server Error"];


}

-(NSString *)displayDateInCell:(NSString*)createDate
{
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
    [dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate =  [dateformate dateFromString:createDate];
    
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd"];
        endDate =  [dateformate dateFromString:createDate];
    }
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        endDate =  [dateformate dateFromString:createDate];
    }
    
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    format1.dateFormat = @"LLLL dd, yy";
    NSString *str;
    str = [format1 stringFromDate:endDate];
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
