//
//  EditPostViewController.m
//  Thriftskool
//
//  Created by Asha on 15/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "EditPostViewController.h"
#import "CategoryListViewController.h"

@interface EditPostViewController ()

@end

@implementation EditPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = _strTitleName;
    
    
    //Rigth Side Button
    UIButton *btnright = [UIButton buttonWithType:UIButtonTypeCustom];
    btnright.titleLabel.font = [UIFont fontWithName:FontTypeName size:20.0];
    [btnright setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnright setTitle:[NSString fontAwesomeIconStringForEnum:FABellO] forState:UIControlStateNormal];
    btnright.frame = CGRectMake(0,1, 30.0, 20.0);
    [btnright addTarget:self action:@selector(btnNotificationClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnRightBellView = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 30, 22)];
    btnRightBellView.bounds = CGRectOffset(btnRightBellView.bounds, 0,0);
    [btnRightBellView addSubview:btnright];
    UIBarButtonItem *bellBtn = [[UIBarButtonItem alloc]initWithCustomView:btnRightBellView];
    self.navigationItem.rightBarButtonItem = bellBtn;
    
    
    // Left Side Button
    UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleft.titleLabel.font = [UIFont fontWithName:FontTypeName size:30.0];
    [btnleft setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btnleft setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    btnleft.frame = CGRectMake(0, -4, 20.0, 30.0);
    [btnleft addTarget:self action:@selector(btnBackClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnLeftSideMenu = [[UIView alloc]initWithFrame:CGRectMake(0,-40, 20, 22)];
    btnLeftSideMenu.bounds = CGRectOffset(btnLeftSideMenu.bounds, 0,0);
    [btnLeftSideMenu addSubview:btnleft];
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc]initWithCustomView:btnLeftSideMenu];
    self.navigationItem.leftBarButtonItem = menuBtn;
    
    //===============    Add Data In scrollview  ===================
    
    scrollview.showsVerticalScrollIndicator = false;
    scrollview.backgroundColor = tableBackgroundColor;
    rowHeight  = [UIScreen mainScreen].bounds.size.width/4-16-8;
    
    if (!viewphoto) {
        viewphoto = [[UIView alloc]init];
    }
    viewphoto.frame = CGRectMake(8, 8, self.view.bounds.size.width-16, rowHeight+55);
    viewphoto.backgroundColor = NavigationTitleColor;
    
    if (!lblAddphoto) {
        lblAddphoto =  [[UILabel alloc]init];
    }
    lblAddphoto.frame = CGRectMake(16, 10,100, 30);
    lblAddphoto.text = @"Add Photo";
    lblAddphoto.textColor = [UIColor colorWithRed:167.0/255.0 green:169.0/255.0 blue:172.0/255.0 alpha:1.0];
    lblAddphoto.font = FontRegular16;
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
        imageviewobj.tag = i;
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
    
    //Title

    if (!viewtitle) {
        viewtitle = [[UIView alloc]init];
    }
    viewtitle.frame = CGRectMake(8, viewphoto.frame.origin.y+viewphoto.frame.size.height+8,screenWidth-16, 70);
    viewtitle.backgroundColor =[UIColor whiteColor];
    
    if (!lblTitle) {
        lblTitle = [[UILabel alloc]init];
    }
    lblTitle.frame = CGRectMake(8, 0,screenWidth-16, 30);
    lblTitle.text = @"   Title";
    lblTitle.textColor = userNameInProfile;
    lblTitle.font = FontRegular16;
    lblTitle.backgroundColor = [UIColor clearColor];
    [viewtitle addSubview:lblTitle];
    
    if (!txtTitle) {
        txtTitle = [[UITextField alloc]init];
    }
    txtTitle.frame = CGRectMake(8, lblTitle.frame.origin.y+lblTitle.frame.size.height,screenWidth-32, 30);
    txtTitle.textColor  = txtFieldTextColor;
    txtTitle.backgroundColor = NavigationTitleColor;
    txtTitle.delegate = self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    txtTitle.leftView = paddingView;
    txtTitle.leftViewMode = UITextFieldViewModeAlways;
    txtTitle.font = FontRegular16;
    [viewtitle addSubview:txtTitle];
    [scrollview addSubview:viewtitle];
    
    
    if (!viewChooseCategory) {
        viewChooseCategory = [[UIView alloc]init];
    }
    viewChooseCategory.frame = CGRectMake(8, viewtitle.frame.origin.y+viewtitle.frame.size.height+8,screenWidth-16, 60);
    viewChooseCategory.backgroundColor =[UIColor whiteColor];
    
    if (!lblChooseCategory) {
        lblChooseCategory = [[UILabel alloc]init];
    }
    lblChooseCategory.frame = CGRectMake(8, 0,screenWidth-32, 30);
    lblChooseCategory.text = @"   Choose category";
    lblChooseCategory.textColor = userNameInProfile;
    lblChooseCategory.font = FontRegular16;
    lblChooseCategory.backgroundColor = [UIColor clearColor];
    
    [viewChooseCategory addSubview:lblChooseCategory];

    
    txtChooseCategory = [[UITextField alloc]initWithFrame:CGRectMake(8,lblChooseCategory.frame.origin.y+lblChooseCategory.frame.size.height,screenWidth-32, 30)];
    txtChooseCategory.textColor  = txtFieldTextColor;
    txtChooseCategory.delegate = self;
    txtChooseCategory.backgroundColor = NavigationTitleColor;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    txtChooseCategory.leftView = paddingView1;
    txtChooseCategory.leftViewMode = UITextFieldViewModeAlways;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btn.frame = CGRectMake(0, 0, 20.0, 20.0);
    [btn setTitleColor:txtFieldTextColor forState:UIControlStateNormal];
    [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleRight] forState:UIControlStateNormal];
    txtChooseCategory.rightView = btn;
    [txtChooseCategory setRightViewMode:UITextFieldViewModeAlways];
    txtChooseCategory.tag = 1;
    txtChooseCategory.font = FontRegular16;
    [viewChooseCategory addSubview:txtChooseCategory];
    [scrollview addSubview:viewChooseCategory];
    
    
    if (!viewDescription) {
        viewDescription = [[UIView alloc]init];
    }
    viewDescription.frame = CGRectMake(8, viewChooseCategory.frame.origin.y+viewChooseCategory.frame.size.height+8,screenWidth-16, 110);
    viewDescription.backgroundColor =[UIColor whiteColor];
    
    if (!lblviewDescription) {
        lblviewDescription = [[UILabel alloc]init];
    }
    lblviewDescription.frame = CGRectMake(8, 0,screenWidth-16, 30);
    lblviewDescription.text = @"   Description";
    lblviewDescription.textColor = userNameInProfile;
    lblviewDescription.backgroundColor = [UIColor clearColor];
    lblviewDescription.font = FontRegular16;
    [viewDescription addSubview:lblviewDescription];

    
    txtviewDescription = [[UITextView alloc]initWithFrame:CGRectMake(0, lblviewDescription.frame.origin.y+lblviewDescription.frame.size.height,screenWidth-32,70)];
    txtviewDescription.text = @"";
    txtviewDescription.font = FontRegular;
    txtviewDescription.textColor  = [UIColor colorWithRed:195.0/255.0 green:194.0/255.0 blue:201.0/255.0 alpha:1.0];
    txtviewDescription.backgroundColor = NavigationTitleColor;
    txtviewDescription.delegate = self;
    [txtviewDescription setTextContainerInset:UIEdgeInsetsMake(8, 12, 0, 12)];
    txtviewDescription.font = FontRegular16;
    [viewDescription addSubview:txtviewDescription];
    [scrollview addSubview:viewDescription];
    
    
    if (!viewPrice) {
        viewPrice = [[UIView alloc]init];
    }
    viewPrice.frame = CGRectMake(8, viewDescription.frame.origin.y+viewDescription.frame.size.height+8,screenWidth-16, 60);
    viewPrice.backgroundColor =[UIColor whiteColor];
    
    if (!lblPrice) {
        lblPrice = [[UILabel alloc]init];
    }
    lblPrice.frame = CGRectMake(8, 0,screenWidth-16, 30);
    lblPrice.text = @"   Price";
    lblPrice.textColor = userNameInProfile;
    lblPrice.backgroundColor = [UIColor clearColor];
    lblPrice.font = FontRegular16;
    [viewPrice addSubview:lblPrice];

    
    txtPrice = [[UITextField alloc]initWithFrame:CGRectMake(8, lblPrice.frame.origin.y+lblPrice.frame.size.height,screenWidth-32, 30)];
    txtPrice.textColor  = txtFieldTextColor;
    txtPrice.backgroundColor = NavigationTitleColor;
    txtPrice.delegate = self;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    txtPrice.leftView = paddingView3;
    txtPrice.leftViewMode = UITextFieldViewModeAlways;
    txtPrice.font = FontRegular16;
    [viewPrice addSubview:txtPrice];
    
    [scrollview addSubview:viewPrice];
    
    
    
    if (!viewExpirationDate) {
        viewExpirationDate = [[UIView alloc]init];
    }
    viewExpirationDate.frame = CGRectMake(8, viewPrice.frame.origin.y+viewPrice.frame.size.height+8,screenWidth-16, 60);
    viewExpirationDate.backgroundColor =[UIColor whiteColor];
    
    if (!lblExpirationDate) {
        lblExpirationDate = [[UILabel alloc]init];
    }
    lblExpirationDate.text= @"   Expiration date";
    lblExpirationDate.frame = CGRectMake(8,0,screenWidth-16, 30);
    lblExpirationDate.textColor = userNameInProfile;
    lblExpirationDate.backgroundColor = [UIColor clearColor];
    lblExpirationDate.font = FontRegular16;
    [viewExpirationDate addSubview:lblExpirationDate];

    txtExpirationDate = [[UITextField alloc]initWithFrame:CGRectMake(8, lblExpirationDate.frame.origin.y+lblExpirationDate.frame.size.height,screenWidth-32, 30)];
    txtExpirationDate.textColor  = txtFieldTextColor;
    txtExpirationDate.backgroundColor = NavigationTitleColor;
    txtExpirationDate.delegate = self;
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    txtExpirationDate.leftView = paddingView4;
    txtExpirationDate.leftViewMode = UITextFieldViewModeAlways;
    txtExpirationDate.font = FontRegular16;
    [viewExpirationDate addSubview:txtExpirationDate];
    [scrollview addSubview:viewExpirationDate];
    

    if ([_strTitleName isEqualToString:@"EDIT BUZZ"])
    {
        viewPrice.hidden = YES;
        viewChooseCategory.hidden = YES;
        viewDescription.frame = CGRectMake(8, viewtitle.frame.origin.y+viewtitle.frame.size.height+8,screenWidth-16, 110);
        viewExpirationDate.frame = CGRectMake(8, viewDescription.frame.origin.y+viewDescription.frame.size.height+8,screenWidth-16, 60);


    }
    else
    {
        viewPrice.hidden = NO;
        viewChooseCategory.hidden = NO;
        viewDescription.frame = CGRectMake(8, viewChooseCategory.frame.origin.y+viewChooseCategory.frame.size.height+8,screenWidth-16, 110);
        viewExpirationDate.frame = CGRectMake(8, viewPrice.frame.origin.y+viewPrice.frame.size.height+8,screenWidth-16, 60);



    }
    
    UIButton *btnSave = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2-35, viewExpirationDate.frame.origin.y+viewExpirationDate.frame.size.height+16,70, 40)];
    btnSave.backgroundColor = NavigationBarBgColor;
    [btnSave setTitle:@"Save" forState:UIControlStateNormal];
    btnSave.titleLabel.font = FontBold16;
    btnSave.layer.cornerRadius = 6.0;
    [btnSave addTarget:self action:@selector(btnSaveClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:btnSave];

    
    scrollview.contentSize = CGSizeMake(250, btnSave.frame.origin.y+btnSave.frame.size.height+100);
//    scrollview.contentSize = CGSizeMake(250, btnSave.frame.origin.y+btnSave.frame.size.height);

    IsDataDisplay = false;

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    
        if (IsDataDisplay == false)
        {
            if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
                
                self.navigationController.view.userInteractionEnabled = false;
                self.tabBarController.view.userInteractionEnabled = false;
                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];
                
                if ([_strTitleName isEqualToString:@"EDIT POST"])
                {
                    [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"post_id"];
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"get_postupdate";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"get_postupdate" withToken:YES];

                }
                else
                {
                    [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"buzz_id"];
                    [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"get_buzz_update";
                    [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"get_buzz_update" withToken:YES];
                }
            }
            else
            {
                [self.view makeToast:NSLocalizedString(@"Internet_connect_unavailable", nil)];
            }
        }
    
}
#pragma mark - UITextfieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:txtChooseCategory]) {
        [textField resignFirstResponder];
        CategoryListViewController *categoryObj = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryListViewController"];
        categoryObj.userId = _userID;
        categoryObj.delegate = self;
        [self.navigationController pushViewController:categoryObj animated:NO];
        
    }

   else  if ([textField isEqual:txtExpirationDate])
    {
        //        UIDatePicker *
        datepicker = [[UIDatePicker alloc]init];
        datepicker.datePickerMode = UIDatePickerModeDate;
        datepicker.backgroundColor = [UIColor whiteColor];
        
        [datepicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        //now preparing the toolbar which will be displayed at the top of the datePicker
        UIToolbar  *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight-datepicker.frame.size.height, screenWidth, 44)];
        pickerToolbar.barStyle=UIBarStyleDefault;
        
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(btnDoneClicked:)];
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

    
}
-(void)doneButtonClicked:(id)sender
{
    if ([txtPrice isFirstResponder])
    {
        [txtPrice resignFirstResponder];
    }
    if ([txtviewDescription isFirstResponder])
    {
        [txtviewDescription resignFirstResponder];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:txtTitle]) {
        txtTitle.text = textField.text;
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITextView delegate

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
    int statusCode = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    if (statusCode == 200)
    {
        if ([nState isEqualToString:@"get_postupdate"] ||  [nState isEqualToString:@"get_buzz_update"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            
            arrayPostData =  [arrData valueForKey:@"Response"];
            NSArray *images =[[arrData valueForKey:@"Response"] valueForKey:@"Gallery"];
            NSString *strpath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
            
            for (int i =0 ; i < images.count; i++) {
                
                NSString *str;
                if ([nState isEqualToString:@"get_postupdate"])
                {
                str = [NSString stringWithFormat:@"%@%@",strpath,[[images objectAtIndex:i] valueForKey:@"post_image"]];
                }
                else{
                    str = [NSString stringWithFormat:@"%@%@",strpath,[[images objectAtIndex:i] valueForKey:@"buzz_image"]];
                }
                
                if(!arrayImageData)
                {
                    arrayImageData = [[NSMutableArray alloc]init];
                }
                [arrayImageData addObject:str];
            }
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setValue:arrayPostData forKey:@"EditpostDetails"];
            [defaults setValue:[arrayImageData objectAtIndex:0] forKey:@"postImages"];
            
            [self dataDisplay:arrayPostData imgArray:arrayImageData];
        }
        
    }
    else if (statusCode == 204)
    {
        HideNetworkActivityIndicator();
        self.navigationController.view.userInteractionEnabled = true;
        self.tabBarController.view.userInteractionEnabled = true;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        if ([nState isEqualToString:@"buzz_detail"]) {
            [appDelegate.tabviewControllerObj.profileObj.mypostobj.mypostDetailObj.view makeToast:@"Buzz containt has been updated."];
        }
        else
            
        {
            [appDelegate.tabviewControllerObj.profileObj.mypostobj.mypostDetailObj.view makeToast:@"Post containt has been updated."];

        }
    }
    
    else if (statusCode == 404)
    {
        HideNetworkActivityIndicator();
        
    }
    else if (statusCode == 401)
    {
        HideNetworkActivityIndicator();
    }
    else if (statusCode == 400)
    {
        HideNetworkActivityIndicator();
        [self.view makeToast:@"Bad Request due to invalid parameters."];
    }
    
    else if (statusCode == 500)
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
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateString = [dateFormat stringFromDate:[datepicker date]];
//    [txtExpirationDate setText:dateString];
    
    
    
    //    ExpirationDate = startDate;
    //    strExpirationDate = [NSString stringWithFormat:@"%@",startDate];
    
    strExpirationDate = dateString;
    
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    dateString = [dateFormat stringFromDate:[datepicker date]];
    [txtExpirationDate setText:dateString];
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateString = [dateFormat1 stringFromDate:[NSDate date]];
    
    strCurrentDate = dateString;
}

#pragma mark -  Delegate Method
-(void)selectCategoryName:(NSString *)name id:(NSString *)UniversityId
{
    txtChooseCategory.text  = name;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
         //   controller.allowsEditing = YES;
            controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
            controller.delegate = self;
            [self.navigationController presentViewController: controller animated: YES completion: nil];
        }
        
    }
}

#pragma mark - Button Method
-(void)imageViewClicked:(UITapGestureRecognizer*)imgview
{
    imageview = (UIImageView*)imgview.view;
    NSLog(@"imgview %ld",(long)imgview.view.tag);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Pictures Option" message:@"Select Picture Mode" delegate:self
                                         cancelButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery", nil];
    
    [alert show];
}

-(void)btnDoneClicked:(UIPickerView*)picker
{
    if ([txtExpirationDate isFirstResponder]) {
        [txtExpirationDate resignFirstResponder];
    }
    NSLog(@"donebutton clicked %@",picker);
}
- (void)btnSaveClicked:(id)sender
{
    NSLog(@"sender %@",sender);
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
        
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;

        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        [dict setValue:[NSString stringWithFormat:@"%d",_userID] forKey:@"user_id"];

        NSArray *details = [defaults valueForKey:@"EditpostDetails"];
        [dict setValue:[[[details valueForKey:@"Details"] valueForKey:@"university_id"] objectAtIndex:0] forKey:@"university_id"];
        
        [dict setValue:txtviewDescription.text forKey:@"description"];
        [dict setValue:strExpirationDate forKey:@"expirydate"];
        [dict setValue:strCurrentDate forKey:@"dt_modifydate"];
        
        NSMutableArray *arrayImage = [[NSMutableArray alloc]init];
        NSArray *array = [[arrayPostData valueForKey:@"Gallery"] valueForKey:@"photo_id"];
        
        for (int i =0 ; i < imageArray.count; i++)
        {
            NSMutableDictionary *dict =[[ NSMutableDictionary alloc]init];
            
            int imgId;
            if (array.count> i) {
                
                imgId = [[array objectAtIndex:i] intValue];
            }
            else{
                imgId = 0 ;
            }
            
            
            UIImageView *imgview = [imageArray objectAtIndex:i];
            NSData *imgdata = UIImageJPEGRepresentation([self scaleAndRotateImage:imgview.image], 1.0);//0.2 to 1.0
            NSString *strEncodingImg = [imgdata base64EncodedStringWithOptions:0];
//            [arrayImageData addObject:strEncodingImg];

            [dict setValue:[NSString stringWithFormat:@"%d",imgId] forKey:@"image_id"];
            [dict setValue:[NSString stringWithFormat:@"%d-%d.jpeg",_postID,i+1] forKey:@"title"];
            [dict setValue:strEncodingImg forKey:@"image"];
            [arrayImage addObject:dict];
        }
        
        
        [dict setObject:arrayImage forKey:@"images"];
        
        ////new change
        for (int i = 0; i < arrayImageData.count; i++)
        {
            NSURL *url = [NSURL URLWithString:[arrayImageData objectAtIndex:i]];
            NSString *cacheFilename = [url lastPathComponent];
            //            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
            int index = (int)[url pathComponents].count-3;
            NSString *folderName =[[url pathComponents] objectAtIndex:index];
            
            NSLog(@"folderName %@",folderName);
            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];
            
            
            
            NSString *str = [NSString stringWithFormat:@"%@",cachePath];
            str = [str stringByReplacingOccurrencesOfString:cacheFilename withString:@""];
            
            NSFileManager *fileMngr = [NSFileManager defaultManager];
            //        if ([[[cachePath pathExtension] lowercaseString] isEqualToString:cacheFilename])
            if ([cachePath hasSuffix:cacheFilename])
            {
                [fileMngr removeItemAtPath:cachePath error:nil];
            }
        }
        
//        ==========
        
        
//        NSLog(@"dict %@",dict);
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        if ([_strTitleName isEqualToString:@"EDIT POST"])
        {
            [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"post_id"];
            
            [dict setValue:txtTitle.text forKey:@"post_title"];
            
            NSArray *catNamelist =  [defaults valueForKey:@"categoryNameList"];
            NSArray *catID = [defaults valueForKey:@"categoryId"];
            int index = (int)[catNamelist indexOfObject:txtChooseCategory.text] ;
            [dict setValue:[catID objectAtIndex:index] forKey:@"post_cat_id"];
            
            [dict setValue:txtPrice.text forKey:@"price"];
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_update";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_update" withToken:NO];

        }
        else
        {
            [dict setValue:[NSString stringWithFormat:@"%d",_postID] forKey:@"buzz_id"];
            [dict setValue:txtTitle.text forKey:@"buzz_title"];
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"buzz_update";
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"buzz_update" withToken:NO];
        }

        
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
-(void)btnBackClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
-(void)dataDisplay:(NSArray*)array imgArray:(NSArray*)images
{
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    IsDataDisplay = true;
    NSArray *array1 = [[array valueForKey:@"Details"] objectAtIndex:0];
    txtviewDescription.text = [array1 valueForKey:@"description"];
    txtviewDescription.textColor = txtFieldTextColor;
    
    NSDateFormatter *dateformate= [[NSDateFormatter alloc]init];
    [dateformate setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateformate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *endDate =  [dateformate dateFromString:[array1 valueForKey:@"expiry_date"]];
    
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd"];
        endDate =  [dateformate dateFromString:[array1 valueForKey:@"expiry_date"]];
    }
    if (endDate == nil) {
        [dateformate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        endDate =  [dateformate dateFromString:[array1 valueForKey:@"expiry_date"]];
    }

    
    NSDateFormatter *format1 = [[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"MM-dd-yyyy"];
    NSString *str = [format1 stringFromDate:endDate];
    txtExpirationDate.text = str;
    
    if ([_strTitleName isEqualToString:@"EDIT POST"])
    {
        txtTitle.text = [array1 valueForKey:@"post_name"] ;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *catNamelist =  [defaults valueForKey:@"categoryNameList"];
        NSArray *catID = [defaults valueForKey:@"categoryId"];
        
        int index = (int)[catID indexOfObject:[array1 valueForKey:@"post_cate_id"]];
        txtChooseCategory.text =[catNamelist objectAtIndex:index];
        txtPrice.text = [NSString stringWithFormat:@"%@",[array1 valueForKey:@"price"]];
    }
    else
    {
        txtTitle.text = [array1 valueForKey:@"buzz_name"] ;
        
    }
    
    for (UIView *subview in [viewphoto subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imaegviewRemove = (UIImageView *)subview;
            
            if (images.count == 4)
            {
                imaegviewRemove.userInteractionEnabled = YES;

            }
            if (imaegviewRemove.tag ==  images.count)
            {
                imaegviewRemove.userInteractionEnabled = YES;
            }
            
            
        }
    }

    NSArray *imageviewAdded  = [viewphoto subviews];
    
    
    for (int i = 0; i < images.count; i++) {
        if (i>3) {
            break;
        }
        UIImageView *imgv = [imageviewAdded objectAtIndex:i+1];
        imgv.tag = i;
        
        imgv.image = [UIImage imageNamed:@"lodingicon.png"];
        
        
        
        NSURL *url = [NSURL URLWithString:[images objectAtIndex:i]];
        NSString *cacheFilename = [url lastPathComponent];
//        NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
        int index = (int)[url pathComponents].count-3;
        NSString *folderName =[[url pathComponents] objectAtIndex:index];
        
        NSLog(@"folderName %@",folderName);
        NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];

        
        id image = [LazyLoadingImage imageDataFromPath:cachePath];
        
        if(image)
        {
            imgv.image = (UIImage*)image;
            
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     imgv.image = [UIImage imageWithData:data];
                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     
                 }
             }];
        }
        
        [viewphoto addSubview:imgv];
        
        if (!imageArray) {
            imageArray = [[NSMutableArray alloc]init];
        }
        [imageArray addObject:imgv];
        
    }
    
    strExpirationDate = txtExpirationDate.text;
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    strCurrentDate = [dateFormat1 stringFromDate:[NSDate date]];
    
    
    
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
 /*   for (UIView *subview in [viewphoto subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imaegviewRemove = (UIImageView *)subview;
            if (imaegviewRemove.tag ==  imageview.tag)
            {
                imageview = imaegviewRemove;
            }

            else if (imaegviewRemove.tag ==  imageview.tag+1)
            {
                imaegviewRemove.userInteractionEnabled = YES;
            }
            
        }
    }

    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    if (imageview.image != nil) {
        imageview.image = nil;
        
//        for (int i = 0; i < arrayImageData.count; i++)
        if (arrayImageData.count>imageview.tag)
        {
            NSURL *url = [NSURL URLWithString:[arrayImageData objectAtIndex:imageview.tag]];
            NSString *cacheFilename = [url lastPathComponent];
//            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
            int index = (int)[url pathComponents].count-3;
            NSString *folderName =[[url pathComponents] objectAtIndex:index];
            
            NSLog(@"folderName %@",folderName);
            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];

            
            
            NSString *str = [NSString stringWithFormat:@"%@",cachePath];
            str = [str stringByReplacingOccurrencesOfString:cacheFilename withString:@""];
            
            NSFileManager *fileMngr = [NSFileManager defaultManager];
            //        if ([[[cachePath pathExtension] lowercaseString] isEqualToString:cacheFilename])
            if ([cachePath hasSuffix:cacheFilename])
            {
                [fileMngr removeItemAtPath:cachePath error:nil];
            }
        }
        [imageArray removeObject:imageview];

    }
    
    imageview.image = chosenImage;

    if (!imageArray) {
        imageArray = [[NSMutableArray alloc]init];
    }
    
    [imageArray addObject:imageview];
    [picker dismissViewControllerAnimated:YES completion:NULL];*/
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
            
            else if (imaegviewRemove.tag ==  imageview.tag+1)
            {
                imaegviewRemove.userInteractionEnabled = YES;
            }
            
        }
    }
    
    
    if (imageview.image != nil) {
        imageview.image = nil;
        
        //        for (int i = 0; i < arrayImageData.count; i++)
        if (arrayImageData.count>imageview.tag)
        {
            NSURL *url = [NSURL URLWithString:[arrayImageData objectAtIndex:imageview.tag]];
            NSString *cacheFilename = [url lastPathComponent];
            //            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
            int index = (int)[url pathComponents].count-3;
            NSString *folderName =[[url pathComponents] objectAtIndex:index];
            
            NSLog(@"folderName %@",folderName);
            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];
            
            
            
            NSString *str = [NSString stringWithFormat:@"%@",cachePath];
            str = [str stringByReplacingOccurrencesOfString:cacheFilename withString:@""];
            
            NSFileManager *fileMngr = [NSFileManager defaultManager];
            //        if ([[[cachePath pathExtension] lowercaseString] isEqualToString:cacheFilename])
            if ([cachePath hasSuffix:cacheFilename])
            {
                [fileMngr removeItemAtPath:cachePath error:nil];
            }
        }
        [imageArray removeObject:imageview];
        
    }
    
    imageview.image = croppedImage;
    
    if (!imageArray) {
        imageArray = [[NSMutableArray alloc]init];
    }
    
    [imageArray addObject:imageview];

    [self.navigationController popViewControllerAnimated:YES];
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


#pragma mark - Navigation Button method
-(void)btnNotificationClicked:(id)sender
{
    NSLog(@"notification ");
    MessagesViewController *objMsgVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MessagesViewController"];
    //  objMsgVC.userId = _userId;
    //   objMsgVC.strUserName = _strUserName;
    objMsgVC.SelectMsgType = 0;
    [self.navigationController pushViewController:objMsgVC animated:YES];

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
