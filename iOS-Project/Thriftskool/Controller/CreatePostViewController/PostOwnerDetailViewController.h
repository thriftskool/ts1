//
//  PostOwnerDetailViewController.h
//  Thriftskool
//
//  Created by Asha on 16/10/16.
//  Copyright © 2016 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostOwnerDetailViewController : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UILabel *lblClassName;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblUserName;
    IBOutlet UIImageView *imgProfilView;
    IBOutlet UIButton *btnPostViewAll;
    NSMutableArray *arrImageDetails;
    NSMutableArray *arrPostList;
    NSString *strPostPath;
}
@property (nonatomic)int owner_id;
@property (nonatomic) int postCatID;
@property (nonatomic) int universityID;
@property (nonatomic,strong)NSString *strUserName;
@property (nonatomic,strong)NSString *strPostimagePath;

@end
