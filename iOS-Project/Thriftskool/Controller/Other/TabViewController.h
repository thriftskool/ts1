//
//  TabViewController.h
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "CreatePostViewController.h"
#import "ProfileViewController.h"
#import "DealsViewController.h"
#import "BuzzViewController.h"
#import "AppDelegate.h"

@interface TabViewController : UIViewController<UITabBarControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) NSString *strUserName;
@property (nonatomic, retain) NSString *strUniversityName;
@property (nonatomic, retain) NSString *strEmail;
@property (nonatomic) int universityID;
@property (nonatomic) int userID;



@property (nonatomic, retain)   HomeViewController *homeviewObj;
@property (nonatomic, retain)   CreatePostViewController *createpostObj;
@property (nonatomic, retain)   ProfileViewController *profileObj;
@property (nonatomic, retain)   DealsViewController *dealsviewObj;
@property (nonatomic, retain)   BuzzViewController *buzzviewObj;
@property (nonatomic, retain)   UITabBarController *tabBars;
@property (nonatomic, retain)   NSString *strLogin;

@end
