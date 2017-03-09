//
//  MyPostsViewController.h
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPostDetailViewController.h"


@interface MyPostsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblMyPostList;
    
    NSMutableArray *arrayBuzzDetails;
    NSMutableArray *arrayDetails;
    NSMutableArray *arrayBuzzImageList;
    NSMutableArray *arrayDetailsImageList;
    NSMutableArray *arrayMainPost;
    NSMutableArray *arrayAllImages;
    UILabel * lblNoList;

    CustomActionSheet *actionSheet;
    int btnSelectedIndex;
    BOOL btnSortingClicked;

    int start;

    
    BOOL IsFromPostDetailPage;
    UIActivityIndicatorView *footerHud;
    BOOL isLoadingMore;

    BOOL checkmarkSelected;
    NSMutableArray *checkmarkArray;
    NSMutableArray *tempArray;
    UIButton *btndelete;
    BOOL isDeleteBtnClicked;
    NSMutableArray *arrayUnselectedmsg;


}

@property (nonatomic) int userID;
@property (nonatomic) int postCatID;
@property (nonatomic) int universityID;
@property (nonatomic,retain) NSString *strSelectedCategoryName;


@property (nonatomic, retain) MyPostDetailViewController *mypostDetailObj;
@end
