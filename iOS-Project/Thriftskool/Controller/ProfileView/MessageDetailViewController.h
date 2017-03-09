//
//  MessageDetailViewController.h
//  Thriftskool
//
//  Created by Asha on 25/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ConnectionDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet  UILabel *lblPostName;
    IBOutlet  UITextField *txtmsg;
    IBOutlet  UILabel *imgviewLine;
    IBOutlet  UIButton *btnSend;
    IBOutlet  UITableView *tblviewMsgDetail;
    
    NSMutableArray *arrayMsgDetail;
    IBOutlet NSLayoutConstraint *keyboardHeight;
    IBOutlet NSLayoutConstraint *keyboardbtnSend;
    NSString *strSectionName;
    
    
    NSMutableArray *headerTitle;
    NSMutableDictionary *sections;
    NSMutableArray *Arraysection;
    
    
}
@property (nonatomic, retain) NSString *strPostName;
@property (nonatomic) int threadID;
@property (nonatomic) int readID;
@property (nonatomic) int postID;
@property (nonatomic) BOOL FromReplyBtn;
@property (nonatomic,retain) NSMutableArray *arrayFromMsgViewList;
@property (nonatomic) BOOL FromNextPage;
@property (nonatomic) BOOL IsFromMsgList;
//@property (nonatomic, retain) NSString *strUserName;

@property (strong, nonatomic) NSMutableDictionary*	options;


@end
