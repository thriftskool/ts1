//
//  TabViewController.m
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "TabViewController.h"


@interface TabViewController ()

@end

@implementation TabViewController
@synthesize homeviewObj,createpostObj,profileObj,dealsviewObj,buzzviewObj,tabBars;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        self.navigationController.navigationBar.hidden = YES;
        self.tabBarController.tabBar.hidden = YES;
        
        UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        imageview.image = [UIImage imageNamed:@"bg.png"];
        [self.view addSubview:imageview];
        
        UILabel *lblnetwork = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, screenWidth-20, 60)];
        lblnetwork.text = @"Your device is not connected with Internet. Please check your device Internet settings.";
        lblnetwork.numberOfLines = lblnetwork.frame.size.height/lblnetwork.font.lineHeight;
        lblnetwork.font = FontRegular14;
        lblnetwork.textColor = [UIColor whiteColor];
        lblnetwork.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lblnetwork];
        
        UIButton * tryAgain = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2-50, 100, 100, 30)];
        [tryAgain setTitle:@"Try Again" forState:UIControlStateNormal];
        tryAgain.layer.cornerRadius = 6.0;
        tryAgain.layer.borderWidth = 1.0;
        tryAgain.layer.borderColor = [UIColor whiteColor].CGColor;
        [tryAgain addTarget:self action:@selector(btnTryAgianClicked) forControlEvents:UIControlEventTouchUpInside];
        tryAgain.titleLabel.font = FontRegular16;
        [self.view addSubview:tryAgain];
        
        
    }
    else
    {
        self.navigationController.navigationBar.hidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        
        NSUserDefaults *defalts= [NSUserDefaults standardUserDefaults];
        //NSArray *loginarray = [[defalts valueForKey:@"loginArray"] valueForKey:@"Response"];
        NSMutableDictionary *inarray= [NSKeyedUnarchiver unarchiveObjectWithData:[defalts objectForKey:@"loginArray"]];
        NSMutableDictionary *loginarray=[inarray objectForKey:@"Response"];
        if (loginarray == nil) {
            loginarray = [defalts valueForKey:@"loginArray"];
        }
        
        if (loginarray.count > 0)
        {
            
            _strUserName = [loginarray  valueForKey:@"user_name"];
            _strUniversityName =[loginarray  valueForKey:@"university_name"];
            _userID = [[loginarray  valueForKey:@"login_id"] intValue] ;
            _strEmail=[loginarray  valueForKey:@"email_id"] ;
            _universityID = [[loginarray  valueForKey:@"university_id"] intValue];
            
            [GlobalMethod shareGlobalMethod].userID = _userID;
            [[GlobalMethod shareGlobalMethod] afterUserSet];
            [GlobalMethod shareGlobalMethod].strUserName = _strUserName;
            [Mint sharedInstance].userIdentifier = [GlobalMethod shareGlobalMethod].strUserName;

            
        }
        
        self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        // Override point for customization after application launch.
        
        //    UITabBarController *
        tabBars = [[UITabBarController alloc] init];
        
        UINavigationController *nav1 = [[UINavigationController alloc] init];
        nav1.navigationBar.barTintColor = NavigationBarBgColor;
        nav1.navigationBar.tag = 1;
        homeviewObj= [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        homeviewObj.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Home" image:[UIImage imageNamed:@"home.png"] selectedImage:[UIImage imageNamed:@"home.png"]];
        homeviewObj.tabBarItem.image = [[UIImage imageNamed:@"home.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        homeviewObj.userID = _userID;
        homeviewObj.universityID = _universityID;
        homeviewObj.strUniversityName = _strUniversityName;
        homeviewObj.strUserName  =_strUserName;
        homeviewObj.strLogin = _strLogin;
        nav1.viewControllers = [NSArray arrayWithObjects:homeviewObj, nil];
        
        UINavigationController *nav2 = [[UINavigationController alloc] init];
        nav2.navigationBar.barTintColor = NavigationBarBgColor;
        nav2.navigationBar.tag = 2;
        createpostObj= [self.storyboard instantiateViewControllerWithIdentifier:@"CreatePostViewController"];
        createpostObj.userID = _userID;
        createpostObj.universityID = _universityID;
        createpostObj.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Post" image:[UIImage imageNamed:@"post.png"] selectedImage:[UIImage imageNamed:@"post.png"]];
        createpostObj.tabBarItem.image = [[UIImage imageNamed:@"post.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        nav2.viewControllers = [NSArray arrayWithObjects:createpostObj, nil];
        
        UINavigationController *nav3 = [[UINavigationController alloc] init];
        nav3.navigationBar.barTintColor = NavigationBarBgColor;
        nav3.navigationBar.tag = 3;
        profileObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        profileObj.strUniversityName = _strUniversityName;
        profileObj.strUsername = _strUserName;
        profileObj.strEmail = _strEmail;
        profileObj.userID = _userID;
        profileObj.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Profile" image:[UIImage imageNamed:@"profile.png"] selectedImage:[UIImage imageNamed:@"profile.png"]];
        profileObj.tabBarItem.image = [[UIImage imageNamed:@"profile.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        

        
        nav3.viewControllers = [NSArray arrayWithObjects:profileObj, nil];
        
        UINavigationController *nav4 = [[UINavigationController alloc] init];
        nav4.navigationBar.barTintColor = NavigationBarBgColor;
        nav4.navigationBar.tag = 4;
        dealsviewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DealsViewController"];
        dealsviewObj.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Deals" image:[UIImage imageNamed:@"deals.png"] selectedImage:[UIImage imageNamed:@"deals.png"]];
        dealsviewObj.tabBarItem.image = [[UIImage imageNamed:@"deals.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        dealsviewObj.userID = _userID;
        dealsviewObj.universityID = _universityID;
        
        nav4.viewControllers = [NSArray arrayWithObjects:dealsviewObj, nil];
        
        UINavigationController *nav5 = [[UINavigationController alloc] init];
        nav5.navigationBar.barTintColor = NavigationBarBgColor;
        nav5.navigationBar.tag = 5;
        buzzviewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"BuzzViewController"];
        buzzviewObj.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Buzz" image:[UIImage imageNamed:@"buzz.png"] selectedImage:[UIImage imageNamed:@"buzz.png"]];
        buzzviewObj.tabBarItem.image = [[UIImage imageNamed:@"buzz.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        buzzviewObj.userID = _userID;
        buzzviewObj.universityID = _universityID;
        nav5.viewControllers = [NSArray arrayWithObjects:buzzviewObj, nil];
        
        tabBars.viewControllers = [NSArray arrayWithObjects:nav1,nav2,nav3,nav5,nil];//hide deal section
        [tabBars.tabBar setTintColor:[UIColor whiteColor]];
        tabBars.tabBar.barTintColor = NavigationBarBgColor;
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : FontRegular12,
                                                            NSForegroundColorAttributeName : [UIColor colorWithRed:88.0/255.0 green:96.0/255.0 blue:91.0/255.0 alpha:1.0]
                                                            } forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : FontRegular12,
                                                            NSForegroundColorAttributeName : [UIColor whiteColor]
                                                            } forState:UIControlStateSelected];


        
        //    UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarNavigation"];
        appDelegate.window.rootViewController = tabBars;
        [appDelegate.window makeKeyAndVisible];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(void)btnTryAgianClicked
{
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        [self viewDidLoad];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"view %@",viewController);
    return YES;
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
