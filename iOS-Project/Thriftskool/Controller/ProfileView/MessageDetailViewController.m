//
//  MessageDetailViewController.m
//  Thriftskool
//
//  Created by Asha on 25/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailCellTableViewCell.h"
#import "SelectCategoryPostDetailViewController.h"
#import "MyPostDetailViewController.h"


@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController
@synthesize FromNextPage;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;

    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:NavigationTitleColor,NSForegroundColorAttributeName,
      FontRegular,NSFontAttributeName,nil]];
    [[UINavigationBar appearance]setBackgroundColor:NavigationBarBgColor];

    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"MESSAGES DETAIL";
    self.navigationController.navigationBar.hidden = NO;
    
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
    self.navigationItem.rightBarButtonItem = bellBtn;
    
    //LeftSide Button
    UIButton *btnleftside = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleftside.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btnleftside.frame = CGRectMake(0, 0, 30.0, 50.0);
    [btnleftside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleftside setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [btnleftside addTarget:self action:@selector(btnBackBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewleftside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30.0, 50.0)];
    viewleftside.bounds = CGRectOffset(viewleftside.bounds, 0, 0);
    [viewleftside addSubview:btnleftside];
    UIBarButtonItem *barleftside = [[UIBarButtonItem alloc]initWithCustomView:viewleftside];
    self.navigationItem.leftBarButtonItem = barleftside;

    lblPostName.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    lblPostName.textColor = [UIColor whiteColor];
    lblPostName.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openDetailPage)];
    [lblPostName addGestureRecognizer:tap];
    
    
    btnSend.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
    [btnSend setTitleColor:[UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btnSend setTitle:[NSString fontAwesomeIconStringForEnum:FApaperPlane] forState:UIControlStateNormal];
    
    [tblviewMsgDetail setSeparatorColor:[UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0]];

    tblviewMsgDetail.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    btnSend.hidden = YES;
    strSectionName = @"Test";
    FromNextPage = false;
    
    if (_IsFromMsgList == true) {
        btnright.hidden = false;
    }
    else
    {
        btnright.hidden = true;
    }
    
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


-(void)viewWillDisappear:(BOOL)animated
{
    [self RemoveObserveKeyboard];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;

//    [[UINavigationBar appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:NavigationTitleColor,NSForegroundColorAttributeName,
//      FontRegular,NSFontAttributeName,nil]];
//    [[UINavigationBar appearance]setBackgroundColor:NavigationBarBgColor];

    if (_IsFromMsgList == true)
    {
        self.tabBarController.tabBar.hidden = false;
    }
    else
    {
        self.tabBarController.tabBar.hidden = true;
    }
    
    NSLog(@"username %@",[NSString stringWithFormat:@"%@",[GlobalMethod shareGlobalMethod].strUserName]);
    [self observeKeyboard];
    if (FromNextPage==false) {
        
        [self postdataToServer];
    }
}

-(void)incrementBadge:(id)sender
{
    //    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].notificationCount];
    
    if (_IsFromMsgList == true) {
        self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber];

    }

}

-(void)postdataToServer
{
    {
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            ShowNetworkActivityIndicator();
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            headerTitle = nil;
            arrayMsgDetail = nil;

            if (_FromReplyBtn == false)
            {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                
                [dict setValue:[NSString stringWithFormat:@"%d",_threadID] forKey:@"thread_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"post_id"];
                [dict setValue: [_arrayFromMsgViewList valueForKey:@"user_id"] forKey:@"user_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_id"];
                [dict setValue:@"1" forKey:@"chr_read"];
                [dict setValue:@"Y" forKey:@"chr_log"];
                [dict setValue:[_arrayFromMsgViewList valueForKey:@"notification_id"] forKey:@"notification_id"];

                NSLog(@"dict message %@",dict);
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"get_messagelist";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"get_messagelist" withToken:NO];
            }
            else
            {
                NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"post_id"];
                [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
                //        [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_uid"];
                NSLog(@"reply dict %@",dict);
                [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"go_to_message_list_from_reply";
                [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"go_to_message_list_from_reply" withToken:NO];
            }
        }
        else
        {
            [self.view makeToast:@"Check Internet Connection"];
            
        }
    }
}
-(void)openDetailPage
{
    FromNextPage = true;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[[arrayMsgDetail valueForKey:@"post_user_id"] objectAtIndex:0] forKey:@"user_id"];
    [dict setValue:[[arrayMsgDetail valueForKey:@"post_id"] objectAtIndex:0] forKey:@"post_id"];
    
    
    int index = [[[arrayMsgDetail valueForKey:@"post_user_id"] objectAtIndex:0] intValue];
    
    if (index == [GlobalMethod shareGlobalMethod].userID)
    {
        MyPostDetailViewController *mypostDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPostDetailViewController"];
        mypostDetailObj.dictPostDetail = dict;
        mypostDetailObj.strTitleName = @"POST DETAILS";
        [self.navigationController pushViewController:mypostDetailObj animated:YES];
        
    }
    else
    {
        SelectCategoryPostDetailViewController  *selectDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostDetailViewController"];
        selectDetailObj.dictDetail = dict;
        selectDetailObj.strNavigationTitle = @"";
        selectDetailObj.userID = [[[arrayMsgDetail valueForKey:@"post_user_id"] objectAtIndex:0] intValue];
        //        selectDetailObj.strUserName = _strUserName;
        [self.navigationController pushViewController:selectDetailObj animated:YES];
    }
}
#pragma mark - UITableview method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [headerTitle sortedArrayUsingDescriptors:descriptors];

    return reverseOrder.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextAlignment:NSTextAlignmentCenter];
//    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor colorWithRed:167.0/255.0 green:169.0/255.0 blue:172.0/255.0 alpha:1.0]];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor grayColor]];

    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:FontRegular14];

    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [headerTitle sortedArrayUsingDescriptors:descriptors];

    NSString *str = [reverseOrder objectAtIndex:section];
    
    if ([str isEqualToString:@"today"]) {
        str = [str stringByReplacingOccurrencesOfString:@"t" withString:@"T"];
    }
    return str;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [headerTitle sortedArrayUsingDescriptors:descriptors];
    
    
    NSArray *array = [[Arraysection objectAtIndex:0] valueForKey:[reverseOrder objectAtIndex:section]];
    return [array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%d",@"SelectCategorycell",(int)indexPath.row];
    
    MessageDetailCellTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[MessageDetailCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    }
    
//    NSMutableArray *arr =[[Arraysection objectAtIndex:0] valueForKey:[headerTitle objectAtIndex:indexPath.section]];
    
    //    cell1.imgviewpost.image = [UIImage imageWithData:[arrayPostImageList objectAtIndex:indexPath.row]];
    
    
    NSLog(@"indexpath row %ld",(long)indexPath.row);
    NSLog(@"indexpath row %ld",(long)indexPath.section);

    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [headerTitle sortedArrayUsingDescriptors:descriptors];
    
    NSString *strheader = [reverseOrder objectAtIndex:indexPath.section];
    NSArray *strmsg  = [[Arraysection objectAtIndex:0] valueForKey:strheader];//[[Arraysection valueForKey:strheader] objectAtIndex:0];
    NSLog(@"strmsg %@",strmsg);
    NSArray *cellarray  =[strmsg objectAtIndex:indexPath.row];
    NSLog(@"cellarray %@",cellarray);

    
    NSString *struserName = [NSString stringWithFormat:@"%@",[GlobalMethod shareGlobalMethod].strUserName];
    cell1.lblUserName.text = [cellarray valueForKey:@"user_name"];
    cell1.lblUserName.font = FontBold14;

//    cell1.lblMsg.text = [[arrayMsgDetail valueForKey:@"message"] objectAtIndex:indexPath.row];//neha
    cell1.lblMsg.text = [cellarray valueForKey:@"message"];
    cell1.lblMsg.font = FontRegular16;
//    NSString *str = [[arrayMsgDetail valueForKey:@"message"] objectAtIndex:indexPath.row];//neha
    
    NSString *str = [cellarray valueForKey:@"message"];
    CGSize frame1 = [self cellRowHeight:str];
    CGRect frame= cell1.lblMsg.frame;
    frame.size.height = frame1.height;
    cell1.lblMsg.frame = frame;
    cell1.lblMsg.numberOfLines = cell1.lblMsg.frame.size.height/cell1.lblMsg.font.lineHeight;
    cell1.lblMsg.lineBreakMode = NSLineBreakByWordWrapping;


//    NSString *strName =  [self DateDisplayWithMonthName:[[arrayMsgDetail valueForKey:@"date"] objectAtIndex:indexPath.row]];//neha
//    NSString *strName =  [self DateDisplayWithMonthName:[[arrayMsgDetail valueForKey:@"date"] objectAtIndex:indexPath.row] section:indexPath.section];
 
    NSString *strName =  [self DateDisplayWithMonthName:[cellarray valueForKey:@"date"]];
    cell1.lblDate.text = [NSString stringWithFormat:@"%@",strName];
    cell1.lblDate.font = FontRegular14;
    cell1.lblDate.textAlignment = NSTextAlignmentRight;

    if ([struserName isEqualToString:cell1.lblUserName.text])
    {
        cell1.imageviewBg.frame = CGRectMake(screenWidth/4, 10,screenWidth-(screenWidth/4),cell1.lblMsg.frame.size.height+20);
        cell1.lblDate.frame = CGRectMake(screenWidth-80, cell1.imageviewBg.frame.size.height+10,60, 30);
        cell1.lblMsg.frame = CGRectMake(8,10,ipadDevice?cell1.imageviewBg.frame.size.width-25:cell1.imageviewBg.frame.size.width-25,cell1.lblMsg.frame.size.height);
        cell1.lblMsg.textColor = [UIColor whiteColor];
        
//        UIImage *imgae = [[UIImage imageNamed:@"bubbleSquareOutgoing.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:13];
        UIImage *imgae = [[UIImage imageNamed:@"bubbleSquareOutgoing.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:13];
        [cell1.imageviewBg setImage:imgae];
    }
    else
    {
        cell1.imageviewBg.frame = CGRectMake(0, 10,screenWidth-(screenWidth/4), cell1.lblMsg.frame.size.height+20);
        cell1.lblDate.frame = CGRectMake(ipadDevice?cell1.imageviewBg.frame.size.width-80:cell1.imageviewBg.frame.size.width-75, cell1.imageviewBg.frame.size.height+10,60, 30);
        cell1.lblMsg.frame = CGRectMake(ipadDevice?cell1.imageviewBg.frame.origin.x+15:cell1.imageviewBg.frame.origin.x+20,10,ipadDevice?screenWidth-(screenWidth/4)-25:screenWidth-(screenWidth/4)-35,cell1.lblMsg.frame.size.height);
        cell1.lblMsg.textColor = [UIColor blackColor];
        
        
//        UIImage *imgae = [[UIImage imageNamed:@"bubbleSquareIncoming.png"] stretchableImageWithLeftCapWidth:23 topCapHeight:15];
        UIImage *imgae = [[UIImage imageNamed:@"bubbleSquareIncoming.png"] stretchableImageWithLeftCapWidth:23 topCapHeight:15];

        [cell1.imageviewBg setImage:imgae];

    }
    
    NSLog(@"msg length %u",cell1.lblMsg.text.length);
    return cell1;
}

-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [headerTitle sortedArrayUsingDescriptors:descriptors];
    
    NSString *strheader = [reverseOrder objectAtIndex:indexPath.section];
    NSArray *strmsg  = [[Arraysection objectAtIndex:0] valueForKey:strheader];//[[Arraysection valueForKey:strheader] objectAtIndex:0];
    NSLog(@"strmsg %@",strmsg);
    NSArray *cellarray  =[strmsg objectAtIndex:indexPath.row];
    NSLog(@"cellarray %@",cellarray);

//    NSString *str = [[arrayMsgDetail valueForKey:@"message"] objectAtIndex:indexPath.row];
    NSString *str = [cellarray valueForKey:@"message"];
    CGSize frame = [self cellRowHeight:str];
    return frame.height+55;
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

-(void)scrollToBottom:(id)sender
{
    CGSize r = tblviewMsgDetail.contentSize;
    [tblviewMsgDetail scrollRectToVisible:CGRectMake(0, r.height-10, r.width, 10) animated:YES];
}
-(CGSize)cellRowHeight:(NSString *)str
{
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 0.7;
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : FontRegular16}];
    CGSize frame = [attributedString2 boundingRectWithSize:CGSizeMake(screenWidth-(screenWidth/4)-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:context].size;
    return frame;
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}


#pragma mark - UItextField Delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UIToolbar  *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight-255, screenWidth, 44)];
    toolbar.barStyle=UIBarStyleDefault;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked:)];
    done.tintColor = txtFieldTextColor;
    [toolbar setItems:[[NSArray alloc] initWithObjects: done, nil]];
    
    txtmsg.inputAccessoryView = toolbar;
    return YES;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([txtmsg isFirstResponder]) {
        [txtmsg resignFirstResponder];
    }
    [self btnSendClicked:btnSend];
    return YES;
}
-(void)doneButtonClicked:(id)sender
{
    if ([txtmsg isFirstResponder]) {
        [txtmsg resignFirstResponder];
    }
}
#pragma mark - Button Click event
-(void)btnBellClicked
{
    FromNextPage= true;
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


#pragma mark - connection delegate
 -(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    NSArray *array =[nData JSONValue];
    NSLog(@"arr msg detail %@",array);
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    HideNetworkActivityIndicator();

   
    NSArray *arrayCreatedPostUserList  =  [[[array valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"user_name"];
    
    for (int i = 0 ; i < arrayCreatedPostUserList.count; i++)
    {
        if (![[arrayCreatedPostUserList objectAtIndex:i]isEqualToString:[GlobalMethod shareGlobalMethod].strUserName]) {
        
           NSString *str = [arrayCreatedPostUserList objectAtIndex:i];
            lblPostName.text = [NSString stringWithFormat:@"%@-%@",str,_strPostName];
            break;
        
        }
        else
        {
            NSString *str = [[[[array valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"own_username"] objectAtIndex:i];
            lblPostName.text = [NSString stringWithFormat:@"%@-%@",str,_strPostName];
        }
        
    }
    
//    NSArray *arrayDate = [[[array valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"date"];
    
    ////////======================
    sections = [[NSMutableDictionary alloc]init];
    if (!headerTitle) {
        headerTitle = [[NSMutableArray alloc]init];

    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init] ;
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
//    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    
//    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]]
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    for (NSDictionary *dic in [[array valueForKey:@"Response"] valueForKey:@"Details"])
    {
        NSDate *date=[dateFormat dateFromString:[dic objectForKey:@"date"]];
        if (date == nil) {
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            date = [dateFormat dateFromString:[dic objectForKey:@"date"]];
        }

        NSLog(@"dic %@",dic);
        
        NSString *str= [self dateStringReturn:date];
        
        BOOL isTheObjectThere = [[sections allKeys] containsObject:str];
        
        
        if (!isTheObjectThere)
        {
            [sections setObject:[[NSMutableArray alloc] init] forKey:str];
            [headerTitle addObject:str];
        }
//        NSLog(@"self.sections %@",sections);
    }
    NSLog(@"self.sections %@",sections);
    NSLog(@"headerTitle %@", headerTitle);
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"self"
                                                               ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    NSArray *reverseOrder = [headerTitle sortedArrayUsingDescriptors:descriptors];
    
    NSLog(@"headerTitle ==== %@", reverseOrder);


    NSMutableArray *arraysort = [[array valueForKey:@"Response"] valueForKey:@"Details"];
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSArray *descriptors1 = [NSArray arrayWithObject:valueDescriptor];
    NSArray *sortedArray = [arraysort mutableCopy];
    NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors1];

//    for (NSDictionary *dic in [[array valueForKey:@"Response"] valueForKey:@"Details"])

    for (NSDictionary *dic in sArray)
    {
        NSDate *date=[dateFormat dateFromString:[dic objectForKey:@"date"]];
        NSString *str= [self dateStringReturn:date];
        
        [[sections objectForKey:str] addObject:dic];
    }
    NSLog(@"sections print....%@",sections);
    
    Arraysection = [[NSMutableArray alloc]init];
    [Arraysection addObject:sections];
    
//    arrayAllBuzzListDetail = [NSMutableArray arrayWithArray:sArray];
//
//    if (Arraysection.count>0) {
//        [Arraysection removeAllObjects];
//        Arraysection = [reverseOrder1 mutableCopy];
//    }
//    Arraysection = [reverseOrder1 objectAtIndex:sections];
    NSLog(@"array section %@",Arraysection);
//=======================
    
    if ( arrayMsgDetail.count > 0) {
        [arrayMsgDetail removeAllObjects];
    }
    
    if (strstatuscode == 200) {
        
        if ([nState isEqualToString:@"get_messagelist"])
        {
            if (!arrayMsgDetail) {
                arrayMsgDetail = [[NSMutableArray alloc]init];
            }
            arrayMsgDetail = [[array valueForKey:@"Response"] valueForKey:@"Details"];
            NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES selector:@selector(localizedStandardCompare:)];
            NSArray *descriptors2 = [NSArray arrayWithObject:valueDescriptor];
            NSArray *sortedArray = [arrayMsgDetail mutableCopy];
            NSArray *sArray = [sortedArray sortedArrayUsingDescriptors:descriptors2];
            arrayMsgDetail = [NSMutableArray arrayWithArray:sArray];

            if (arrayMsgDetail.count>0) {

            [tblviewMsgDetail reloadData];
            
            int lastSection = (int)[tblviewMsgDetail numberOfSections]-1;
            
            if (lastSection < 0)
            {
                lastSection = 0;
            }
            NSIndexPath* ip = [NSIndexPath indexPathForRow:[tblviewMsgDetail numberOfRowsInSection:lastSection] - 1 inSection:lastSection];
            [tblviewMsgDetail scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }

        }
        
        if ([nState isEqualToString:@"go_to_message_list_from_reply"])
        {
            if (!arrayMsgDetail) {
                arrayMsgDetail = [[NSMutableArray alloc]init];
            }
            arrayMsgDetail = [[array valueForKey:@"Response"] valueForKey:@"Details"];
            [tblviewMsgDetail reloadData];
            
            int lastSection = (int)[tblviewMsgDetail numberOfSections]-1;
            
            NSIndexPath* ip = [NSIndexPath indexPathForRow:[tblviewMsgDetail numberOfRowsInSection:lastSection] - 1 inSection:lastSection];
            [tblviewMsgDetail scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:NO];


        }
        
        if ([nState isEqualToString:@"send_message"]) {
            
            txtmsg.text= @"";
            [self.view makeToast:@"Message sent."];
            
            headerTitle = nil;
            arrayMsgDetail = nil;
            [self postdataToServer];
//            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//            
//            [dict setValue:[NSString stringWithFormat:@"%d",_threadID] forKey:@"thread_id"];
//            [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"post_id"];
//            [dict setValue: [_arrayFromMsgViewList valueForKey:@"user_id"] forKey:@"user_id"];
//            [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"own_id"];
//            [dict setValue:@"1" forKey:@"chr_read"];
//            [dict setValue:@"Y" forKey:@"chr_log"];
//            
//            NSLog(@"dict message %@",dict);
//            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"get_messagelist";
//            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"get_messagelist" withToken:NO];


//            [self viewWillAppear:YES];
//            [tblviewMsgDetail reloadData];
        }
    }
    
    
}
-(void)ConnectionDidFail:(NSString *)nState Data:(NSString *)nData
{
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    HideNetworkActivityIndicator();
    [self.view makeToast:@"Internal Server Error"];


}

#pragma mark -

- (NSString*)DateDisplayWithMonthName:(NSString*)strDate
{
    
    //current Date -------------
    
    NSDate *startDate = [NSDate date];
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSCalendar *calendar123 = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalendar.calendarIdentifier];
    calendar123.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* components123 = [calendar123 components:flags fromDate:startDate];
    startDate = [calendar123 dateFromComponents:components123];
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-LLL-yy";
    
    //EndDate --------------
    
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
    [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate =  [dateformate dateFromString:strDate];
    
    if (endDate == nil)
    {
        [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        endDate = [dateformate dateFromString:strDate];
    }

    
    NSUInteger flags1 = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *currentCalendar1 = [NSCalendar currentCalendar];
    NSCalendar *calendar1231 = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalendar1.calendarIdentifier];
    calendar1231.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* components1231 = [calendar1231 components:flags1 fromDate:endDate];
    NSDate *newEndDate = [calendar1231 dateFromComponents:components1231];

    
    ////////=======
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"HH:mm";
//    NSDate *date = [dateFormatter dateFromString:strDate];
    
//    dateFormatter.dateFormat = @"hh:mm a";
//    NSString *pmamDateString = [dateFormatter stringFromDate:endDate];
    
    ///========

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* utcTime = [dateFormatter dateFromString:strDate];
    NSLog(@"UTC time: %@", utcTime);

    
        NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
        [format1 setTimeZone:[NSTimeZone systemTimeZone]];
//        [format1 setTimeZone:[NSTimeZone localTimeZone]];
    
        format1.dateFormat = @"hh:mm a";

        NSString *str;
        str = [format1 stringFromDate:utcTime];
    
    
    //Days
    NSDateComponents *components;
    NSInteger days;
    
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: newEndDate toDate: startDate options: 0];
    days = [components day];


    if (days==0) {
        NSLog(@"today");
        strSectionName=@"today";
        
    }
    else if (days == 1)
    {
        NSLog(@"Yesterday");
        strSectionName = @"Yesterday";
        
    }
    else
    {
        NSLog(@"Past");
        strSectionName = @"Past";
    }
    ////
    NSLog(@"str %@ %@",str,strSectionName);
    return str;
}

-(NSString*)dateStringReturn:(NSDate*)datestr
{
    //    NSString myString = @"2012-11-22 10:19:04";
    NSDate *startDate = datestr;
    NSLog(@"%@", startDate); // 2014-02-20 11:36:20 +0000
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSCalendar *calendar123 = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalendar.calendarIdentifier];
    calendar123.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* components123 = [calendar123 components:flags fromDate:startDate];
    startDate = [calendar123 dateFromComponents:components123];
    NSLog(@"%@", startDate); // 2014-02-20 00:00:00 +0000
    
    
    //current Date -------------
    
    NSDate *currentDate = [NSDate date];
    NSUInteger flags1 = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSCalendar *currentCalendar1 = [NSCalendar currentCalendar];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:currentCalendar1.calendarIdentifier];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateComponents* components = [calendar components:flags1 fromDate:currentDate];
    currentDate = [calendar dateFromComponents:components];
    
    
//    =======
    //Days
    NSDateComponents *components1;
    NSInteger days;
    
    components1 = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: currentDate toDate: startDate options: 0];
    days = [components1 day];
    
    
  //  =========
    
    NSString *str;
    if (days==0) {
        NSLog(@"today");
        str = @"today";
    }
    else if (days == -1)
    {
        NSLog(@"Yesterday");
        str  = @"Yesterday";
    }
    else
    {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"dd LLLL yyyy";
        NSLog(@"%@", [format stringFromDate:startDate]);
        str = [format stringFromDate:startDate];
    }
    
    
    return str;
}


#pragma mark - KeyBoard
- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)RemoveObserveKeyboard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

// The callback for frame-changing of keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height =  keyboardFrame.size.height;
    
    keyboardHeight.constant=ipadDevice?height-35:height-45;
//    keyboardbtnSend.constant = height-45;
    if (self.tabBarController.tabBar.hidden == true)
    {
        keyboardHeight.constant=ipadDevice?height:height;

    }

    
    [UIView animateWithDuration:animationDuration animations:^{
        
        [self.view layoutIfNeeded]
        ;
    }];
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyboardHeight.constant = 10;
    keyboardbtnSend.constant = 0;

    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(IBAction)btnSendClicked:(id)sender
{
    NSLog(@"send btn clicked");
    FromNextPage = false;
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;
        
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"post_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",[GlobalMethod shareGlobalMethod].userID] forKey:@"user_id"];
        [dict setValue:[GlobalMethod shareGlobalMethod].strUserName forKey:@"user_name"];
        [dict setValue:txtmsg.text forKey:@"message"];
        [dict setValue:_strPostName forKey:@"post_name"];
        if (!_threadID) {
            _threadID = [[[arrayMsgDetail objectAtIndex:0] valueForKey:@"thread_id"] intValue];
        }
        [dict setValue:[NSString stringWithFormat:@"%d",_threadID] forKey:@"thread_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",_readID] forKey:@"reply_id"];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
        format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *date = [format stringFromDate:[NSDate date]];
        
        [dict setValue:date forKey:@"create_date"];
        NSLog(@" send_message ==> dict %@",dict);
        
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"send_message";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"send_message" withToken:NO];
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
    }
    
    
}
#pragma mark - uitext

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
