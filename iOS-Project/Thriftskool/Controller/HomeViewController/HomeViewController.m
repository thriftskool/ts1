//
//  HomeViewController.m
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "HomeViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"
#import "UIButton+Badge.h"


#define navWidth [UIScreen mainScreen].bounds.size.width

@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end


#pragma mark - UISearchBar
@implementation UISearchBar (MyAdditions)

- (void)changeDefaultBackgroundColor:(UIColor *)color {
    for (UIView *subview in self.subviews) {
        for (UIView *subSubview in subview.subviews) {
            if ([subSubview isKindOfClass:[UITextField class]]) {
                UITextField *searchField = (UITextField *)subSubview;
                searchField.clearButtonMode=UITextFieldViewModeNever;
                searchField.backgroundColor = color;
                searchField.textColor = [UIColor colorWithRed:72.0/255.0 green:144.0/255.0 blue:75.0/255.0 alpha:1.0];
                NSAttributedString *strConfirmPassword = [[NSAttributedString alloc] initWithString:@"Search" attributes:@{ NSForegroundColorAttributeName : searchField.textColor}];
                searchField.attributedPlaceholder = strConfirmPassword;
                UIImageView *leftImageView = (UIImageView *)searchField.leftView;
                leftImageView.image = [leftImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                leftImageView.tintColor = searchField.textColor;
                
                UIToolbar  *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight-255, screenWidth, 44)];
                toolbar.barStyle=UIBarStyleDefault;
                
                UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClickedInSearch:)];
                done.tintColor = txtFieldTextColor;
                [toolbar setItems:[[NSArray alloc] initWithObjects: done, nil]];
                
                searchField.inputAccessoryView = toolbar;

                
                break;
            }
        }
    }
}

-(void)doneButtonClickedInSearch:(UITextField*)sender
{
    for (UIView *subview in self.subviews) {
        for (UIView *subSubview in subview.subviews) {
            if ([subSubview isKindOfClass:[UITextField class]]) {
                UITextField *searchField = (UITextField *)subSubview;
                
                if ([searchField isFirstResponder]) {
                    [searchField resignFirstResponder];
                }
            }
        }
    }
    
    NSLog(@"donebutton clicked %@",sender);
}

@end


#pragma mark - HomeViewController
@implementation HomeViewController
@synthesize selectcatpostlistObj;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navigationView.backgroundColor = NavigationBarBgColor;
    appDelegate.tabviewControllerObj.homeviewObj = self;

//    UIButton *
    btnBell = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBell.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btnBell setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnBell setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    btnBell.frame = CGRectMake(navWidth-35,30, 30.0, 30.0);
    [btnBell addTarget:self action:@selector(btnBellClicked) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:btnBell];
    
    
    UIButton *btnResend = [UIButton buttonWithType:UIButtonTypeCustom];
    btnResend.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btnResend setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
//    [btnResend setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    [btnResend setImage:[UIImage imageNamed:@"NewResend.png"] forState:UIControlStateNormal];
    btnResend.frame = CGRectMake(5,30, 30.0, 30.0);
    [btnResend addTarget:self action:@selector(btnResendClicked) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:btnResend];

    UISearchBar *ser = [[UISearchBar alloc]initWithFrame:CGRectMake(ipadDevice?150:35, 30, ipadDevice?470:navWidth - 65, 30)];
    ser.delegate = self;
    ser.barTintColor = NavigationBarBgColor;
    ser.layer.borderColor = NavigationBarBgColor.CGColor;
    ser.layer.borderWidth = 1.0;
    
    [ser changeDefaultBackgroundColor:[UIColor colorWithRed:148.0/255.0 green:209.0/255.0 blue:151.0/255.0 alpha:1.0]];
    
    [navigationView addSubview:ser];
    
    NSLog (@"Courier New family fonts: %@", [UIFont fontNamesForFamilyName:@"Myriad Pro"]);

    UILabel *lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(ipadDevice?0:0, 60, ipadDevice?screenWidth:screenWidth, 40)];
    
//    _strUniversityName =[_strUniversityName stringByReplacingOccurrencesOfString:@"University" withString:@""];
    
//    NSRange range = [_strUniversityName rangeOfString:@"ThriftSkool"];
//    if (range.length == NSNotFound) {
        lblTitle.text = [NSString stringWithFormat:@"%@ ThriftSkool",_strUniversityName];
//    }
//    else
//    {
//        lblTitle.text = [NSString stringWithFormat:@"%@",_strUniversityName];
//
//    }
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.font = [UIFont fontWithName:@"FreestyleScriptPlain" size:30.0];
    [navigationView addSubview: lblTitle];


    if (_strLogin)
    {
        [self.view makeToast:@"Successful login"];

    }
    
    IsFromNextPage = false;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(incrementBadge:)
                                   userInfo:nil
                                    repeats:YES];

}

#pragma mark - PushNOtification count
-(void)incrementBadge:(id)sender
{
    if ([UIApplication sharedApplication].applicationIconBadgeNumber != 0) {
        btnBell.badgeValue = [NSString stringWithFormat:@"%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber];
    }
    else
    {
        btnBell.badgeValue = @"";
    }
}

-(void)pushNotificationReceived:(NSArray*)array
{
    NSLog(@"selected index %u",self.tabBarController.selectedIndex);
    if (self.tabBarController.selectedIndex == 0)
    {
//        [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber-1;
        
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

}


-(void)viewWillAppear:(BOOL)animatedhj
{
    self.tabBarController.tabBar.hidden = false;


    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        if (IsFromNextPage == false)
        {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"post_categorylist";
            [[ConnectionServer sharedConnectionWithDelegate:self]GetStartUp:dict caseName:@"post_categorylist" withToken:NO];
            
        }
        else
        {
            scrollview.scrollEnabled = YES;
            int x = ipadDevice?7:3;
            int y = ipadDevice?-5:-10;
            int space = navWidth/8;
            
            
            for (int i = 0 ; i < arraCategoryName.count; i++) {
                
                UIImageView * view;
                UIImageView *imageview2;
                UIImageView *transperent;
                
                if (ipadDevice)
                {
                    space = navWidth/9;
                    view = [[UIImageView alloc]initWithFrame:CGRectMake(x,y, navWidth/3-9, navWidth/3-9)];
                    
                    transperent = [[UIImageView alloc]initWithFrame:CGRectMake(x,y, navWidth/3-9, navWidth/3-9)];
                    imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(x+space,y+space, navWidth/9, navWidth/9)];
                }
                else
                {
                    view = [[UIImageView alloc]initWithFrame:CGRectMake(x,y, navWidth/2-5, navWidth/2-5)];
                    transperent = [[UIImageView alloc]initWithFrame:CGRectMake(x,y, navWidth/2-5, navWidth/2-5)];
                    imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(x+space+10,y+space, navWidth/6, navWidth/6)];
                }
                
                //            view.backgroundColor = [UIColor redColor];
                //            view.image = [UIImage imageWithData:[arrayBgImageList objectAtIndex:i]];
                NSURL *url = [NSURL URLWithString:[arrayBgImageList objectAtIndex:i]];
                NSString *cacheFilename = [url lastPathComponent];
//                NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
                int index = (int)[url pathComponents].count-3;
                NSString *folderName =[[url pathComponents] objectAtIndex:index];
                
                NSLog(@"folderName %@",folderName);
                NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];

                id image = [LazyLoadingImage imageDataFromPath:cachePath];
                
                
                if(image)
                {
                    view.image = (UIImage*)image;
                    [scrollview setNeedsDisplay];
                    
                }
                else
                {
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                     {
                         if (connectionError == nil)
                         {
                             view.image = [UIImage imageWithData:data];
                             [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                             [scrollview setNeedsDisplay];
                             
                         }
                     }];
                }
                
                view.tag = [[arrayPostIdList objectAtIndex:i] intValue];
                view.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCategory:)];
                [view addGestureRecognizer:tap1];
                
                
                
                transperent.tag = [[arrayPostIdList objectAtIndex:i] intValue];
                transperent.userInteractionEnabled =YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCategory:)];
                [transperent addGestureRecognizer:tap];
                
                transperent.backgroundColor = [UIColor blackColor];
                transperent.layer.opacity = 0.8;
                [scrollview addSubview:view];
                [scrollview addSubview:transperent];
                
                
                //            imageview2.image = [UIImage imageWithData:[arrayPostImageList objectAtIndex:i]];
                NSURL *url1 = [NSURL URLWithString:[arrayPostImageList objectAtIndex:i]];
                NSString *cacheFilename1= [url1 lastPathComponent];
                NSString *cachePath1 = [LazyLoadingImage cachePath:cacheFilename1];
                id image1 = [LazyLoadingImage imageDataFromPath:cachePath1];
                
                if(image1)
                {
                    imageview2.image = (UIImage*)image1;
                    
                    [scrollview setNeedsDisplay];
                }
                else
                {
                    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
                    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                     {
                         if (connectionError == nil)
                         {
                             imageview2.image = [UIImage imageWithData:data];
                             [LazyLoadingImage imageCacheToPath:cachePath1 imgData:data];
                             
                             [scrollview setNeedsDisplay];
                         }
                     }];
                }
                
                [scrollview addSubview:imageview2];
                //             view.alpha  = 0.38;
                //            imageview2.alpha = 6.0;//80.0
                
                
                
                UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(x+7+3, imageview2.frame.origin.y+imageview2.frame.size.height+10, view.frame.size.width-20, 40)];
                lbl.text = [arraCategoryName objectAtIndex:i];
                lbl.tag =  [[arrayPostIdList objectAtIndex:i] intValue];
                lbl.textColor = NavigationTitleColor;
                lbl.font = FontRegular;
                lbl.textAlignment = NSTextAlignmentCenter;
                lbl.numberOfLines = lbl.frame.size.height/lbl.font.lineHeight;
                lbl.lineBreakMode = NSLineBreakByWordWrapping;
                [scrollview addSubview:lbl];
                
                //            [scrollview addSubview:view];
                
                
                x = ipadDevice?view.frame.origin.x+view.frame.size.width+7:view.frame.origin.x+view.frame.size.width+3;
                
                if (x > navWidth-5) {
                    y = ipadDevice?view.frame.origin.y+view.frame.size.height+7 : view.frame.origin.y+view.frame.size.height+3;
                    x = ipadDevice?7: 3;
                    
                }
                scrollview.contentSize = CGSizeMake(300,ipadDevice?y-20:y-30);
            }
        }
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"InternetAvailable", nil)];
    }
    
    self.navigationController.navigationBar.hidden = YES;
}



#pragma mark - Navigation button Nethod

-(void)btnBellClicked
{
    NSLog(@"bell clicked");
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];

}
-(void)btnResendClicked
{
    NSLog(@"Resend clicked");
    
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        IsFromNextPage = true;
        selectcatpostlistObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostListViewController"];
        selectcatpostlistObj.clickedResendBtn = true;
        selectcatpostlistObj.universityID = _universityID;
        selectcatpostlistObj.userID = _userID;
       
        [self.navigationController pushViewController:selectcatpostlistObj animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }

    
}


#pragma mark -
-(void)selectCategory:(UITapGestureRecognizer*)Sender
{
    UIImageView *imgview = (UIImageView*)Sender.view;
    NSLog(@"sender %@",imgview);
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        IsFromNextPage = true;
        selectcatpostlistObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostListViewController"];
        selectcatpostlistObj.clickedResendBtn = false;
        selectcatpostlistObj.userID = _userID;
        selectcatpostlistObj.universityID = _universityID;
        selectcatpostlistObj.postCatID = (int)imgview.tag ;
        selectcatpostlistObj.strUserName = _strUserName;
        selectcatpostlistObj.SelectCategory = 1;
        int index = (int)[arrayPostIdList indexOfObject:[NSString stringWithFormat:@"%d",selectcatpostlistObj.postCatID]];
        selectcatpostlistObj.strSelectedCategoryName = [arraCategoryName objectAtIndex:index];
        
        [self.navigationController pushViewController:selectcatpostlistObj animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
}
#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    int status = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (status == 200)
    {
        if ([nState isEqualToString:@"post_categorylist"])
        {

            dictUniversityList = [[arrData valueForKey:@"Response"] valueForKey:@"Details"];
            
            arraCategoryName = [[NSMutableArray alloc]initWithArray:[dictUniversityList valueForKey:@"post_category_name"]];
            arrayPostIdList =  [dictUniversityList valueForKey:@"post_cat_id"];
            
            NSArray *arrayImageName =  [dictUniversityList valueForKey:@"post_cat_image"];
            NSString  *imagepath= [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];

            
            for (int i = 0; i < arrayImageName.count; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%@%@",imagepath,[arrayImageName objectAtIndex:i]];

                if (!arrayPostImageList) {
                    arrayPostImageList = [[NSMutableArray alloc]init];
                }
                [arrayPostImageList addObject:str];
            }
            
            NSArray *arrayBgImage = [dictUniversityList valueForKey:@"background_image"];
            for (int i = 0; i < arrayBgImage.count; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%@%@",imagepath,[arrayBgImage objectAtIndex:i]];

                if (!arrayBgImageList) {
                    arrayBgImageList = [[NSMutableArray alloc]init];
                }
                [arrayBgImageList addObject:str];
                
            }


            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:arraCategoryName forKey:@"categoryNameList"];
            [defaults setObject:arrayPostIdList forKey:@"categoryId"];
            [defaults setObject:arrayPostImageList forKey:@"HomePostImageList"];
            [defaults setObject:arrayBgImageList forKey:@"BgImageList"];
            [defaults synchronize];
            
            IsFromNextPage = true;
            [self viewWillAppear:NO];
        }
        
        
    }
    else if (status == 201)
    {
        HideNetworkActivityIndicator();
        
    }
    
    else if (status == 404)
    {
        HideNetworkActivityIndicator();
        
    }
    else if (status == 401)
    {
        HideNetworkActivityIndicator();
    }
    else if (status == 400)
    {
        HideNetworkActivityIndicator();
        
    }
    
    else if (status == 500)
    {
        HideNetworkActivityIndicator();
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;
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

#pragma mark - UISearchResultsUpdating

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.view endEditing:true];
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        IsFromNextPage = true;
        if(!selectcatpostlistObj)
        {
            
            selectcatpostlistObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostListViewController"];
        }
        selectcatpostlistObj.SelectCategory = 0;
        selectcatpostlistObj.clickedResendBtn = false;
        selectcatpostlistObj.userID = _userID;
        selectcatpostlistObj.dicSearchList = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_universityID],@"university_id",searchBar.text,@"search_text", nil];
        selectcatpostlistObj.strSelectedCategoryName = @"SEARCH RESULTS";
        [self.navigationController pushViewController:selectcatpostlistObj animated:YES];
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"InternetAvailable", nil)];
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
