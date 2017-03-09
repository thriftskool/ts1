//
//  EditPostViewController.h
//  Thriftskool
//
//  Created by Asha on 15/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSKImageCropper.h"

@interface EditPostViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate,RSKImageCropViewControllerDelegate>
{
    IBOutlet UIView *editPostView;
    IBOutlet  UIScrollView *scrollview;
    int rowHeight;

    UIView *viewphoto;
    UILabel *lblAddphoto;
    
    UIView *viewtitle;
    UILabel *lblTitle;
    UITextField *txtTitle;
    
    UIView *viewChooseCategory;
    UILabel *lblChooseCategory;
    UITextField *txtChooseCategory;
    
    UIView *viewDescription;
    UILabel *lblviewDescription;
    UITextView *txtviewDescription;
    
    UIView *viewPrice;
    UILabel *lblPrice;
    UITextField *txtPrice;
    
    UIView *viewExpirationDate;
    UILabel *lblExpirationDate;
    UITextField *txtExpirationDate;
    
    UIDatePicker *datepicker;

    
    UIImageView *imageview;
    NSMutableArray *imageArray;
    
    NSString *strExpirationDate;
    NSString *strCurrentDate;
    NSDate *ExpirationDate;

    NSMutableArray *arrayPostData;
    NSMutableArray *arrayImageData;
    BOOL IsDataDisplay;
    
    IBOutlet NSLayoutConstraint *keyboardHeight;


}

@property (nonatomic) int userID;
@property (nonatomic) int postID;
@property (nonatomic) int universityID;
@property (nonatomic, retain) NSString *strTitleName;

@end
