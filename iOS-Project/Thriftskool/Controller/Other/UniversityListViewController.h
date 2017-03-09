//
//  UniversityListViewController.h
//  Thriftskool
//
//  Created by Asha on 18/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectUniversityNameDelegate <NSObject>

-(void)selectUniversityName:(NSString*)name domain:(NSString*)domainName id:(NSString*)UniversityId imgName:(NSString*)UniImageName;

@end

@interface UniversityListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblUniversityList;
    NSMutableArray *arrayUniversitylist;
    NSMutableArray *arrayDomainName;
    NSMutableArray *arrayUniversityId;
    NSMutableArray *arrayImageList;
    NSMutableArray *arrayImageData;
    
    NSMutableArray *arrayAllUniversitylist;
    
    NSString *strUniversityName;
    NSString *strDomainName;
    NSString *UniversityId;
    NSString *imagepath;
    NSString *UniversityImgName;
    
    BOOL getImageDataFromURL;
    
    
    id<SelectUniversityNameDelegate> delegate;
}

@property (nonatomic) id delegate;

@end
