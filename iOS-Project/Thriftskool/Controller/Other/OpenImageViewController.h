//
//  OpenImageViewController.h
//  Thriftskool
//
//  Created by Asha on 10/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenImageViewController : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UIScrollView *scrollimageview;
}

//@property (nonatomic,retain) UIImage *image;
//@property (nonatomic, retain) NSString *strUrlImage;
@property (nonatomic, retain) NSMutableArray *arrayImage;
@property (nonatomic) int indexpage;

@end
