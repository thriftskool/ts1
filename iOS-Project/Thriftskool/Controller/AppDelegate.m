





//
//  AppDelegate.m
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "AppDelegate.h"
#import "MessagesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window,tabviewControllerObj,appdel;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[Mint sharedInstance] initAndStartSession:@"b5b79c3a"];
    [Mint sharedInstance].userIdentifier = @"";
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:NavigationTitleColor,NSForegroundColorAttributeName ,
      FontRegular,NSFontAttributeName,nil]];
    [[UINavigationBar appearance]setBackgroundColor:NavigationBarBgColor];
    [[UITabBar appearance] setItemWidth:(screenWidth/5)-30];

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    if (!appdel) {
        appdel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    }
//
  
    if(![[NSUserDefaults standardUserDefaults]boolForKey:@"isuserGuide"])
    {
        UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"userGuideNav"];
        appdel.window.rootViewController = nav;
    }
    else
    {
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        BOOL userlogin = [[userdefaults valueForKey:@"userLogin"] boolValue];
        if (userlogin)
        {
            UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"tabBarNavigation"];
            appdel.window.rootViewController = nav;
        }
        else
        {
            UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"navigationController2"];
            appdel.window.rootViewController = nav;
            
    //        if (application.applicationIconBadgeNumber > 0)
    //        {
    //            application.applicationIconBadgeNumber = 0;
    //        }

        }
    }
    tabviewControllerObj = [storyboard instantiateViewControllerWithIdentifier:@"TabViewController"];
    
    NSLog(@"Registering for push notifications...");
     if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<9.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
     else if ([[[UIDevice currentDevice] systemVersion] floatValue] >=9.0)
     {
         
         UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
         [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

     }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeNewsstandContentAvailability| UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }

    if (application.applicationIconBadgeNumber > 0)
    {
        application.applicationIconBadgeNumber = 0;
    }

    
    appEnterInBackGround = true;
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *strDeviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"DeviceToken"];
    NSLog(@"devicetoken---%@", strDeviceToken);
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"DeviceToken!!!" message:token delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    //    [alert show];
    NSLog(@"application.applicationIconBadgeNumber %ld",(long)app.applicationIconBadgeNumber);
//    [GlobalMethod shareGlobalMethod].notificationCount = (int)app.applicationIconBadgeNumber;

}
- (void)application:(UIApplication *)application   didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
    NSLog(@"application.applicationIconBadgeNumber %ld",(long)application.applicationIconBadgeNumber);
//    [GlobalMethod shareGlobalMethod].notificationCount = (int)application.applicationIconBadgeNumber;

}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"notify userinfo:%@",userInfo);
    NSLog(@"application.applicationIconBadgeNumber %ld",(long)application.applicationIconBadgeNumber);
    
    application.applicationIconBadgeNumber = [[[userInfo valueForKey:@"aps"]valueForKey:@"badge"] intValue];

    if (appEnterInBackGround == false)
    {
        NSLog(@"appEnterInBackGround");
   
      [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:nil userInfo:userInfo];
      [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber-1;
      appEnterInBackGround = true;
    }
    else
    {
//        [GlobalMethod shareGlobalMethod].notificationCount = (int)[UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    }
    
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"application.applicationIconBadgeNumber %ld",(long)application.applicationIconBadgeNumber);
//    [GlobalMethod shareGlobalMethod].notificationCount = (int)application.applicationIconBadgeNumber;

//    if (application.applicationIconBadgeNumber > 0)
//    {
//        application.applicationIconBadgeNumber = 0;
//    }
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"error %@",error);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"application.applicationIconBadgeNumber %ld",(long)application.applicationIconBadgeNumber);
//    [GlobalMethod shareGlobalMethod].notificationCount = (int)application.applicationIconBadgeNumber;


}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"application.applicationIconBadgeNumber %ld",(long)application.applicationIconBadgeNumber);
//    [GlobalMethod shareGlobalMethod].notificationCount = (int)application.applicationIconBadgeNumber;

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    appEnterInBackGround = true;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        appEnterInBackGround = false;
    NSLog(@"application.applicationIconBadgeNumber %ld",(long)application.applicationIconBadgeNumber);
//    [GlobalMethod shareGlobalMethod].notificationCount = (int)application.applicationIconBadgeNumber;

//        if (application.applicationIconBadgeNumber > 0)
//        {
//            application.applicationIconBadgeNumber = 0;
//        }
    
//    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
//    BOOL userlogin = [[userdefaults valueForKey:@"userLogin"] boolValue];
//    if (!userlogin)
//    {
//        if (application.applicationIconBadgeNumber > 0)
//        {
//            application.applicationIconBadgeNumber = 0;
//        }
//
//    }

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%s",__PRETTY_FUNCTION__);
    appEnterInBackGround = true;


}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
