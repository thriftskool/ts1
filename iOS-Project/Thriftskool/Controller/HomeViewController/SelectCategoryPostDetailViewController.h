//
//  SelectCategoryPostDetailViewController.h
//  Thriftskool
//
//  Created by Asha on 07/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCategoryPostDetailViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIView *viewCategoryPostDetail;
    UIView *viewscroll;
    UIScrollView *scrollviewimage;
    UIButton *btnfav;
    UILabel *lblName;
    UILabel *lblPrice;
    UILabel *lblDate;
    UILabel *lblExpired;
    UITextView *txtviewDecscription;
    UIView *viewButton;
    int favBtnStatus;
    NSMutableArray *arrayImageList;
    NSMutableArray *arrayImageId;
    NSMutableArray *arrayAllSelectFavBtnData;
    
    BOOL IsNextPageOpen;
    NSString *strPost;
    
}
@property (nonatomic) int threadCount;
@property (nonatomic, retain) NSString *strNavigationTitle;
@property (nonatomic, retain) NSMutableDictionary *dictDetail;
@property (nonatomic) int userID;
@property (nonatomic, retain) NSString *strUserName;
@property (nonatomic, retain) NSMutableArray *arrayPostDetail;
@property (nonatomic) int postCatID;
@property (nonatomic) int universityID;
@end
