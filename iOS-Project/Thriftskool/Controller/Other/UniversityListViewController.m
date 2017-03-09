//
//  UniversityListViewController.m
//  Thriftskool
//
//  Created by Asha on 18/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "UniversityListViewController.h"
#import "UniversityListTableViewCell.h"
//#import "Header.h"
#import "UIView+Toast.h"
#import "UniversityNotListedViewController.h"

@interface UniversityListViewController ()

@end


@implementation UniversityListViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:NavigationBarBgColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"SELECT UNIVERSITY";
    

    //LeftSide Button
    UIButton *btnleftside = [UIButton buttonWithType:UIButtonTypeCustom];
    btnleftside.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btnleftside.frame = CGRectMake(0, 0, 20.0, 50.0);
    [btnleftside setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnleftside setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [btnleftside addTarget:self action:@selector(btnleftsideClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewleftside = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20.0, 50.0)];
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
    
    
    tblUniversityList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    
    tblUniversityList.backgroundColor = tableBackgroundColor;
    tblUniversityList.showsVerticalScrollIndicator = false;
    self.view.backgroundColor = tableBackgroundColor;
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swiperight:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];

    

}
-(void)btnDoneClicked:(id)sender
{
    if ([delegate respondsToSelector:@selector(selectUniversityName:domain:id:imgName:)])
    {
        [delegate selectUniversityName:strUniversityName domain:strDomainName id:UniversityId imgName:UniversityImgName];
    }
    [self.navigationController popViewControllerAnimated:YES];

}
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

-(void)viewWillAppear:(BOOL)animated
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    arrayImageData  = [defaults valueForKey:@"ImageName"];
//    NSData *data = [defaults objectForKey:@"ImageName"];
//    arrayImageData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//
//    arrayUniversitylist = [defaults valueForKey:@"UniversityList"];
//    arrayDomainName = [defaults valueForKey:@"DomainName"];
//    arrayUniversityId =  [defaults valueForKey:@"UniversityId"];
//    arrayImageList =  [defaults valueForKey:@"UniversityImgName"];

    if (!arrayAllUniversitylist) {
        NSLog(@"not record");
    }

    if (arrayImageData.count <1 || arrayUniversitylist.count <1 || arrayImageList.count <1) {
        if([GlobalMethod shareGlobalMethod].connectedToNetwork)
        {
            self.navigationController.view.userInteractionEnabled = false;
            self.tabBarController.view.userInteractionEnabled = false;

            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [ConnectionServer sharedConnectionWithDelegate:self].serviceName=@"university_list";
//            [[ConnectionServer sharedConnectionWithDelegate:self]getDataFromServer:@"university_list"];
            [[ConnectionServer sharedConnectionWithDelegate:self] GetStartUp:nil caseName:@"university_list" withToken:NO];

        }
        else
        {
            [self.view makeToast:NSLocalizedString(@"InternetAvailable", nil)];
        }
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

    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (strstatuscode == 500) {
        [self.view makeToast:@"Internal server error"];
    }
    
    if (strstatuscode == 200)
    {
        if ([nState isEqualToString:@"university_list"])
        {
            self.navigationController.view.userInteractionEnabled = true;
            self.tabBarController.view.userInteractionEnabled = true;
            
            NSMutableDictionary *dictUniversityList = (NSMutableDictionary*)arrData;
            
            NSString *strImagepath=@"";
            if([[dictUniversityList valueForKey:@"Response"] valueForKey:@"imagepath"])
            {
                strImagepath = [[dictUniversityList valueForKey:@"Response"] valueForKey:@"imagepath"];
                
            }
            if([[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"])
            {
                id allData = [[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"];
                if([allData isKindOfClass:[NSMutableArray class]])
                {
                    if(!arrayAllUniversitylist)
                    {
                        arrayAllUniversitylist=[[NSMutableArray alloc]init];
                    }
                    NSArray *allPostDetail = (NSArray*)allData;
                    NSArray *arrayImage2 = [[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"];
                    for (int i = 0; i < allPostDetail.count; i++) {
                        NSMutableDictionary *objPostDic = [allPostDetail objectAtIndex:i];
                        NSString *strImage=@"";
                        strImage = [NSString stringWithFormat:@"%@%@",strImagepath,[arrayImage2 objectAtIndex:i]];
                        [objPostDic setValue:strImage forKey:@"imagepathurl"];
                        [arrayAllUniversitylist addObject:objPostDic];
                    }
                }
            }
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setValue:@"University not listed?" forKey:@"university_name"];
            [arrayAllUniversitylist addObject:dict];
//
            arrayDomainName = [[NSMutableArray alloc]initWithArray:[[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"domain_name"]];
            arrayUniversityId = [[NSMutableArray alloc]initWithArray:[[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"university_id"]];
            arrayUniversitylist = [[NSMutableArray alloc]initWithArray:[[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"university_name"]];
            arrayImageList =  [[NSMutableArray alloc]initWithArray:[[[dictUniversityList valueForKey:@"Response"] valueForKey:@"Details"] valueForKey:@"image"]];
            
            imagepath= [[dictUniversityList valueForKey:@"Response"] valueForKey:@"imagepath"];
            
            
            for (int i = 0; i < arrayImageList.count; i++) {
                
                NSString *str = [NSString stringWithFormat:@"%@%@",imagepath,[arrayImageList objectAtIndex:i]];

                if (!arrayImageData) {
                    arrayImageData = [[NSMutableArray alloc]init];
                }
                [arrayImageData addObject:str];
                
            }
//
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [arrayUniversitylist addObject:@"University not listed?"];
            [defaults setObject:arrayUniversitylist forKey:@"UniversityList"];
            [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:arrayImageData] forKey:@"ImageName"];
            [defaults setObject:arrayDomainName forKey:@"DomainName"];
            [defaults setObject:arrayUniversityId forKey:@"UniversityId"];
            [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:arrayImageList] forKey:@"UniversityImgName"];

            [defaults synchronize];
            
            NSLog(@"arrayUniversitylist %@",arrayUniversitylist);
            [tblUniversityList reloadData];
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
    return arrayUniversitylist.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UniversityListcell";
    
    UniversityListTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[UniversityListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CellIdentifier];
        
        cell1.lblUniversityName.tag = indexPath.row;
        cell1.imageUniversity.tag = indexPath.row;
        
        UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imgview.backgroundColor = [UIColor clearColor];
        cell1.selectedBackgroundView  = imgview;
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 10)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [cell1.contentView addSubview:separatorLineView];
        
        [cell1 setSelectionStyle:UITableViewCellSelectionStyleNone];

        
    }
    
    cell1.lblUniversityName.text = [[arrayAllUniversitylist valueForKey:@"university_name"] objectAtIndex:indexPath.row];
    cell1.lblUniversityName.numberOfLines = 2;
    
//    cell1.imageUniversity.image = [UIImage imageWithData:[arrayImageData objectAtIndex:indexPath.row]];
    cell1.imageUniversity.image = nil;
    cell1.imageUniversity.image = [UIImage imageNamed:@"lodingicon.png"];

//    [MBProgressHUD showHUDAddedTo:cell1.imageUniversity animated:YES];
    if ([cell1.lblUniversityName.text isEqualToString:@"University not listed?"])
    {
        cell1.imageUniversity.image = [UIImage imageNamed:@"help.png"];
//        UIImageView *imageview = cell1.imageUniversity;
//        [MBProgressHUD hideAllHUDsForView:imageview animated:YES];

    }
    else{
        NSString *strImage = [[arrayAllUniversitylist valueForKey:@"imagepathurl"] objectAtIndex:indexPath.row];
        
        //    if (![strImage isEqual:[NSNull null]])
        if (![strImage hasSuffix:@"<null>"])
        {
            NSURL *url = [NSURL URLWithString:strImage];
            NSString *cacheFilename = [url lastPathComponent];
//            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
            int index = (int)[url pathComponents].count-3;
            NSString *folderName =[[url pathComponents] objectAtIndex:index];
            
            NSLog(@"folderName %@",folderName);
            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];

            id image = [LazyLoadingImage imageDataFromPath:cachePath];
            if(image)
            {
                cell1.imageUniversity.image = (UIImage*)image;
                
            }
            else
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                 {
                     if (connectionError == nil)
                     {
                         cell1.imageUniversity.image = [UIImage imageWithData:data];
                         [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                         
                         
                     }
                 }];
            }
            
        }
        else
        {
            cell1.imageUniversity.image = [UIImage imageNamed:@"lodingicon.png"];
            
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
    int uniCount =(int)arrayUniversitylist.count-1;
    
    if (uniCount == indexPath.row) {
        
        UniversityNotListedViewController *univernotlistObj = [self.storyboard instantiateViewControllerWithIdentifier:@"UniversityNotListedViewController"];
        [self.navigationController pushViewController:univernotlistObj animated:YES];
        
        if (![[arrayUniversitylist objectAtIndex:indexPath.row] isEqualToString:@"University not listed?"]) {
            strUniversityName = [arrayUniversitylist objectAtIndex:indexPath.row];

        }

        
    }
    else{
        UIButton *btncheckmark = [UIButton buttonWithType:UIButtonTypeCustom];
        btncheckmark.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
        btncheckmark.frame = CGRectMake(0, 5, 20.0, 20.0);
        [btncheckmark setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        [btncheckmark setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];
        btncheckmark.tag = indexPath.row;
//        btncheckmark.backgroundColor = [UIColor redColor];
        [tableView cellForRowAtIndexPath:indexPath].accessoryView = btncheckmark;
        
        strUniversityName = [arrayUniversitylist objectAtIndex:indexPath.row];
        strDomainName = [arrayDomainName  objectAtIndex:indexPath.row];
        UniversityId = [arrayUniversityId objectAtIndex:indexPath.row];
        UniversityImgName = [arrayImageList objectAtIndex:indexPath.row];
        
        
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btncheckmark = [UIButton buttonWithType:UIButtonTypeCustom];
    btncheckmark.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:30.0];
    btncheckmark.frame = CGRectMake(0, 0, 10.0, 20.0);
    [btncheckmark setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
    [btncheckmark setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryView = btncheckmark;
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
