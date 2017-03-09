//
//  BuzzViewController.h
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzzViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ConnectionDelegate>
{
    IBOutlet UITableView *tblBuzzList;
    
    NSMutableArray *arrayBuzzImageList;
    NSMutableArray *arrayAllBuzzListDetail;
    UILabel *lblNoList;
    BOOL IsFromBuzzDetailPage;
    
    UIActivityIndicatorView *footerHud;
    BOOL isLoadingMore;
    
    CustomActionSheet *actionSheet;
//    int btnSelectedIndex;
    BOOL btnSortingClicked;


}
@property (nonatomic) int btnSelectedIndex;
@property (nonatomic) int userID;
@property (nonatomic) int universityID;

@end
