//
//  UniversityNotListedViewController.h
//  Thriftskool
//
//  Created by Asha on 18/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UniversityNotListedViewController : UIViewController<UITextFieldDelegate,ConnectionDelegate,UIGestureRecognizerDelegate>
{
     UIView *viewUniversitynotListed;
     UITextField *txtUniName;
     UITextField *txtEmail;
     UIButton  *btnsend;
     UILabel *lbl;
}

@end
