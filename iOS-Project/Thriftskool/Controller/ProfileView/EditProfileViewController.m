//
//  EditProfileViewController.m
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "EditProfileViewController.h"
#import "MessageDetailViewController.h"
#import "MyPostDetailViewController.h"
#import "BuzzDetailViewController.h"
#import "RSKImageCropViewController.h"

#define kLabelHeight 18
#define labelYPos 15
#define xPos 10

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"EDIT PROFILE";
    
     tblEditProfile.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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
    btnleftside.frame = CGRectMake(0, 0, 20.0, 50.0);
    [btnleftside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleftside setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [btnleftside addTarget:self action:@selector(btnBackBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewleftside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20.0, 50.0)];
    viewleftside.bounds = CGRectOffset(viewleftside.bounds, 0, 0);
    [viewleftside addSubview:btnleftside];
    UIBarButtonItem *barleftside = [[UIBarButtonItem alloc]initWithCustomView:viewleftside];
    self.navigationItem.leftBarButtonItem = barleftside;
    
    
   

    
    tblEditProfile.backgroundColor = tableBackgroundColor;
    tblEditProfile.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = tableBackgroundColor;
    //UIbutton
    
    btnAddPhoto = [[UIButton alloc]initWithFrame:CGRectMake((screenWidth-80)/2, 12, 80, 80)];
    [btnAddPhoto setTitle:NSLocalizedString(@"  Add\nPhoto", nil) forState:UIControlStateNormal];
    btnAddPhoto.titleLabel.numberOfLines=2;
    btnAddPhoto.titleLabel.font = FontRegular14;
    [btnAddPhoto setImage:[UIImage imageNamed:@"addphoto.png"] forState:UIControlStateNormal];
    [btnAddPhoto addTarget:self action:@selector(btnAddPhotoClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnAddPhoto setTitleColor:txtFieldTextColor forState:UIControlStateNormal];
    //btnAddPhoto.contentMode = UIViewContentModeScaleAspectFit;
    btnAddPhoto.layer.cornerRadius = 40;
    btnAddPhoto.clipsToBounds = YES;
    //btnAddPhoto.layer.borderWidth=1.0f;
  //  [btnAddPhoto.layer setBorderColor:txtFieldTextColor.CGColor];
    isChangePhoto = false;

    self.btnSave.layer.cornerRadius = 6.0;
    
    
    // ============
    
    toolbar  = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight-400, screenWidth, 44)];
    toolbar.barStyle=UIBarStyleDefault;
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(btnDoneClicked:)];
   // done.tintColor = navigationBarColor;
    [toolbar setItems:[[NSArray alloc] initWithObjects: done, nil]];
    
   
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceived:) name:@"pushNotification" object:nil];

    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(incrementBadge:)
                                   userInfo:nil
                                    repeats:YES];
    UISwipeGestureRecognizer *swipetap = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swipetap.direction = UISwipeGestureRecognizerDirectionRight;
    swipetap.delegate = self;
    [self.view addGestureRecognizer:swipetap];
    
    //=============    Add In UItableview cell
    
    //=======  UILabel =====
    self.lblUniversityName = [[UILabel alloc] initWithFrame:CGRectMake(xPos+8,labelYPos,screenWidth-(20+16),kLabelHeight)];
    self.lblUniversityName.text=@"Select university";
    self.lblUniversityName.textAlignment=NSTextAlignmentLeft;
    self.lblUniversityName.font= FontBold16;
    self.lblUniversityName.textColor = txtFieldTextColor;
    self.lblUniversityName.backgroundColor=[UIColor whiteColor];

   
    
    self.lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(xPos+8,labelYPos,screenWidth-(20+16),kLabelHeight)];
    self.lblEmail.text=@"Email address";
    self.lblEmail.textAlignment=NSTextAlignmentLeft;
    self.lblEmail.font= FontBold16;
    self.lblEmail.textColor = txtFieldTextColor;
    self.lblEmail.backgroundColor=[UIColor whiteColor];

    
    self.lblName = [[UILabel alloc] initWithFrame:CGRectMake(xPos+8,labelYPos,screenWidth-(20+16),kLabelHeight)];
    self.lblName.text=@"Name";//@"Position";
    self.lblName.textAlignment=NSTextAlignmentLeft;
    self.lblName.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblName.numberOfLines = 2;
    self.lblName.font= FontBold16;
    self.lblName.textColor = txtFieldTextColor;
    self.lblName.backgroundColor=[UIColor whiteColor];
    
    self.lblClassName = [[UILabel alloc] initWithFrame:CGRectMake(xPos+8,labelYPos,screenWidth-(20+16),kLabelHeight)];
    self.lblClassName.text=@"Class";
    self.lblClassName.textAlignment=NSTextAlignmentLeft;
    self.lblClassName.font= FontBold16;
    self.lblClassName.textColor = txtFieldTextColor;
    self.lblClassName.backgroundColor=[UIColor whiteColor];

    
    self.lblUserName = [[UILabel alloc] initWithFrame:CGRectMake(xPos+8,labelYPos,screenWidth-(20+16),kLabelHeight)];
    self.lblUserName.text=@"Username";
    self.lblUserName.textAlignment=NSTextAlignmentLeft;
    self.lblUserName.font= FontBold16;
    self.lblUserName.textColor = txtFieldTextColor;
    self.lblUserName.backgroundColor=[UIColor whiteColor];

    
    //=== UItextFiled
    self.txtuniversityName = [self textFieldAllocation: self.txtuniversityName txtIndex:1];
    // self.txtuniversityName.placeholder = @"First Name";
    //self.txtuniversityName.enabled=NO;
    
    self.txtEmail = [self textFieldAllocation:self.txtEmail txtIndex:2];
   // self.txtEmail.placeholder = @"Last Name";
    self.txtEmail.keyboardType = UIKeyboardTypeDefault;
    self.txtEmail.inputAccessoryView = toolbar;
    
    
    self.txtName = [self textFieldAllocation:self.txtName txtIndex:3];
//    self.txtName.placeholder = @"Office Running For";
    self.txtName.keyboardType = UIKeyboardTypeDefault;
    self.txtName.inputAccessoryView = toolbar;
    
    
    self.txtClassName = [self textFieldAllocation:self.txtClassName txtIndex:4];
//    self.txtClassName.placeholder = @"Party Name";
    self.txtClassName.keyboardType = UIKeyboardTypeDefault;
   self.txtClassName.enabled=NO;
    
    self.txtUserName = [self textFieldAllocation:self.txtUserName txtIndex:5];
//    self.txtUserName.placeholder = @"Party Name";
    self.txtUserName.keyboardType = UIKeyboardTypeDefault;
    self.txtUserName.inputAccessoryView = toolbar;

    
    // UItextfiled
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btn.frame = CGRectMake(0, -10, 20.0, 20.0);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleRight] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(universityListClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.txtuniversityName.rightView = btn;
    [self.txtuniversityName setRightViewMode:UITextFieldViewModeAlways];
    classid=@"";
    [self callWebserviceForClassList];
    if(!isChangePhoto)
    {
        [self setTextFieldFromLoginDetail];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}



-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = false;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    if([self.txtName isFirstResponder] || [self.txtUserName isFirstResponder])
    {
        
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height-110), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    tblEditProfile.contentInset = contentInsets;
    tblEditProfile.scrollIndicatorInsets = contentInsets;
        if([self.txtName isFirstResponder])
        {
            NSIndexPath *indexPath =[NSIndexPath indexPathForRow:3 inSection:0];
            [tblEditProfile scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        else
        {
            NSIndexPath *indexPath =[NSIndexPath indexPathForRow:5 inSection:0];
            [tblEditProfile scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
   
    }
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(64, 0.0,0, 0.0);
    }
    tblEditProfile.contentInset = contentInsets;
    tblEditProfile.scrollIndicatorInsets = contentInsets;
}
#pragma mark - Class list Web service
-(void)callWebserviceForClassList
{
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"get_class";
        //            [[ConnectionServer sharedConnectionWithDelegate:self]getDataFromServer:@"university_list"];
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:nil caseName:@"get_class" withToken:NO];
        
    }
    else
    {
        [self.view makeToast:NSLocalizedString(@"InternetAvailable", nil)];
    }

}
-(void)setTextFieldFromLoginDetail
{
    if([_dicProfileDetail objectForKey:@"university_name"])
    {
        if(![[_dicProfileDetail objectForKey:@"university_name"] isKindOfClass:[NSNull class]])
        {
            self.txtuniversityName.text = [_dicProfileDetail valueForKey:@"university_name"];
        }
    }
    if([_dicProfileDetail objectForKey:@"email_id"])
    {
        if(![[_dicProfileDetail objectForKey:@"email_id"] isKindOfClass:[NSNull class]])
        {
            self.txtEmail.text = [_dicProfileDetail valueForKey:@"email_id"];
        }
    }
    if([_dicProfileDetail objectForKey:@"user_name"])
    {
        if(![[_dicProfileDetail objectForKey:@"user_name"] isKindOfClass:[NSNull class]])
        {
            self.txtUserName.text = [_dicProfileDetail valueForKey:@"user_name"];
        }
    }
    if([_dicProfileDetail objectForKey:@"class"])
    {
        if(![[_dicProfileDetail objectForKey:@"class"] isKindOfClass:[NSNull class]])
        {
            self.txtClassName.text = [_dicProfileDetail valueForKey:@"class"];
        }
    }
    if([_dicProfileDetail objectForKey:@"person_name"])
    {
        if(![[_dicProfileDetail objectForKey:@"person_name"] isKindOfClass:[NSNull class]])
        {
            self.txtName.text = [_dicProfileDetail valueForKey:@"person_name"];
        }
    }
    if([_dicProfileDetail objectForKey:@"profile_img"])
    {
        NSString *strImagepath = [_dicProfileDetail valueForKey:@"profileimgpath"];
        NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[_dicProfileDetail valueForKey:@"profile_img"]];
        [self setOwnerProfileImage:str];
    }
}
-(void)setOwnerProfileImage:(NSString*)strImageUrl
{
    [btnAddPhoto setImage:[UIImage imageNamed:@"addphoto.png"] forState:UIControlStateNormal];

    NSString *strImage = strImageUrl;
    
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
            checkProfileImageisDefault=NO;

            [btnAddPhoto setImage:(UIImage*)image forState:UIControlStateNormal];
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     checkProfileImageisDefault=NO;

                     [btnAddPhoto setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];

                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                 }
             }];
        }
        
    }
    else
    {
        checkProfileImageisDefault=YES;
        [btnAddPhoto setImage:[UIImage imageNamed:@"addphoto.png"] forState:UIControlStateNormal];

    }
    
}

#pragma mark -  UITableView Delegate and DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if(indexPath.row>0)
        {
            UIView* backview = [[UIView alloc] initWithFrame:CGRectMake(xPos, 10, screenWidth-20, 18+32+10)];/// change size as you need.
            backview.backgroundColor = [UIColor whiteColor];// you can also put image here
            [cell.contentView addSubview:backview];
        }
         cell.backgroundColor=tableBackgroundColor;
        
            if (indexPath.row == 0)
            {
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell.contentView addSubview:btnAddPhoto];
            }
            else if (indexPath.row == 1)
            {
                [cell.contentView addSubview:_txtuniversityName];
                [cell addSubview:_lblUniversityName];
                //  [cell addSubview:lblAstreik];
            }
            else if (indexPath.row == 2)
            {
                [cell.contentView addSubview:_txtEmail];
                [cell.contentView addSubview:_lblEmail];
            }
            else if (indexPath.row == 3)
            {
                [cell.contentView addSubview:_txtName];
                [cell.contentView addSubview:_lblName];
            }
            else if (indexPath.row==4)
            {
                [cell.contentView addSubview:_txtClassName];
                [cell.contentView addSubview:_lblClassName];
            }
            else if (indexPath.row == 5)
            {
                [cell.contentView addSubview:_txtUserName];
                [cell.contentView addSubview:_lblUserName];
                
            }
          
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  _txtuniversityName.userInteractionEnabled = NO;
    _txtClassName.userInteractionEnabled = NO;
    
    if(indexPath.row==1)
    {
        [self keyboardDismiss];

        [self displyAlertView];
    }
    if (indexPath.row == 4)
    {
        [self keyboardDismiss];
        if([arrClassList count]>0)
            [self popClickAction:indexPath];
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 100;
    }
       return 70;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        cell.preservesSuperviewLayoutMargins = NO;
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
#pragma mark -
-(void)btnAddPhotoClicked:(id)sender
{
    NSLog(@"btnadd photo clicked");
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Select image" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    //    alert.tag = 99;
    //    [alert show];
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc]initWithTitle:@"Select image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    if (ipadDevice)
    {
        [actionsheet showFromRect:CGRectMake(0, screenHeight/2, screenWidth, 60) inView:self.view animated:YES];
        //        [actionsheet showInView:self.view];
        
    }
    else
    {
        [actionsheet showInView:self.view];
    }
    
}
#pragma mark -  UIImagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
//    isChangePhoto = true;
//    checkProfileImageisDefault=NO;
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:chosenImage cropMode:RSKImageCropModeSquare];
        imageCropVC.delegate = self;
        [self.navigationController pushViewController:imageCropVC animated:YES];
    }];
    
   /* [btnAddPhoto setImage:chosenImage forState:UIControlStateNormal];
    
    //    candidateImg = chosenImage;
    btnAddPhoto.clipsToBounds = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url; //= [NSURL URLWithString:[dicCanProfileDetail valueForKey:@"image"]];
    NSString *cacheFilename = [url lastPathComponent];
    
    int index = (int)([url pathComponents].count)-3;
    NSString *folderName =[[url pathComponents] objectAtIndex:index];
    
    //    NSLog(@"folderName %@",folderName);
    NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];
    
    id image1 = [LazyLoadingImage imageDataFromPath:cachePath];
    
    if(image1)
    {
        [fileManager removeItemAtPath:cachePath error:nil];
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];*/
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - Action handling

- (void)onAddPhotoButtonTouch:(UIButton *)sender
{
//    UIImage *photo = [UIImage imageNamed:@"photo"];
//    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:photo cropMode:RSKImageCropModeCircle];
//    imageCropVC.delegate = self;
    //[self.navigationController pushViewController:imageCropVC animated:YES];
}

#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
    isChangePhoto = true;
    checkProfileImageisDefault=NO;
    [btnAddPhoto setImage:croppedImage forState:UIControlStateNormal];
    
    //    candidateImg = chosenImage;
    btnAddPhoto.clipsToBounds = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url; //= [NSURL URLWithString:[dicCanProfileDetail valueForKey:@"image"]];
    NSString *cacheFilename = [url lastPathComponent];
    
    int index = (int)([url pathComponents].count)-3;
    NSString *folderName =[[url pathComponents] objectAtIndex:index];
    
    //    NSLog(@"folderName %@",folderName);
    NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];
    
    id image1 = [LazyLoadingImage imageDataFromPath:cachePath];
    
    if(image1)
    {
        [fileManager removeItemAtPath:cachePath error:nil];
    }

    [self.navigationController popViewControllerAnimated:YES];
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
-(void)universityListClicked:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"If you change your university all of your posts, deals, and data will be cleared. Do you still want to change your university?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    [self.txtuniversityName resignFirstResponder];
}
-(void)btnDoneClicked:(id)sender
{
    NSLog(@"Done Button Clicked");
    [self keyboardDismiss];
    
}
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

-(IBAction)btnSaveClicked:(id)sender
{
    
    [self keyboardDismiss];
    if (self.txtuniversityName.text.length>1)
    {
        if (self.txtEmail.text.length>1)
        {
            
            if (self.txtUserName.text.length > 1)
            {
                _strUserName = self.txtUserName.text;
                _strEmail = self.txtEmail.text;
                
                if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
                {
                    self.navigationController.view.userInteractionEnabled = false;
                    self.tabBarController.view.userInteractionEnabled = false;
                    
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    

                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
                    
                    if (_struniversityID == nil)
                    {
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        NSArray *arrtemp=[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"loginArray"]];
                        NSArray *arr =  [arrtemp valueForKey:@"Response"];
                       
                        
                        _struniversityID = [arr valueForKey:@"university_id"];
                    }
                    
                    [dict setValue:_struniversityID forKey:@"university_id"];
                    [dict setValue:self.txtEmail.text forKey:@"email_id"];
                    [dict setValue:self.txtUserName.text forKey:@"var_username"];
                    UIImage *img = [btnAddPhoto imageForState:UIControlStateNormal];
                    if(checkProfileImageisDefault)
                    {
                         [dict setValue:@"" forKey:@"profile_img"];
                    }
                    else
                    {
                        NSData *imgdata = UIImageJPEGRepresentation([self scaleAndRotateImage:img],2.0);
                        
                        NSString *encodingImage = [imgdata base64EncodedStringWithOptions:0];
                        [dict setValue:encodingImage forKey:@"profile_img"];

                    }
                    
                    
                    
                    [dict setValue:self.txtName.text forKey:@"person_name"];
                    
                    [dict setValue:classid forKey:@"class"];


                    NSLog(@"dict %@",dict);
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"edit_profile";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"edit_profile" withToken:NO];
                    
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setValue:dict forKey:@"edit_profileInfo"];
                    [defaults synchronize];
                }
                else
                {
                    //        [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                }
                
            }
            else
            {
                [self.view makeToast:NSLocalizedString(@"Blank_username",nil)];
            }
        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"Blank_email_address",nil)];
        }
    }
    else{
        [self.view makeToast:NSLocalizedString(@"Blank_university_name",nil)];
    }
}

#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.txtuniversityName isFirstResponder]) {
        [self.txtuniversityName resignFirstResponder];
    }
    
    else if ([self.txtEmail isFirstResponder])
    {
        [self.txtEmail resignFirstResponder];
    }
    
    else if ([self.txtUserName isFirstResponder])
    {
        [self.txtUserName resignFirstResponder];
    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 2) {
//        NSArray *arr =[_strEmail componentsSeparatedByString:@"@"];
        if (domainName1 == nil)
        {
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSArray *arrtemp=[NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:@"loginArray"]];
             NSArray *arr=[arrtemp valueForKey:@"Response"];
           // NSArray *arr =  [[defaults valueForKey:@"loginArray"] valueForKey:@"Response"];
            if (arr == nil) {
                arr = [defaults valueForKey:@"loginArray"];
            }
            
            NSArray *arrdomain = [[arr valueForKey:@"email_id"] componentsSeparatedByString:@"@"];
            domainName1 = [arrdomain objectAtIndex:1];

        }
        
        if (textField.text.length > 0) {
        self.txtEmail.text = [textField.text stringByAppendingString:[NSString stringWithFormat:@"@%@",domainName1]];
        }
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.txtUserName)
    {
        if ([string isEqualToString:@" "] )
        {
            return false;
        }
    }
    return true;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.tag == 1) {
        // UniversityList1ViewController *universityObj = [self.storyboard instantiateViewControllerWithIdentifier:@"UniversityList1ViewController"];
        //[self.navigationController pushViewController:universityObj animated:NO];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"If you change your university all of your posts, deals, and data will be cleared. Do you still want to change your university?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
        [textField resignFirstResponder];
    }
    if (textField.tag == 2) {
        NSArray *array =[textField.text componentsSeparatedByString:@"@"];
        textField.text = [array objectAtIndex:0];
    }
//    if(textField.tag==5)
//    {
//        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:5 inSection:0];
//        [tblEditProfile scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//    }
    
}
-(UITextField*)textFieldAllocation:(UITextField*)txtField txtIndex:(int)tIndex
{
    txtField = [[UITextField alloc]initWithFrame:CGRectMake(xPos+8,labelYPos+kLabelHeight,screenWidth-(20+16), 32)];
    txtField.text=@"";
    txtField.delegate = self;
    txtField.textAlignment= NSTextAlignmentLeft;
    txtField.font = FontRegular16;
    txtField.backgroundColor=[UIColor clearColor];
    txtField.textColor = txtFieldTextColor;
    txtField.tag=tIndex;
    txtField.backgroundColor=[UIColor whiteColor];
    
    return txtField;
}

#pragma mark - 
-(void)displyAlertView
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"If you change your university all of your posts, deals, and data will be cleared. Do you still want to change your university?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    if ([self.txtuniversityName isFirstResponder]) {
        [self.txtuniversityName resignFirstResponder];
    }

}
#pragma mark- Alert delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1) {
        UniversityListViewController *universityObj = [self.storyboard instantiateViewControllerWithIdentifier:@"UniversityListViewController"];
        universityObj.delegate = self;
        [self.navigationController pushViewController:universityObj animated:NO];

    }
}

#pragma mark - Connection method
-(void)ConnectionDidFinish:(NSString *)nState Data:(NSString *)nData statuscode:(NSInteger)strstatuscode
{
    NSArray *arry = [nData JSONValue];
    NSLog(@"array %@",arry);
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;

    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    int status = [[[arry valueForKey:@"Response"] valueForKey:@"status"] intValue];
    if([nState isEqualToString:@"get_class"])
    {
        if(strstatuscode==200)
        {
            arrClassList=[[arry valueForKey:@"Response"] valueForKey:@"Details"];
            if([arrClassList count]>0)
            {
            if([_dicProfileDetail objectForKey:@"class"])
            {
                if(![[_dicProfileDetail objectForKey:@"class"] isKindOfClass:[NSNull class]])
                {
                    classid = [_dicProfileDetail valueForKey:@"class"] ;
                    if([classid isEqualToString:@"0"])
                    {
                         self.txtClassName.text = @"";
                    }
                    else
                    {
                        NSArray *filtered = [arrClassList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(int_glcode == %@)", classid]];
                        if([filtered count]>0)
                        {
                            NSDictionary *dicTemp = [filtered objectAtIndex:0];
                            
                            self.txtClassName.text = [dicTemp valueForKey:@"class_name"];

                        }
                    }
                    
                }
            }
            }
        }
    }
    else
    {
        if (strstatuscode == 500) {
            [self.view makeToast:@"Internal server error"];
        }
        if (status == 204)
        {
            [appDelegate.tabviewControllerObj.profileObj.view makeToast:@"Your profile has been updated"];
            appDelegate.tabviewControllerObj.profileObj.strUniversityName = _strUniversityName;
            appDelegate.tabviewControllerObj.profileObj.strUsername = _strUserName;
            appDelegate.tabviewControllerObj.profileObj.strUniversityImageName = _strUniversityImageName;
            [self.navigationController popViewControllerAnimated:YES];

            
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:_strEmail forKey:@"email_id"];
            [dict setValue:[NSString stringWithFormat:@"http://www.etilox.com/clients/thriftskool/mobileapp/upimages/university_management/images/"] forKey:@"imagepath"];
            [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"login_id"];
            [dict setValue:_struniversityID forKey:@"university_id"];
            [dict setValue:_strUniversityImageName forKey:@"university_image"];
            [dict setValue:self.txtuniversityName.text forKey:@"university_name"];
            [dict setValue:self.txtUserName.text forKey:@"user_name"];
            [dict setValue:self.txtuniversityName.text forKey:@"university_name"];
            [dict setValue:classid forKey:@"class"];
            [dict setValue:self.txtName.text forKey:@"person_name"];

            if([[arry valueForKey:@"Response"] valueForKey:@"profileimg"])
            {
                [dict setValue:[[arry valueForKey:@"Response"] valueForKey:@"profileimg"] forKey:@"profile_img"];
            }
            else
            {
                [dict setValue:@"<null>" forKey:@"profile_img"];

            }
            if([[arry valueForKey:@"Response"] valueForKey:@"profileimgpath"])
            {
                [dict setValue:[[arry valueForKey:@"Response"] valueForKey:@"profileimgpath"] forKey:@"profileimgpath"];
            }
           else
               
           {
                [dict setValue:@"" forKey:@"profileimgpath"];
           }

           
             if([[arry valueForKey:@"Response"] valueForKey:@"profileimg"])
             {
                  NSString *strpath = [NSString stringWithFormat:@"%@%@",[dict valueForKey:@"profileimgpath"],[dict valueForKey:@"profile_img"]];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSURL *url= [NSURL URLWithString:strpath];
                NSString *cacheFilename = [url lastPathComponent];
                
                int index = (int)([url pathComponents].count)-3;
                NSString *folderName =[[url pathComponents] objectAtIndex:index];
                
                //    NSLog(@"folderName %@",folderName);
                NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];
                
                id image1 = [LazyLoadingImage imageDataFromPath:cachePath];
                
                if(image1)
                {
                    [fileManager removeItemAtPath:cachePath error:nil];
                }
             }
            NSMutableDictionary *dicResponse = [[NSMutableDictionary alloc]init];
            [dicResponse setObject:dict forKey:@"Response"];
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dicResponse];
            [defaults setObject:data forKey:@"loginArray"];
            //            [defaults setValue:dictUniversityList forKey:@"loginArray"];
            [defaults synchronize];
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setValue:dict forKey:@"loginArray"];

        }
        else
        {
            NSString *str = [[arry valueForKey:@"Response"] valueForKey:@"message"];
            [self.view makeToast:str];
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
#pragma mark - Delegate Mehtod
- (void)selectUniversityName:(NSString *)name domain:(NSString *)domainName id:(NSString *)UniversityId imgName:(NSString *)UniImageName
{
    if (domainName != nil)
    {
        if ([self.txtuniversityName.text isEqualToString:name])
        {
            NSArray *arrya = [self.txtEmail.text componentsSeparatedByString:@"@"];
            _strEmail = [self.txtEmail.text stringByReplacingOccurrencesOfString:[arrya objectAtIndex:1] withString:domainName];
            
        }
        else
        {
            _strEmail = @"";
            self.txtEmail.text= @"";
        }
        
        self.txtuniversityName.text = name;
        _strUniversityName = name;
        _struniversityID = UniversityId;
        domainName1 = domainName;
        _strUniversityImageName = UniImageName;
    }
    
    [tblEditProfile reloadData];
}
# pragma mark - UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"button Index %ld",(long)buttonIndex);
    if (buttonIndex == 0)
    {
        isChangePhoto = true;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
          ///  controller.allowsEditing = YES;
            controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
            controller.delegate = self;
            
            if (ipadDevice) {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [self presentViewController:controller animated:YES completion:nil];
                });
            }
            else
            {
                [self.navigationController presentViewController: controller animated: YES completion: nil];
                
            }
            
        }
        
    }
    
    else if (buttonIndex == 1)
    {
        isChangePhoto = true;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
           // controller.allowsEditing = YES;
            controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
            controller.delegate = self;
            if (ipadDevice) {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    [self presentViewController:controller animated:YES completion:nil];
                });
            }
            else
            {
                [self.navigationController presentViewController: controller animated: YES completion: nil];
                
            }
        }
        
    }
    
}
-(void)keyboardDismiss
{
    if ([_txtuniversityName isFirstResponder]) {
        [_txtuniversityName resignFirstResponder];
    }
    
    if ([_txtName isFirstResponder]) {
        [_txtName resignFirstResponder];
    }
    
    if ([_txtEmail isFirstResponder]) {
        [_txtEmail resignFirstResponder];
    }
    
    if ([_txtUserName isFirstResponder]) {
        [_txtUserName resignFirstResponder];
    }
    
    if ([self.txtClassName isFirstResponder]) {
        [self.txtClassName resignFirstResponder];
    }
    
}
- (void)popClickAction:(NSIndexPath*)selecIndexPath
{
    CGRect rectOfCellInTableView = [tblEditProfile rectForRowAtIndexPath: selecIndexPath];
    CGRect rectOfCellInSuperview = [tblEditProfile convertRect: rectOfCellInTableView toView: tblEditProfile.superview];
    
    NSLog(@"Y of Cell is: %f", rectOfCellInSuperview.origin.y);
    CGFloat xWidth = self.view.bounds.size.width - 40.0f;
    CGFloat yHeight = 270;
    CGFloat yOffset = rectOfCellInSuperview.origin.y;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(20, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = TRUE;
    [poplistview show];
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier] ;
    
    int row = (int)indexPath.row;
    NSDictionary *dicClass = [arrClassList objectAtIndex:row];
    cell.textLabel.text=[dicClass valueForKey:@"class_name"];
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [arrClassList count];
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    // your code here
    classid = [[arrClassList objectAtIndex:indexPath.row] valueForKey:@"int_glcode"] ;
    if([classid isEqualToString:@"0"])
    {
        self.txtClassName.text = @"";
    }
    else
    {
        self.txtClassName.text=[[arrClassList objectAtIndex:indexPath.row] valueForKey:@"class_name"];
    }
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
#pragma Cropping Image
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
