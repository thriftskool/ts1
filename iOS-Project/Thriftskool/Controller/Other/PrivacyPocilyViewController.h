//
//  PrivacyPocilyViewController.h
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyPocilyViewController : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UIWebView *webview;
}

@property (nonatomic) BOOL FromPrivacyPolicy;

@end
