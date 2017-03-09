//
//  EditProfileViewController.h
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniversityListViewController.h"
#import "UIPopoverListView.h"
#import "RSKImageCropper.h"

@interface EditProfileViewController : UIViewController<UITextFieldDelegate,SelectUniversityNameDelegate,ConnectionDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPopoverListViewDataSource, UIPopoverListViewDelegate,RSKImageCropViewControllerDelegate>
{
    NSString *domainName1;
    //IBOutlet UILabel *lbldomain;
   
    
    IBOutlet UITableView *tblEditProfile;
    
    UIButton *btnAddPhoto;
    
    BOOL isChangePhoto;
    
    UIToolbar  *toolbar;
    
    NSArray *arrClassList;

    NSString *classid;
    
    BOOL checkProfileImageisDefault;
}


@property (nonatomic, retain) UITextField *txtuniversityName;
@property (nonatomic, retain) UITextField *txtEmail;
@property (nonatomic, retain) UITextField *txtUserName;
@property (nonatomic, retain) UITextField *txtClassName;
@property (nonatomic, retain) UITextField *txtName;

 @property (nonatomic, retain) UILabel *lblUniversityName;
@property (nonatomic, retain) UILabel *lblEmail;
@property (nonatomic, retain) UILabel *lblUserName;
@property (nonatomic, retain) UILabel *lblClassName;
@property (nonatomic, retain) UILabel *lblName;



@property (nonatomic, retain)  NSString *strUniversityName;
@property (nonatomic, retain)  NSString *strEmail;
@property (nonatomic, retain)  NSString *strUserName;
@property (nonatomic, retain) IBOutlet UIButton *btnSave;
@property (nonatomic, retain)  NSString *struniversityID;
@property (nonatomic, retain)  NSString *strUniversityImageName;
@property (nonatomic, retain)  NSDictionary *dicProfileDetail;



@property (nonatomic) int userID;

@end
