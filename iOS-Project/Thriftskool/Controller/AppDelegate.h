//
//  AppDelegate.h
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabViewController.h"
#import "StartScreenViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    AppDelegate *appdel;
    BOOL appEnterInBackGround;
}

@property (nonatomic, retain) AppDelegate *appdel;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) TabViewController *tabviewControllerObj;
@property (nonatomic, retain) StartScreenViewController *startscreenviewObj;


@end

