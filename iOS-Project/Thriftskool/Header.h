//
//  Header.h
//  Thriftskool
//
//  Created by Asha on 18/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#ifndef Thriftskool_Header_h
#define Thriftskool_Header_h

typedef NS_ENUM(NSUInteger, Category) {
    Search=0,
    Other=1,
};
typedef NS_ENUM(NSUInteger, MsgType) {
    Notification=0,
    Message=1,
};



#define DEFAULT_HEIGHT_OFFSET 50.0f
#define cellHeight 90

//#define MainURL @"http://www.etilox.com/clients/thriftskool/mobileapp/webservice/"//local url
#define MainURL @"https://www.thriftskool.com/mobileapps/thriftskool/webservice/" //Client URl
//#define MainURL @"http://52.72.29.28/www.thriftskool.com/mobileapps/thriftskool/index.php/webservice/"
//#define MainURL @"https://www.thriftskool.com/mobileapps/test_thriftskool/webservice/" //Test URl





#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define appDelegate  ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define ipadDevice   [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define tabBarHeight self.tabBarController.tabBar.frame.size.height
#define navBarHeight self.navigationController.navigationBar.frame.size.height

#define NavigationBarBgColor [UIColor colorWithRed:57.0/255.0 green:182.0/255.0 blue:91.0/255.0 alpha:1.0]
#define NavigationTitleColor [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
#define tableBackgroundColor [UIColor colorWithRed:236.0/255.0 green:236.00/255.0 blue:236.0/255.0 alpha:1.0]
#define txtFieldTextColor    [UIColor colorWithRed:84.0/255.0 green:83.0/255.0 blue:83.0/255.0 alpha:1.0]
#define userNameInProfile    [UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.0]

#define FontRegular    [UIFont fontWithName:@"MyriadPro-Regular" size:18.0]
#define FontRegular12  [UIFont fontWithName:@"MyriadPro-Regular" size:12.0]
#define FontRegular14  [UIFont fontWithName:@"MyriadPro-Regular" size:14.0]
#define FontRegular15  [UIFont fontWithName:@"MyriadPro-Regular" size:15.0]

#define FontRegular16  [UIFont fontWithName:@"MyriadPro-Regular" size:16.0]
#define FontRegular20  [UIFont fontWithName:@"MyriadPro-Regular" size:20.0]
#define FontBold       [UIFont fontWithName:@"MyriadPro-Bold" size:18.0]
#define FontBold14     [UIFont fontWithName:@"MyriadPro-Bold" size:14.0]
#define FontBold16     [UIFont fontWithName:@"MyriadPro-Bold" size:16.0]

#define FontTypeName    @"FontAwesome"

#endif
