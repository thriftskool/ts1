//
//  CreatePostViewController.h
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryListViewController.h"
#import "RSKImageCropper.h"

@interface CreatePostViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SelectCategoryNameDelegate,UIAlertViewDelegate,RSKImageCropViewControllerDelegate>
{
    IBOutlet UIView *createPostView;
    int rowHeight;
    
    IBOutlet  UIScrollView *scrollview;
    UIView *viewphoto;
    UILabel *lblAddphoto;
    UITextField *txtTitle;
    UITextField *txtChooseCategory;
    UITextView *txtviewDescription;
    UITextField *txtPrice;
    UITextField *txtExpirationDate;
    UIButton *btnImg;
    BOOL checkmarkSelected;
    UIButton *btnCheckmark;
    UIDatePicker *datepicker;
    
    UIImageView *imageview;
    NSMutableArray *imageArray;
    
    NSString *strExpirationDate;
    NSString *strCurrentDate;
    NSDate *ExpirationDate;
    

    
    IBOutlet NSLayoutConstraint *keyboardHeight;
}

@property (nonatomic) int userID;
@property (nonatomic) int universityID;
@property (nonatomic) int CategoryID;

@end
