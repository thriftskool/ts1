//
//  WatchListDetailViewController.h
//  Thriftskool
//
//  Created by Asha on 09/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchListDetailViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    UIView *viewWatchDetail;
    UIView *viewscroll;
    UIScrollView *scrollviewimage;
    UIButton *btnfav;
    UILabel *lblName;
    UILabel *lblPrice;
    UILabel *lblDate;
    UILabel *lblExpired;
    UITextView *txtviewDecscription;
    UIView *viewButton;
    
    NSMutableArray *arrayImageList;
    NSMutableArray *arrayImageId;
    NSMutableArray *arrayAllSelectFavBtnData;

    BOOL IsFromWatchDetailPage;
    BOOL IsContactBtnClicked;
    BOOL IsReplyBtnClicked;
    
    int favBtnStatus;

}


@property (nonatomic) int userID;
@property (nonatomic, retain) NSMutableDictionary *dictSelectedWatchListDetail;
@property (nonatomic, retain) NSString *strUserName;
@property (nonatomic) BOOL btnfavSelected;

@end
