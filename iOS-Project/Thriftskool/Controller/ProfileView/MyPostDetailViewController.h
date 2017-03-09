//
//  MyPostDetailViewController.h
//  Thriftskool
//
//  Created by Asha on 09/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPostDetailViewController : UIViewController<ConnectionDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    UIView *viewMyPostDetail;
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
    NSMutableArray *arrayAllMyPostData;
    NSMutableArray *arrayBuzzImageList;
    
    UIView *view1;
    BOOL IsFromOpenImageView;
    int status;
    NSString *strStatusName;
    int btnIndex;
    
    UIButton *btnEdit;
    UIButton *btnEditImg;
    MsgType SelectMsgType;
    

}

@property (nonatomic, retain) NSMutableDictionary *dictPostDetail;
@property (nonatomic, retain) NSString *strTitleName;
@property (nonatomic) MsgType SelectMsgType;

@end
