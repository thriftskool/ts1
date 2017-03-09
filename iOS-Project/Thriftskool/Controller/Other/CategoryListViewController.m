//
//  CategoryListViewController.m
//  Thriftskool
//
//  Created by Asha on 28/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategoryListTableViewCell.h"

@interface CategoryListViewController ()

@end

@implementation CategoryListViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarBgColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"CHOOSE CATEGORY";
    
    
    //LeftSide Button
    UIButton *btnleftside = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleftside.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btnleftside.frame = CGRectMake(0, 0, 30.0, 50.0);
    [btnleftside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleftside setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [btnleftside addTarget:self action:@selector(btnleftsideClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewleftside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30.0, 50.0)];
    viewleftside.bounds = CGRectOffset(viewleftside.bounds, 0, 0);
    [viewleftside addSubview:btnleftside];
    UIBarButtonItem *barleftside = [[UIBarButtonItem alloc]initWithCustomView:viewleftside];
    self.navigationItem.leftBarButtonItem = barleftside;
    
    //Rigth Side Button
    UIButton *btnRightside = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRightside setTitle:@"Done" forState:UIControlStateNormal];
    [btnRightside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRightside addTarget:self action:@selector(btnDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnRightside.frame = CGRectMake(0, 0, 50, 22);
    
    UIView *viewRightside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 22)];
    viewRightside.bounds = CGRectOffset(viewRightside.bounds, 0, 0);
    [viewRightside addSubview:btnRightside];
    UIBarButtonItem *barRightside = [[UIBarButtonItem alloc]initWithCustomView:viewRightside];
    self.navigationItem.rightBarButtonItem = barRightside;
    
    tblCategorylist.backgroundColor = tableBackgroundColor;
//    tblCategorylist.showsVerticalScrollIndicator = false;

    tblCategorylist.backgroundColor = tableBackgroundColor;
    self.view.backgroundColor = tableBackgroundColor;

    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    arrayCategoryName = [defaults valueForKey:@"categoryNameList"];
//    arrayCategoryImage = [defaults valueForKey:@"postImageList"];
//    arrayCategoryId = [defaults valueForKey:@"categoryId"];
    
    if (arrayCategoryName.count<1) {
        if([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;

            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:[NSString stringWithFormat:@"%d",_userId] forKey:@"user_id"];
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"post_categorylist";
            [[ConnectionServer sharedConnectionWithDelegate:self]GetStartUp:dict caseName:@"post_categorylist" withToken:NO];
        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"InternetAvailable", nil)];
        }
    }
    

}


#pragma mark - Navigation Button Mehtod
-(void)btnleftsideClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)btnDoneClicked:(id)sender
{
    if ([delegate respondsToSelector:@selector(selectCategoryName:id:)])
    {
        [delegate selectCategoryName:strCategoryName id:strCategoryId];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Connection method
- (void)ConnectionDidFinish: (NSString*)nState Data: (NSString*)nData statuscode:(NSInteger )strstatuscode;
{
    id arrData = [nData JSONValue];
    
    NSLog(@"strstatuscode %ld",(long)strstatuscode);
    NSLog(@"arrdata %@",arrData);
    NSLog(@"nstate %@",nState);
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationController.view.userInteractionEnabled = true;
    self.tabBarController.view.userInteractionEnabled = true;
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (strstatuscode == 200)
    {
        if ([nState isEqualToString:@"post_categorylist"])
        {
            dictUniversityList = (NSMutableDictionary*)arrData;
            
            arrayCategoryName = [[NSMutableArray alloc]initWithArray:[[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"post_category_name"]];
            
            
            NSArray *arrayImageName =  [[NSArray alloc]initWithArray:[[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"post_cat_image"]];
            
            arrayCategoryId =  [[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"post_cat_id"];
            
           NSString  *imagepath= [[dictUniversityList valueForKey:@"Response"] valueForKey:@"imagepath"];
            
            
            for (int i = 0; i < arrayImageName.count; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%@%@",imagepath,[arrayImageName objectAtIndex:i]];

                if (!arrayCategoryImage) {
                    arrayCategoryImage = [[NSMutableArray alloc]init];
                }
                [arrayCategoryImage addObject:str];
                
            }

            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:arrayCategoryName forKey:@"categoryNameList"];
            [defaults setObject:arrayCategoryImage forKey:@"postImageList"];
            [defaults setObject:arrayCategoryId forKey:@"categoryId"];
            [defaults synchronize];
            
            [tblCategorylist reloadData];
        }
        
    }
    else if (strstatuscode == 201)
    {
        
    }
    
    else if (strstatuscode == 404)
    {
        
    }
    else if (strstatuscode == 401)
    {
    }
    else if (strstatuscode == 400)
    {
    }
    
    else if (strstatuscode == 500)
    {
        
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

#pragma mark - UITableview method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayCategoryName.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryListCell";
    
    CategoryListTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[CategoryListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:CellIdentifier];
        
        cell1.lblCategoryName.tag = indexPath.row;
        cell1.imageCategory.tag = indexPath.row;
        
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imgview.backgroundColor = [UIColor clearColor];
        cell1.selectedBackgroundView  = imgview;
        
        cell1.btncheckmark.tag = indexPath.row;
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 10)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:separatorLineView];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    
    NSLog(@"index row %ld",(long)indexPath.row);
    NSLog(@"new index %d",newIndex);

    if ((indexPath.row+1) == newIndex) {
        [cell1.btncheckmark setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [cell1.btncheckmark setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];

    }
    else
    {
        [cell1.btncheckmark setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
        [cell1.btncheckmark setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];

    }

    cell1.lblCategoryName.text = [arrayCategoryName objectAtIndex:indexPath.row];
    cell1.lblCategoryName.numberOfLines = 2;
//    cell1.imageCategory.image = [UIImage imageWithData:[arrayCategoryImage objectAtIndex:indexPath.row]];
    cell1.imageCategory.image = [UIImage imageNamed:@"lodingicon.png"];

//    [MBProgressHUD showHUDAddedTo:cell1.imageCategory animated:YES];
    NSString *strImage = [arrayCategoryImage objectAtIndex:indexPath.row];
    
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
            cell1.imageCategory.image = (UIImage*)image;
        }
        else
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
             {
                 if (connectionError == nil)
                 {
                     cell1.imageCategory.image = [UIImage imageWithData:data];
                     [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                     
                 }
             }];
        }
        
    }


    return cell1;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index row %ld",(long)indexPath.row);
    newIndex = (int)indexPath.row+1;

    [tblCategorylist reloadData];
    
    strCategoryName = [arrayCategoryName objectAtIndex:indexPath.row];
    strCategoryId = [arrayCategoryId  objectAtIndex:indexPath.row];
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
