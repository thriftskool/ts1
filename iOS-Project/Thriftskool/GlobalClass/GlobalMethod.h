//
//  GlobalMethod.h
//  Cubie
//
//  Created by Harshil on 02/03/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalMethod : NSObject
{
    UIImageView *imageview;
    UILabel *lblnetwork;
    UIButton * tryAgain;
}

@property (nonatomic, retain) NSString *strUserName;
@property (nonatomic) int userID;
@property (nonatomic) int notificationCount;


+(GlobalMethod*) shareGlobalMethod;
-(BOOL) connectedToNetwork;
-(NSString*)getUserID;
- (NSString*)DateDisplayInCell1:(NSString*)strDate;
- (NSString*)DateDisplayWithMonthName:(NSString*)strDate firstMonth:(BOOL)monthNameFirst;
-(NSString*)ExpiredDateDisplayWithMonthName:(NSString*)strDate;
-(void) afterUserSet;

@end
