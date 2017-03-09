//
//  BuzzDetailViewController.h
//  Thriftskool
//
//  Created by Asha on 11/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzzDetailViewController : UIViewController<ConnectionDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
     UIView *viewBuzzDetail;
     UIView *viewscroll;
     UIScrollView *scrollviewimage;
     UILabel *lblName;
     UILabel *lblDate;
     UILabel *lblExpired;
     UITextView *txtviewDecscription;
     UIView *viewReport;
    
    NSMutableArray *arrayBuzzImageList;
    
    BOOL IsFromOpenImageView;

}

@property (nonatomic,retain) NSDictionary *dicBuzzDetail;
@property (nonatomic, retain) NSString *strTitleName;
@end
