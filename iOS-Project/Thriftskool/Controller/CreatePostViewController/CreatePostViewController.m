//
//  CreatePostViewController.m
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "CreatePostViewController.h"
#import "CategoryListViewController.h"
#import "PrivacyPocilyViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"





@implementation CreatePostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"CREATE POST";
    // Do any additional setup after loading the view.
    
    
    //Rigth Side Button
    UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    btnright.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btnright setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnright setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    btnright.frame = CGRectMake(0,1, 30.0, 20.0);
    [btnright addTarget:self action:@selector(btnrightClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnRightBellView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 30, 22)];
    btnRightBellView.bounds = CGRectOffset(btnRightBellView.bounds, 0,0);
    [btnRightBellView addSubview:btnright];
    UIBarButtonItem *bellBtn = [[UIBarButtonItem alloc]initWithCustomView:btnRightBellView];
    self.navigationItem.rightBarButtonItem = bellBtn;
    
    
    
    
    
    //===============    Add Data In scrollview  ===================
    
    scrollview.showsVerticalScrollIndicator = false;
    scrollview.backgroundColor = tableBackgroundColor;
     rowHeight  = [UIScreen mainScreen].bounds.size.width/4-16-8;
    
    viewphoto = [[UIView alloc]initWithFrame:CGRectMake(8, 8, self.view.bounds.size.width-16, rowHeight+55)];
    viewphoto.backgroundColor = NavigationTitleColor;
    
    lblAddphoto =  [[UILabel alloc]initWithFrame:CGRectMake(16, 10,100, 30) ];
    lblAddphoto.text = @"Add Photo";
    lblAddphoto.textColor = [UIColor colorWithRed:167.0/255.0 green:169.0/255.0 blue:172.0/255.0 alpha:1.0];
    [viewphoto addSubview:lblAddphoto];
    
            int x = 16;
            for (int i = 0; i < 4; i++)
            {
                rowHeight  = [UIScreen mainScreen].bounds.size.width/4-16-8;
                UIImageView *imageviewobj = [[UIImageView alloc]initWithFrame:CGRectMake(x, 45, rowHeight, rowHeight)];
                imageviewobj.layer.cornerRadius = ipadDevice?14.0:8.0;
                imageviewobj.layer.borderColor = txtFieldTextColor.CGColor;
                imageviewobj.layer.borderWidth = 1.0;
                imageviewobj.clipsToBounds = YES;
                imageviewobj.tag = i+1;
                if (imageviewobj.tag==1)
                {
                imageviewobj.userInteractionEnabled = YES;
                }
                imageviewobj.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClicked:)];
                [imageviewobj addGestureRecognizer:tap];
                [viewphoto addSubview:imageviewobj];
                x = x + imageviewobj.frame.size.width+16;
    
            }
    
            [scrollview addSubview:viewphoto];
    
    
    
    txtTitle = [[UITextField alloc]initWithFrame:CGRectMake(8, viewphoto.frame.origin.y+viewphoto.frame.size.height+8,screenWidth-16, 50)];
    txtTitle.placeholder = @"Title";
    txtTitle.textColor  = txtFieldTextColor;
    txtTitle.backgroundColor = NavigationTitleColor;
    txtTitle.delegate = self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    txtTitle.leftView = paddingView;
    txtTitle.leftViewMode = UITextFieldViewModeAlways;
    txtTitle.tag = 1;
    [scrollview addSubview:txtTitle];
    
    //        UITextField *
    txtChooseCategory = [[UITextField alloc]initWithFrame:CGRectMake(8,txtTitle.frame.origin.y+txtTitle.frame.size.height+8,screenWidth-16, 50)];
    txtChooseCategory.placeholder = @"Choose category";
    txtChooseCategory.textColor  = txtFieldTextColor;
    txtChooseCategory.delegate = self;
    txtChooseCategory.backgroundColor = NavigationTitleColor;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    txtChooseCategory.leftView = paddingView1;
    txtChooseCategory.leftViewMode = UITextFieldViewModeAlways;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btn.frame = CGRectMake(0, 0, 20.0, 20.0);
    [btn setTitleColor:txtFieldTextColor forState:UIControlStateNormal];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleRight] forState:UIControlStateNormal];
    txtChooseCategory.rightView = btn;
    [txtChooseCategory setRightViewMode:UITextFieldViewModeAlways];
    txtChooseCategory.tag = 2;
    [scrollview addSubview:txtChooseCategory];
    
    //        UITextView *
    txtviewDescription = [[UITextView alloc]initWithFrame:CGRectMake(8, txtChooseCategory.frame.origin.y+txtChooseCategory.frame.size.height+8,screenWidth-16,70)];
    txtviewDescription.text = @"Description";
    txtviewDescription.font = FontRegular;
    txtviewDescription.textColor  = [UIColor colorWithRed:195.0/255.0 green:194.0/255.0 blue:201.0/255.0 alpha:1.0];
    txtviewDescription.backgroundColor = NavigationTitleColor;
    txtviewDescription.delegate = self;
    txtviewDescription.returnKeyType = UIReturnKeyDefault;
    txtviewDescription.tag =3;
    [txtviewDescription setTextContainerInset:UIEdgeInsetsMake(8, 12, 0, 12)];
    
    [scrollview addSubview:txtviewDescription];
    
    //        UITextField *
    txtPrice = [[UITextField alloc]initWithFrame:CGRectMake(8, txtviewDescription.frame.origin.y+txtviewDescription.frame.size.height+8,screenWidth-16, 50)];
    txtPrice.placeholder = @"Price";
    txtPrice.textColor  = txtFieldTextColor;
    txtPrice.backgroundColor = NavigationTitleColor;
    txtPrice.delegate = self;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    txtPrice.leftView = paddingView3;
    txtPrice.leftViewMode = UITextFieldViewModeAlways;
    txtPrice.tag = 4;
    [scrollview addSubview:txtPrice];
    
    
    //        UITextField *
    txtExpirationDate = [[UITextField alloc]initWithFrame:CGRectMake(8, txtPrice.frame.origin.y+txtPrice.frame.size.height+8,screenWidth-16, 50)];
    txtExpirationDate.placeholder = @"Expiration date";
    txtExpirationDate.textColor  = txtFieldTextColor;
    txtExpirationDate.backgroundColor = NavigationTitleColor;
    txtExpirationDate.delegate = self;
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 20)];
    txtExpirationDate.leftView = paddingView4;
    txtExpirationDate.leftViewMode = UITextFieldViewModeAlways;
    txtExpirationDate.tag = 5;
    [scrollview addSubview:txtExpirationDate];
    
    UIView *viewlbl = [[UIView alloc]initWithFrame:CGRectMake(8, txtExpirationDate.frame.origin.y+txtExpirationDate.frame.size.height+8,screenWidth-16, 60)];
    viewlbl.backgroundColor = tableBackgroundColor;
    
    
    //        UIButton *
//    btnCheckmark = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 35, 35)];
//    [btnCheckmark setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
//    [btnCheckmark addTarget:self action:@selector(btnCheckMarkClicked:) forControlEvents:UIControlEventTouchUpInside];
//    checkmarkSelected = false;
//    [viewlbl addSubview:btnCheckmark];
    
    
    
    UIButton *btnPost = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth-90, 5, 70, 35)];
    btnPost.backgroundColor = NavigationBarBgColor;
    [btnPost setTitle:@"POST" forState:UIControlStateNormal];
    [btnPost setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    btnPost.titleLabel.font = FontBold16;
    [btnPost addTarget:self action:@selector(btnpostClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnPost.layer.cornerRadius = 6.0;
    [viewlbl addSubview:btnPost];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnCheckMarkClicked:)];

    UITextView *lbl = [[UITextView alloc]initWithFrame:CGRectMake(16+13, 0, screenWidth-90-35,40)];
    lbl.backgroundColor = tableBackgroundColor;

    NSMutableAttributedString *str12 = [[NSMutableAttributedString alloc]initWithString:@"I have read the Privacy Policy and agree to the Terms of Use."];
    [str12 addAttribute:NSLinkAttributeName value: @"https://Ihaveread" range: NSMakeRange(0,15)];
    [str12 addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor] range:NSMakeRange(0, 15)];
    
    [str12 addAttribute:NSLinkAttributeName value: @"https://PrivacyPolicy" range: NSMakeRange(16,14)];
    [str12 addAttribute: NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(16,14)];
    [str12 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(16, 14)];
    
    [str12 addAttribute:NSLinkAttributeName value: @"https://and" range: NSMakeRange(30,18)];
    [str12 addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor] range:NSMakeRange(30, 18)];
    
    [str12 addAttribute:NSLinkAttributeName value: @"https://TermsofUse" range: NSMakeRange(48,13)];
    [str12 addAttribute: NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(48,13)];
    [str12 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(48, 13)];
    
//    lbl.scrollEnabled = NO;
    lbl.delegate = self;
        lbl.editable= NO;
    lbl.selectable=YES;
    lbl.showsVerticalScrollIndicator=NO;
    lbl.attributedText=str12;
    lbl.font= FontRegular14;
    lbl.textColor  =[UIColor blackColor];
    [lbl setTintColor:[UIColor blackColor]];
//    [viewlbl addSubview:lbl];

    
//    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(16+15,lbl.frame.origin.y+lbl.frame.size.height, screenWidth-90-35,10)];
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(10,0, screenWidth-90-35,10)];
    lbl2.text = @"All responses will be sent to your ThriftSkool inbox.";
    CGSize frame2 = [self cellRowHeight:lbl2.text];
    lbl2.userInteractionEnabled = YES;

    
    CGRect frame3 = lbl2.frame;
    frame3.size.height = frame2.height+5;
    lbl2.frame = frame3;

    lbl2.font = FontRegular14;
//    lbl2.font=[UIFont systemFontOfSize:14.0];

    lbl2.numberOfLines = lbl2.frame.size.height/lbl2.font.lineHeight;
    lbl2.lineBreakMode = NSLineBreakByWordWrapping;

//    [lbl2 addGestureRecognizer:tap2];

    [viewlbl addSubview:lbl2];
    
//    UILabel *lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(16+15,lbl2.frame.origin.y+lbl2.frame.size.height, screenWidth-90-35,10)];
    UILabel *lbl3 = [[UILabel alloc]initWithFrame:CGRectMake(10,lbl2.frame.origin.y+lbl2.frame.size.height, screenWidth-90-35,10)];

    lbl3.text = @"All posts have a 30 day maximum posting period.";
    CGSize frame5 = [self cellRowHeight:lbl3.text];
    lbl3.userInteractionEnabled = YES;
    
    
    CGRect frame4 = lbl3.frame;
    frame4.size.height = frame5.height+5;
    lbl3.frame = frame4;
    
    lbl3.font = FontRegular14;
    //    lbl2.font=[UIFont systemFontOfSize:14.0];
    
    lbl3.numberOfLines = lbl2.frame.size.height/lbl2.font.lineHeight;
    lbl3.lineBreakMode = NSLineBreakByWordWrapping;
    
    [lbl3 addGestureRecognizer:tap2];
    
    [viewlbl addSubview:lbl3];

    
    [scrollview addSubview:viewlbl];
    
    scrollview.contentSize = CGSizeMake(250, viewlbl.frame.origin.y+viewlbl.frame.size.height+20);
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];

    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(incrementBadge:)
                                   userInfo:nil
                                    repeats:YES];

}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = false;

    if (ipadDevice) {
        scrollview.scrollEnabled = false;
    }
    else
    {
        scrollview.scrollEnabled = true;
    }
    [self observeKeyboard];

    
     NSLog(@"%s",__PRETTY_FUNCTION__);
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self RemoveObserveKeyboard];
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
    
    if (self.tabBarController.selectedIndex == 1)
    {
//         [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber-1;
        
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
#pragma mark- UITextView delegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if([@"https://PrivacyPolicy" isEqualToString:[NSString stringWithFormat:@"%@",URL]])
    {
        PrivacyPocilyViewController *privacyPolicyobj=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPocilyViewController"];
        privacyPolicyobj.FromPrivacyPolicy = true;
        [self.navigationController pushViewController:privacyPolicyobj animated:YES];
    }
    else if ([@"https://Ihaveread" isEqualToString:[NSString stringWithFormat:@"%@",URL]])
    {
        [self btnCheckMarkClicked:btnCheckmark];
    }
    else if ([@"https://TermsofUse" isEqualToString:[NSString stringWithFormat:@"%@",URL]])
    {
        PrivacyPocilyViewController *privacyPolicyobj=[self.storyboard instantiateViewControllerWithIdentifier:@"PrivacyPocilyViewController"];
        privacyPolicyobj.FromPrivacyPolicy = false;
        [self.navigationController pushViewController:privacyPolicyobj animated:YES];
    }
    return NO;
    
}


#pragma mark -
-(CGSize)cellRowHeight:(NSString *)str
{
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    context.minimumScaleFactor = 0.7;
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName : FontRegular14}];
    CGSize frame = [attributedString2 boundingRectWithSize:CGSizeMake(screenWidth-90-35, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:context].size;
    return frame;
}

#pragma mark - UIButton method
-(void)btnCheckMarkClicked:(UIButton*)btn
{
    NSLog(@"checkmark clicked");
    if (checkmarkSelected== true) {
        [btnCheckmark setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
        checkmarkSelected= false;
    }
    else
    {
        checkmarkSelected = true;
         [btnCheckmark setImage:[UIImage imageNamed:@"checkbox_selected.png"] forState:UIControlStateNormal];

    }
    
}

-(void)btnLeftSideMenuClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnrightClicked
{
    NSLog(@"bell clicked");
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];

    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"device rotaiton %ld",(long)toInterfaceOrientation);
}

-(IBAction)btnpostClicked:(id)sender
{
    if ([txtTitle isFirstResponder])
    {
        [txtTitle resignFirstResponder];
    }
    else if ([txtChooseCategory isFirstResponder])
    {
        [txtChooseCategory resignFirstResponder];
    }
    else if ([txtExpirationDate isFirstResponder])
    {
        [txtExpirationDate resignFirstResponder];
    }
    else if ([txtPrice isFirstResponder])
    {
        [txtPrice resignFirstResponder];
    }

        if (!(imageview.image == nil))
        {
            if (txtTitle.text.length > 0)
            {
                if (txtChooseCategory.text.length >0) {
                    
                    if (txtviewDescription.text.length >0 && ![txtviewDescription.text isEqualToString:@"Description"]) {
                        
                        if (txtPrice.text.length > 0) {
                            
                            if (txtExpirationDate.text.length > 0) {
                                
//                                if (checkmarkSelected == true) {
                                
                                    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
                                    {
                                        [self postDataToserver];
                                    }
                                    else
                                    {
                                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                        [alert show];
                                        
                                    }

//                                }
//                                else
//                                {
//                                    [self.view makeToast:NSLocalizedString(@"Blank_privacy_policy_check_box", nil)];
//                                }
                            }
                            else
                            {
                                [self.view makeToast:NSLocalizedString(@"Blank_Expiry_date", nil)];
                            }
                        }
                        else
                        {
                            [self.view makeToast:NSLocalizedString(@"Blank_Price", nil)];
                        }
                    }
                    else
                    {
                        [self.view makeToast:NSLocalizedString(@"Blank_Description", nil)];
                    }
                }
                else
                {
                    [self.view makeToast:NSLocalizedString(@"Blank_choose_category", nil)];
                }
            }
            else
            {
                [self.view makeToast:NSLocalizedString(@"Blank_Title", nil)];
            }
        }
        else
        {
            [self.view makeToast:@"Please select at least one photo"];
        }
    
   }

-(void)postDataToserver
{
    NSLog(@"postDataToserver");
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
        [dict setValue:txtTitle.text forKey:@"post_title"];
        [dict setValue:[NSString stringWithFormat:@"%d",_universityID] forKey:@"university_id"];
        [dict setValue:[NSString stringWithFormat:@"%d",_CategoryID] forKey:@"post_cat_id"];
        [dict setValue:txtviewDescription.text forKey:@"description"];
        [dict setValue:txtPrice.text forKey:@"price"];
        
        [dict setValue:strCurrentDate forKey:@"create_date"];
        [dict setValue:strExpirationDate forKey:@"expirydate"];
        
        NSMutableArray *arrayImageData = [[NSMutableArray alloc]init];

        NSLog(@"dict %@",dict);

        for (int i = 0; i < imageArray.count; i++)
        {
            UIImageView *imgview = [imageArray objectAtIndex:i];
//            UIImage *img = [self imageWithImage:imgview.image convertToSize:imgsize];
            NSData *imgdata = UIImageJPEGRepresentation([self scaleAndRotateImage:imgview.image], 2.0);//0.2 to 1.0
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
            NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"image_%d",i]]; //Add the file name
            [imgdata writeToFile:filePath atomically:YES]; //Write the file

                        
            NSString *encodingImage = [imgdata base64EncodedStringWithOptions:0];

            [arrayImageData addObject:encodingImage];
        }
        
        [dict setObject:arrayImageData forKey:@"images"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_insert";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_insert" withToken:NO];
    }
    else
    {
         [appDelegate.window makeToast:@"Internet not Available"];
    }
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


-(void)imageViewClicked:(UITapGestureRecognizer*)imgview
{
    imageview = (UIImageView*)imgview.view;
    NSLog(@"imgview %ld",(long)imgview.view.tag);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Pictures Option" message:@"Select Picture Mode" delegate:self
                                         cancelButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    alert.tag = 333;
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView dismissWithClickedButtonIndex:-1 animated:YES];
    if (alertView.tag == 333)
    {
        if (buttonIndex == 0) {
            NSLog(@"camera");
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
               // controller.allowsEditing = YES;
                controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
                controller.delegate = self;
                [self.navigationController presentViewController: controller animated: YES completion: nil];
            }
            
        }
        else if (buttonIndex == 1)
        {
            NSLog(@"Gallery");
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
            {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
              //  controller.allowsEditing = YES;
                controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
                controller.delegate = self;
                [self.navigationController presentViewController: controller animated: YES completion: nil];
            }
            
        }
    }
    
}
#pragma mark - ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:chosenImage cropMode:RSKImageCropModeSquare];
        imageCropVC.delegate = self;
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }];

   /* for (UIView *subview in [viewphoto subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imaegviewRemove = (UIImageView *)subview;
            if (imaegviewRemove.tag ==  imageview.tag)
            {
                imageview = imaegviewRemove;
                
            }

            if (imaegviewRemove.tag ==  imageview.tag+1)
            {
                imaegviewRemove.userInteractionEnabled = YES;
            }
        }
    }


    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    imageview.image = chosenImage;
    if (!imageArray) {
        imageArray = [[NSMutableArray alloc]init];
        
    }
    [imageArray addObject:imageview];*/
   // [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITextfieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if (!ipadDevice) {
//        scrollview.contentOffset = CGPointMake(0, textField.tag*25);
//    }
    
    if ([textField isEqual:txtChooseCategory])
    {
        if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        CategoryListViewController *categoryObj = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryListViewController"];
        categoryObj.userId = _userID;
        categoryObj.delegate = self;
        [self.navigationController pushViewController:categoryObj animated:NO];
        [textField resignFirstResponder];
        }
        
        else
        {
            [appDelegate.window makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];

        }
        return NO;
        
    }
    else if ([textField isEqual:txtExpirationDate])
    {
        datepicker = [[UIDatePicker alloc]init];
        datepicker.datePickerMode = UIDatePickerModeDate;
        datepicker.backgroundColor = [UIColor whiteColor];
        
        [datepicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        //now preparing the toolbar which will be displayed at the top of the datePicker
        UIToolbar  *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight-datepicker.frame.size.height, screenWidth, 44)];
        pickerToolbar.barStyle=UIBarStyleDefault;
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked:)];
        done.tintColor = txtFieldTextColor;
        [pickerToolbar setItems:[[NSArray alloc] initWithObjects: done, nil]];
        
        txtExpirationDate.inputView = datepicker;
        txtExpirationDate.inputAccessoryView = pickerToolbar;
        
    }
    else if ([textField isEqual:txtPrice])
    {
        txtPrice.keyboardType = UIKeyboardTypeDecimalPad;
        //now preparing the toolbar which will be displayed at the top of the datePicker
        UIToolbar  *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight-255, screenWidth, 44)];
        pickerToolbar.barStyle=UIBarStyleDefault;
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked:)];
        done.tintColor = txtFieldTextColor;
        [pickerToolbar setItems:[[NSArray alloc] initWithObjects: done, nil]];
        
        txtPrice.inputAccessoryView = pickerToolbar;

    }

    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:txtTitle]) {
        txtTitle.text = textField.text;
        [txtTitle resignFirstResponder];
    }
    else if ([textField isEqual:txtPrice])
    {
        txtPrice.text = textField.text;
    }
    else if ([textField isEqual:txtChooseCategory])
    {
        [textField resignFirstResponder];
    }
    
        
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([txtTitle isFirstResponder])
    {
        [txtTitle resignFirstResponder];
    }
    else if ([txtChooseCategory isFirstResponder])
    {
        [txtChooseCategory resignFirstResponder];
    }
    else if ([txtExpirationDate isFirstResponder])
    {
        [txtExpirationDate resignFirstResponder];
    }
    else if ([txtPrice isFirstResponder])
    {
        [txtPrice resignFirstResponder];
    }
//    if (!ipadDevice) {
//        [scrollview setContentOffset:CGPointMake(0,0) animated:YES];
//
//    }
    return YES;
}

#pragma mark - UITextView Deleagte
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView isEqual:txtviewDescription])
    {
        //now preparing the toolbar which will be displayed at the top of the keyboard
        UIToolbar  *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, screenWidth, 44)];
        pickerToolbar.barStyle=UIBarStyleDefault;
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked:)];
        done.tintColor = txtFieldTextColor;
        [pickerToolbar setItems:[[NSArray alloc] initWithObjects: done, nil]];
        [textView setInputAccessoryView:pickerToolbar];
        
    }

    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
   
    if ([textView.text isEqualToString:@"Description"]) {
        textView.text = @"";
        textView.textColor = txtFieldTextColor;
    }
    

}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView isEqual:txtviewDescription]) {
        txtviewDescription.text = textView.text;
        txtviewDescription.textColor = txtFieldTextColor;
    }
    if (textView.text.length < 1) {
        txtviewDescription.text = @"Description";
        txtviewDescription.textColor = [UIColor colorWithRed:195.0/255.0 green:194.0/255.0 blue:201.0/255.0 alpha:1.0];;
    }
}
#pragma mark - Datepicker method
- (void)datePickerValueChanged:(id)sender
{
    if ( [ datepicker.date timeIntervalSinceNow ] < 0 )
        datepicker.date = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:30];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [datepicker setMaximumDate:maxDate];


    NSString *dateString;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateString = [dateFormat stringFromDate:[datepicker date]];
//    [txtExpirationDate setText:dateString];
    strExpirationDate = dateString;//txtExpirationDate.text;
    
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    dateString = [dateFormat stringFromDate:[datepicker date]];
    [txtExpirationDate setText:dateString];


    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateString = [dateFormat1 stringFromDate:[NSDate date]];

    strCurrentDate =dateString;
}

-(IBAction)doneButtonClicked:(id)sender
{
    if ([txtExpirationDate isFirstResponder]) {
        [txtExpirationDate resignFirstResponder];
    }
    if ([txtPrice isFirstResponder]) {
        [txtPrice resignFirstResponder];
    }
    if ([txtviewDescription isFirstResponder]) {
        [txtviewDescription resignFirstResponder];
    }
    
    NSString *dateString;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateString = [dateFormat stringFromDate:[datepicker date]];
    //    [txtExpirationDate setText:dateString];
    strExpirationDate = dateString;//txtExpirationDate.text;
    
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    dateString = [dateFormat stringFromDate:[datepicker date]];
    [txtExpirationDate setText:dateString];
    
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // Prevent adjustment to user's local time zone.
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateString = [dateFormat1 stringFromDate:[NSDate date]];
    
    strCurrentDate =dateString;

//    if (!ipadDevice) {
//        [scrollview setContentOffset:CGPointMake(0,0) animated:YES];
//
//    }
    NSLog(@"donebutton clicked %@",sender);
}

#pragma mark -  Delegate Method
-(void)selectCategoryName:(NSString *)name id:(NSString *)UniversityId
{
    txtChooseCategory.text  = name;
    _CategoryID = [UniversityId intValue];
}
#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    int status = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    if (status == 201)
    {
        if ([nState isEqualToString:@"post_insert"])
        {
            HideNetworkActivityIndicator();
//            [self.view makeToast:@"New Post has been created"];
            txtTitle.text = @"";
            txtChooseCategory.text = @"";
            txtviewDescription.text = @"";
            if (txtviewDescription.text.length < 1) {
                txtviewDescription.text = @"Description";
                txtviewDescription.textColor = [UIColor colorWithRed:195.0/255.0 green:194.0/255.0 blue:201.0/255.0 alpha:1.0];;
            }

            txtPrice.text = @"";
            txtExpirationDate.text = @"";
            [btnCheckmark setImage:[UIImage imageNamed:@"checkbox_unselected.png"] forState:UIControlStateNormal];
            checkmarkSelected= false;
            
            [imageArray removeAllObjects];
            
            for (UIView *subview in [viewphoto subviews])
            {
                    if ([subview isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *imaegviewRemove = (UIImageView *)subview;
                        imaegviewRemove.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",(int)imaegviewRemove.tag]];
                    }
            }

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"New post has been created." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 444;
            [alert show];
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
        [self.view makeToast:@"Bad Request due to invalid parameters."];
    }
    
    else if (strstatuscode == 500)
    {
        HideNetworkActivityIndicator();
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
//MARK:- KeyBoard
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
    
    keyboardHeight.constant=height-85;
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        [self.view layoutIfNeeded]
        ;
    }];
        
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    keyboardHeight.constant = 0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}
#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
    for (UIView *subview in [viewphoto subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imaegviewRemove = (UIImageView *)subview;
            if (imaegviewRemove.tag ==  imageview.tag)
            {
                imageview = imaegviewRemove;
                
            }
            
            if (imaegviewRemove.tag ==  imageview.tag+1)
            {
                imaegviewRemove.userInteractionEnabled = YES;
            }
        }
    }
    
    
    imageview.image = croppedImage;
    if (!imageArray) {
        imageArray = [[NSMutableArray alloc]init];
        
    }
    [imageArray addObject:imageview];
    [self.navigationController popViewControllerAnimated:YES];
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
