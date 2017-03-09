//
//  PostOwnerListViewController.h
//  Thriftskool
//
//  Created by Asha on 05/11/16.
//  Copyright © 2016 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostOwnerListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblViewPostList;

    BOOL isFavClicked;
    int favBtnStatus;

}
@property (nonatomic,strong)NSMutableArray *arrayAllList;
@property (nonatomic,strong)NSString *strPostImagePath;

@property (nonatomic) int userID;
@property (nonatomic) int postCatID;
@property (nonatomic) int universityID;
@property (nonatomic,strong)NSString *strUserName;
@end
