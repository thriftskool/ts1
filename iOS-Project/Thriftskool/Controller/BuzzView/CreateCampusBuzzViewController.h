//
//  CreateCampusBuzzViewController.h
//  Thriftskool
//
//  Created by Asha on 10/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateCampusBuzzViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UIView *createBuzzView;
    IBOutlet  UIScrollView *scrollview;
    
    UIView *viewphoto;
    UILabel *lblAddphoto;
    UITextField *txtTitle;
    UITextView *txtviewDescription;
    UITextField *txtExpirationDate;
    UIButton *btnImg;
    UIButton *btnCheckmark;
    UIDatePicker *datepicker;
    
    UIImageView *imageview;
    NSMutableArray *imageArray;

    
    BOOL checkmarkSelected;
    
    NSString *strExpirationDate;
    NSString *strCurrentDate;
    NSDate *ExpirationDate;
    
    int rowHeight;
    

}

@property (nonatomic) int userID;
@property (nonatomic) int universityID;

@end
