//
//  WatchListViewController.h
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchListDetailViewController.h"

@interface WatchListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblWatchList;
    
    NSMutableArray *arrayBuzzDetails;
    NSMutableArray *arrayDetails;
    NSMutableArray *arrayBuzzImageList;
    NSMutableArray *arrayDetailsImageList;
    NSMutableArray *arrayMain;
    NSMutableArray *arrayAllImages;
    BOOL IsFromWatchDetailPage;
    
    UILabel *lblNoList;
    CustomActionSheet *actionSheet;
    int btnSelectedIndex;
    int btnFavTag;
    
    UIActivityIndicatorView *footerHud;
    BOOL isLoadingMore;
    BOOL btnFavClicked;
    BOOL btnSortingClicked;




}

@property (nonatomic) int userID;
@property (nonatomic) int postCatID;
@property (nonatomic) int universityID;
@property (nonatomic,retain) NSString *strSelectedCategoryName;
@property (nonatomic, retain) NSString *strUserName;

@property (nonatomic, retain) WatchListDetailViewController *watchdetailObj;


@end
