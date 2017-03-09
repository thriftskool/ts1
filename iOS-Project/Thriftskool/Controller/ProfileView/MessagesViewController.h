//
//  MessagesViewController.h
//  Thriftskool
//
//  Created by Asha on 30/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesViewController : UIViewController<ConnectionDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblMessagesView;
    MsgType SelectMsgType;
    UIActivityIndicatorView *footerHud;
    BOOL isLoadingMore;
    UILabel *lblNoList;
    int indexRow;
    BOOL isDeleteBtnClicked;

    BOOL checkmarkSelected;
    NSMutableArray *checkmarkArray;
    NSMutableArray *tempArray;
    UIButton *btndelete;



}
@property (nonatomic) MsgType SelectMsgType;

//@property (nonatomic) int userId;
@property (nonatomic, retain) NSMutableArray *arraymsgList;
//@property (nonatomic, retain) NSMutableArray *arrayUrlImageList;
//@property (nonatomic,retain) NSString *strUserName;



@end
