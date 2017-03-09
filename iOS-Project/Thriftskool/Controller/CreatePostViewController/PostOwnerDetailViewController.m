//
//  PostOwnerDetailViewController.m
//  Thriftskool
//
//  Created by Asha on 16/10/16.
//  Copyright © 2016 Etilox. All rights reserved.
//

#import "PostOwnerDetailViewController.h"
#import "OpenImageViewController.h"
#import "SelectCategoryPostListViewController.h"
#import "PostOwnerListViewController.h"
@interface PostOwnerDetailViewController ()

@end

@implementation PostOwnerDetailViewController
@synthesize owner_id,postCatID,universityID,strUserName,strPostimagePath;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;

     self.navigationItem.title = @"POST OWNER";
    
    imgProfilView.layer.cornerRadius = 40;
    imgProfilView.clipsToBounds = YES;
    
    btnPostViewAll.layer.cornerRadius = 6.0;

    imgProfilView.image = [UIImage imageNamed:@"lodingicon.png"];
    
    //Clear label;
    lblUserName.text=@"";
    lblName.text=@"";
    lblClassName.text=@"";
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
    
    imgProfilView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapOnImage:)];
    [imgProfilView addGestureRecognizer:tap];
    [self getOwnerDetail];
    
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
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
# pragma mark - View Post Pressed
-(IBAction)viewpostallClicked:(id)sender
{
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork) {
      PostOwnerListViewController  *selectcatpostlistObj = [self.storyboard instantiateViewControllerWithIdentifier:@"PostOwnerListViewController"];
        selectcatpostlistObj.userID = owner_id;
        selectcatpostlistObj.arrayAllList=[arrPostList mutableCopy];
        selectcatpostlistObj.strPostImagePath=self.strPostimagePath;//strPostPath;
        selectcatpostlistObj.universityID=universityID;
        selectcatpostlistObj.postCatID=postCatID;
        selectcatpostlistObj.strUserName=strUserName;
      //  int index = (int)[arrayPostIdList indexOfObject:[NSString stringWithFormat:@"%d",selectcatpostlistObj.postCatID]];
       // selectcatpostlistObj.strSelectedCategoryName = [arraCategoryName objectAtIndex:index];
        
        [self.navigationController pushViewController:selectcatpostlistObj animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }

}

#pragma mark - profile image
-(void)setOwnerProfileImage:(NSString*)strImageUrl
{
    imgProfilView.image = [UIImage imageNamed:@"lodingicon.png"];
    
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
            imgProfilView.image = (UIImage*)image;
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                      imgProfilView.image = [UIImage imageWithData:data];
                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                 }
             }];
        }
        
    }
    else
    {
         imgProfilView.image = [UIImage imageNamed:@"lodingicon.png"];
    }

}
# pragma mark image tap
-(void)TapOnImage:(UITapGestureRecognizer*)tap
{
    UIImageView *img = (UIImageView*)tap.view;
    NSLog(@"img %@",img);
    OpenImageViewController *imgviewOpenObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OpenImageViewController"];
    
    
    imgviewOpenObj.indexpage = (int)img.tag;
    imgviewOpenObj.arrayImage = arrImageDetails;
    [self presentViewController:imgviewOpenObj animated:YES completion:nil];
    
}

# pragma mark - Owener Detail Method
-(void)getOwnerDetail
{
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
        
      
        [dict setValue:[NSString stringWithFormat:@"%d",owner_id] forKey:@"owner_id"];
        
        NSLog(@"dict %@",dict);
        [ConnectionServer sharedConnectionWithDelegate:self].serviceName = @"post_owner_detail";
        [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:dict caseName:@"post_owner_detail" withToken:YES];
    }
    else
    {
        [self.view makeToast:@"Check Internet Connection"];
    }

}
#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    int status = [[[arrData valueForKey:@"Response"] valueForKey:@"status"] intValue];
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (status == 200)
    {
        if([arrData isKindOfClass:[NSDictionary class]])
        {
                NSDictionary *objDicdetail = (NSDictionary*)[arrData objectForKey:@"Response"];
            if([objDicdetail objectForKey:@"Details"])
            {
                if(!arrPostList)
                {
                    arrPostList=[[NSMutableArray alloc]init];
                }
                NSArray *arrPost = [objDicdetail objectForKey:@"Details"];
                for(int i=0;i<[arrPost count];i++)
                {
                    NSDictionary *dicObj = [arrPost objectAtIndex:i];
                    BOOL isCheck = [self checkisPostExpired:[dicObj valueForKey:@"expiredate"]];
                    if(!isCheck)
                    {
                        [arrPostList addObject:dicObj];
                    }
                }
            }
            if([objDicdetail objectForKey:@"postimgpath"])
            {
                strPostPath = [objDicdetail objectForKey:@"postimgpath"];
            }
             if([objDicdetail objectForKey:@"class_name"])
             {
                 if(![[objDicdetail objectForKey:@"class_name"] isKindOfClass:[NSNull class]])
                 {
                     if([[objDicdetail objectForKey:@"class_name"] isEqualToString:@"Select"])
                     {
                          lblClassName.text = @"";
                     }
                     else
                     {
                         lblClassName.text = [objDicdetail valueForKey:@"class_name"];
                     }
                 }
             }
            if([objDicdetail objectForKey:@"person_name"])
            {
                if(![[objDicdetail objectForKey:@"person_name"] isKindOfClass:[NSNull class]])
                {
                    lblUserName.text = [objDicdetail valueForKey:@"person_name"];

                }
            }
            if([objDicdetail objectForKey:@"var_username"])
            {
                if(![[objDicdetail objectForKey:@"var_username"] isKindOfClass:[NSNull class]])
                {
                    lblName.text = [objDicdetail valueForKey:@"var_username"];
                }
            }
            if([objDicdetail objectForKey:@"profile_img"])
            {
                  NSString *strImagepath = [[arrData valueForKey:@"Response"] valueForKey:@"imagepath"];
                 NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,[objDicdetail valueForKey:@"profile_img"]];
                [self setOwnerProfileImage:str];
            }
            if (!arrImageDetails) {
                arrImageDetails = [[NSMutableArray alloc]init];
            }
            [arrImageDetails removeAllObjects];
            if([objDicdetail objectForKey:@"profile_img"])
            {
                imgProfilView.userInteractionEnabled = true;

                NSString *strImage = [objDicdetail valueForKey:@"profile_img"];
                NSString *strImagepath = [objDicdetail valueForKey:@"imagepath"];
                
               
                    
                    NSString *str = [NSString stringWithFormat:@"%@%@",strImagepath,strImage];
                    
                    
                    [arrImageDetails addObject:str];
                
                
               
            }
            if([arrImageDetails count]==0)
            {
                imgProfilView.userInteractionEnabled = false;
            }
        }
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
       
        
    }
    
    else if (status == 500)
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
-(BOOL)checkisPostExpired:(NSString*)strDate
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
    format1.dateFormat = @"dd-LLL-yyyy";
    NSLog(@"%@", [format1 stringFromDate:endDate]);
    
    
    NSDateComponents *components;
    NSInteger days;
    
    components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: startDate toDate: endDate options: 0];
    days = [components day];
    
    
    if (days < 0) {
        return true;
    }
    return false;
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
