//
//  SendMessageViewController.h
//  Thriftskool
//
//  Created by Asha on 16/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessageViewController : UIViewController<ConnectionDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UIButton *btnsend;
    IBOutlet UITextView *txtview;
    IBOutlet UILabel *lbl;
    NSArray *userInfo;
}

@property (nonatomic) BOOL IsContactBtnClicked;
@property (nonatomic) int postID;
@property (nonatomic) int userId;
@property (nonatomic, retain) NSString *strPostName;
@property (nonatomic, retain) NSString *strUserName;

@end
