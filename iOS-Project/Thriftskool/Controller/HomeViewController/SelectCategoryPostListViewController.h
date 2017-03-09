//
//  SelectCategoryPostListViewController.h
//  Thriftskool
//
//  Created by Asha on 03/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCategoryPostDetailViewController.h"
#import "MBProgressHUD.h"
#import "CustomActionSheet.h"

@interface SelectCategoryPostListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIActionSheetDelegate,CustomActionViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblselectcatList;
    NSMutableDictionary *dictCatpostList;
    NSMutableArray *arrayTitleList;
    NSMutableArray *arrayPostImageList;
    NSMutableArray *arrayExpDateList;
    NSMutableArray *arrayPriceList;
    NSMutableArray *arrayAllDetail;
    BOOL FromPostDetailPage;
    Category SelectCategory;
    
    CustomActionSheet *actionSheet;
    int btnSelectedIndex;
    
    NSDictionary *dicSearchList;
    UIRefreshControl *refreshControl;
    UIActivityIndicatorView *footerHud;
    BOOL isLoadingMore;
    UILabel *lblNoList;
    int favBtnStatus;
    
    BOOL btnFavClicked;
    BOOL btnSortingClicked;

    


    
}
@property(nonatomic)    Category SelectCategory;
@property (nonatomic) int userID;
@property (nonatomic) int postCatID;
@property (nonatomic) int universityID;
@property (nonatomic,retain) NSString *strSelectedCategoryName;
@property (nonatomic, retain) NSDictionary *dicSearchList;
@property (nonatomic, retain) NSString *strUserName;
@property (nonatomic) BOOL clickedResendBtn;

@property (nonatomic, retain)  SelectCategoryPostDetailViewController *selectDetailObj;
@end
