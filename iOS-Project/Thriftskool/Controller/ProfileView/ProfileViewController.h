//
//  ProfileViewController.h
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchListViewController.h"
#import "EditProfileViewController.h"
#import "MyPostsViewController.h"
#import "MessagesViewController.h"
#import <MessageUI/MessageUI.h>


@interface ProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
{
    IBOutlet UITableView *tblProfileView;
    NSArray *arrayProfileList;
    NSArray *arrayTextColorList;
    NSArray *arrayImageList;
    
    NSArray *arrayLoginDetails;
    int imgIndex;
    MessagesViewController *objMsgVC;

    
}

@property (nonatomic, retain) NSString *strUsername;
@property (nonatomic, retain) NSString *strUniversityName;
@property (nonatomic, retain) NSString *strEmail;
@property (nonatomic, retain) NSString *strUniversityImageName;
@property (nonatomic) int userID;


@property (nonatomic, retain) WatchListViewController *watchlistobj;
@property (nonatomic,retain)  EditProfileViewController *editprofileobj;
@property (nonatomic, retain) MyPostsViewController *mypostobj;
@end
