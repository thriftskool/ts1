//
//  HomeViewController.h
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCategoryPostListViewController.h"


@interface HomeViewController : UIViewController<UISearchBarDelegate,UINavigationBarDelegate>
{
    IBOutlet UIScrollView *scrollview;
    IBOutlet UIView *navigationView;
    
    NSMutableDictionary *dictUniversityList;
    NSMutableArray *arraCategoryName;
    NSMutableArray *arrayPostImageList;
    NSMutableArray *arrayBgImageList;
    NSMutableArray *arrayPostIdList;
    BOOL IsFromNextPage;
    SelectCategoryPostListViewController *selectcatpostlistObj;
    
    UIButton *btnBell;

}

@property (nonatomic) int userID;
@property (nonatomic) int postCatID;
@property (nonatomic) int universityID;
@property (nonatomic) NSString *strUniversityName;
@property (nonatomic) NSString *strUserName;

@property (nonatomic, retain)   SelectCategoryPostListViewController *selectcatpostlistObj;
@property (nonatomic,retain) NSString *strLogin;



@end
