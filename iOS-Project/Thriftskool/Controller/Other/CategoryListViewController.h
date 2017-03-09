//
//  CategoryListViewController.h
//  Thriftskool
//
//  Created by Asha on 28/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCategoryNameDelegate<NSObject>

-(void)selectCategoryName:(NSString*)name id:(NSString*)UniversityId;

@end



@interface CategoryListViewController : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblCategorylist;
    NSMutableDictionary *dictUniversityList;
    NSMutableArray *arrayCategoryName;
    NSMutableArray *arrayCategoryImage;
    NSMutableArray *arrayCategoryId;
    
    NSString *strCategoryName;
    NSString *strCategoryId;
    
    int  newIndex;
    
    UILabel *lblcount;


    
    id<SelectCategoryNameDelegate> delegate;
}

@property (nonatomic) int userId;
@property (nonatomic) id delegate;
//@property (nonatomic,retain)    UIButton *btncheckmark;

@end
