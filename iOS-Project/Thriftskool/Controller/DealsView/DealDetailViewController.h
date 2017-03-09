//
//  DealDetailViewController.h
//  Thriftskool
//
//  Created by Asha on 11/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOSAlertView.h"


@interface DealDetailViewController : UIViewController<ConnectionDelegate,UIAlertViewDelegate,CustomIOSAlertViewDelegate,UIGestureRecognizerDelegate>
{
    UIView *viewBuzzDetail;
    UIView *viewscroll;
    UIScrollView *scrollviewimage;
    UILabel *lblName;
    UILabel *lblDate;
    UILabel *lblExpired;
    UITextView *txtviewDecscription;
    UIButton *btnViewCode;
    
    NSMutableArray *arrayImageList;
    BOOL IsFromOpenImageView;

}

//@property (nonatomic) int userID;
//@property (nonatomic) NSMutableArray *arrayDealDetail;

@property (nonatomic) NSMutableDictionary *dicDealDetail;
@property (nonatomic, retain) NSString *strTitleName;

@end
