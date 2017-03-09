//
//  DetailsViewController.h
//  Thriftskool
//
//  Created by Asha on 24/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ConnectionDelegate>
{
    BOOL IsFromDealsDetailsview;
    IBOutlet UITableView *tblDealList;
    NSMutableArray *arrayAllDealDetail;
    NSMutableArray *arrayDealImageslist;
    UILabel *lblNoList;
    UIActivityIndicatorView *footerHud;
    BOOL isLoadingMore;

    CustomActionSheet *actionSheet;
    int btnSelectedIndex;
     BOOL btnSortingClicked;

}

@property (nonatomic) int userID;
@property (nonatomic) int universityID;
@end
