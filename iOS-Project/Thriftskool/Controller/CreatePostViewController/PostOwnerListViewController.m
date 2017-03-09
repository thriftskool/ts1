//
//  PostOwnerListViewController.m
//  Thriftskool
//
//  Created by Asha on 05/11/16.
//  Copyright © 2016 Etilox. All rights reserved.
//

#import "PostOwnerListViewController.h"
#import "SelectCategoryPostLIstTableViewCell.h"

@interface PostOwnerListViewController ()

@end

@implementation PostOwnerListViewController
@synthesize userID,strUserName,universityID,postCatID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
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
    
    tblViewPostList.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;
    
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

#pragma mark - UITableview method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayAllList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@%d",@"SelectCategorycell",(int)indexPath.row];
    
    SelectCategoryPostLIstTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        cell1 = [[SelectCategoryPostLIstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                           reuseIdentifier:CellIdentifier];
        cell1.btnfav.tag = indexPath.row+1;
        //        cell1.btnfav.selected = false;
        //
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 5)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:separatorLineView];
        
        UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-5, screenWidth, 5)];/// change size as you need.
        bottomline.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:bottomline];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];
        //  cell1.imgviewpost.tag = indexPath.row;
        cell1.imgviewpost.tag = indexPath.row;
        
        
    }
    
    //    cell1.imgviewpost.image = [UIImage imageWithData:[arrayPostImageList objectAtIndex:indexPath.row]];
    NSDictionary *dicPostObj = [self.arrayAllList objectAtIndex:indexPath.row];
    
    
            cell1.lblTitle.text = [dicPostObj valueForKey:@"post_name"];
    if ([[dicPostObj valueForKey:@"status"] isEqualToString:@"1"])
    {
        cell1.lblExpDate.text = @"Expired";
    }
    
    else if ([[dicPostObj valueForKey:@"status"] isEqualToString:@"2"])
    {
        cell1.lblExpDate.text = @"Closed";
    }
    else
    {
        NSString *str = [[GlobalMethod shareGlobalMethod] DateDisplayInCell1:[dicPostObj valueForKey:@"expiredate"]];
        cell1.lblExpDate.text = str;
    }
    
    
    
    if ([cell1.lblExpDate.text isEqualToString:@"Expired"] || [cell1.lblExpDate.text isEqualToString:@"Closed"]) {
        cell1.lblExpDate.textColor =[UIColor redColor];
        
    }
    else
    {
        cell1.lblExpDate.textColor = [UIColor blackColor];
        
    }
    
    
    //    cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",[dicPostObj valueForKey:@"price"]];
    if([[dicPostObj valueForKey:@"price"] isEqualToString:@""])
    {
        cell1.lblPrice.text = @"";
    }
    else
    {
        cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",[dicPostObj valueForKey:@"price"]];
    }
    cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];
    
    NSString *strImage = [NSString stringWithFormat:@"%@%@",_strPostImagePath,[dicPostObj valueForKey:@"image"]];

    //NSString *strImage = [dicPostObj valueForKey:@"imagepathurl"];//[arrayPostImageList objectAtIndex:indexPath.row];
    
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
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     cell1.imgviewpost.image = [UIImage imageWithData:data];
                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     if(!cell1.imgviewpost.image)
                     {
                         cell1.imgviewpost.image = [UIImage imageNamed:@"lodingicon.png"];
                     }
                 }
                 else
                 {
                     
                 }
             }];
        }
        
    }
    
    
    /*cell1.lblTitle.text = [arrayTitleList objectAtIndex:indexPath.row];
     NSString *str = [self DateDisplayInCell:[arrayExpDateList objectAtIndex:indexPath.row] index:indexPath.row];
     cell1.lblExpDate.text = str;
     cell1.lblPrice.text = [NSString stringWithFormat:@"$%@",[arrayPriceList objectAtIndex:indexPath.row]];*/
    
   
        cell1.btnfav.hidden = false;
        [cell1.btnfav addTarget:self action:@selector(btnFavClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell1.btnfav setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        
        {
            if (isFavClicked == false)
            {
                NSString *str = [[self.arrayAllList valueForKey:@"favorite"] objectAtIndex:indexPath.row];
                NSLog(@"str %@",str);
                
                if([str isKindOfClass:[NSNull class]])
                {
                    str = @"0";
                }
                
                if ([str isEqualToString:@"1"]) {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
                    cell1.btnfav.selected = true;
                }
                else
                {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
                    cell1.btnfav.selected = false;
                    
                }
            }
            else
            {
                if (cell1.btnfav.selected == false)
                {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
                }
                else
                {
                    [cell1.btnfav setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
                }
                
            }
        }
    
    
    return cell1;
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

        SelectCategoryPostDetailViewController *
        selectDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCategoryPostDetailViewController"];
        selectDetailObj.dictDetail = [self.arrayAllList objectAtIndex:indexPath.row];
       // selectDetailObj.strNavigationTitle = _strSelectedCategoryName;
        selectDetailObj.userID = userID;
        selectDetailObj.strUserName = strUserName;
        selectDetailObj.universityID=universityID;
        selectDetailObj.postCatID=postCatID;
        [self.navigationController pushViewController:selectDetailObj animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
}
-(void)btnFavClicked:(UIButton *)btn
{
    isFavClicked = true;
    NSLog(@"btn fav clicked %@",btn);
   
    if (btn.selected == true)
    {
        btn.selected = false;
        [btn setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStarO] forState:UIControlStateNormal];
        [self postData:(int)btn.tag status:0];
        favBtnStatus = 0;
        
    }
    else
    {
        btn.selected = true;
        [btn setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [btn setTitle:[NSString fontAwesomeIconStringForEnum:FAStar] forState:UIControlStateNormal];
        [self postData:(int)btn.tag status:1];
        favBtnStatus = 1;
        
    }
}
#pragma mark - PostDataTo server
-(void)postData:(int)tag status:(int)status
{
    if([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        self.navigationController.view.userInteractionEnabled = false;
        self.tabBarController.view.userInteractionEnabled = false;
        
        
        NSArray *array = [self.arrayAllList objectAtIndex:tag-1];
        //
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        //        [dict setValue:[array valueForKey:@"user_id"] forKey:@"user_id"];
        
        if(array == nil)
        {
            [dict setValue:[NSString stringWithFormat:@"%d",self.userID] forKey:@"user_id"];
            
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
            if ([array valueForKey:@"post_id"] == nil) {
                [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
                
            }
            else{
                [dict setValue:[array valueForKey:@"post_id"] forKey:@"post_id"];
            }
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
#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    
    
  
    NSMutableDictionary *dictCatpostList = (NSMutableDictionary*)arrData;
    if([dictCatpostList isKindOfClass:[NSMutableDictionary class]])
    {
        int statuscode = [[[dictCatpostList valueForKey:@"Response"] valueForKey:@"status"] intValue];
        
        
        if (strstatuscode == 500) {
            [self.view makeToast:@"Internal server error"];
        }
        if (statuscode == 200)
        {
            
            
        }
        else if (statuscode == 201)
        {
            
            
        }
        
        else if (statuscode == 404)
        {
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
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (statuscode == 4041)
            {
            }
            else if (statuscode == 204)
            {
                if (favBtnStatus == 1)
                    
                {
                    [self.view makeToast:NSLocalizedString(@"Favorite_button_click_add", nil)];
                    
                }
                else
                {
                    [self.view makeToast:NSLocalizedString(@"Favorite_button_click_remove", nil)];
                    
                }
                
            }
        }
        
    }
    else
    {
        self.navigationController.view.userInteractionEnabled = true;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

- (void)ConnectionDidFail:(NSString*)nState Data: (NSString*)nData;
{
    self.tabBarController.view.userInteractionEnabled = true;
    
    self.navigationController.view.userInteractionEnabled = true;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    NSLog(@"nstate %@",nState);
    
    
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
