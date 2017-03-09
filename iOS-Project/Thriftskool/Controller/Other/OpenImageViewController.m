//
//  OpenImageViewController.m
//  Thriftskool
//
//  Created by Asha on 10/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "OpenImageViewController.h"

@interface OpenImageViewController ()

@end

@implementation OpenImageViewController
@synthesize arrayImage,indexpage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
//    [self setExtendedLayoutIncludesOpaqueBars:YES];
//    self.tabBarController.tabBar.hidden = YES;

    appDelegate.tabviewControllerObj.tabBars.tabBar.hidden = YES;
    
    // Add Back Button
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:40.0];
    button.frame = CGRectMake(13, 26, 30.0, 30.0);
    [button setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
    [button setTitle:[NSString fontAwesomeIconStringForEnum:FAAngleLeft] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundColor:[UIColor redColor]];

    
    int x = 0;
    for (int i = 0; i<arrayImage.count ; i++)
    {
        
        UIScrollView *viewscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(x, 20, screenWidth, screenHeight)];
        viewscroll.scrollEnabled = NO;
        
        
        UIImageView *imageview = [[UIImageView alloc]init];//WithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
        imageview.tag = i;
        
            NSURL *url = [NSURL URLWithString:[arrayImage objectAtIndex:i]];
            NSString *cacheFilename = [url lastPathComponent];
//            NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename];
        int index = (int)[url pathComponents].count-3;
        NSString *folderName =[[url pathComponents] objectAtIndex:index];
        
        NSLog(@"folderName %@",folderName);
        NSString *cachePath = [LazyLoadingImage cachePath:cacheFilename Name:folderName];

            id image = [LazyLoadingImage imageDataFromPath:cachePath];
            
            imageview.image = [UIImage imageNamed:@"lodingicon.png"];
           imageview.contentMode = UIViewContentModeScaleAspectFit;
        
        
            imageview.frame = CGRectMake((screenWidth/2)-(imageview.image.size.width/2),
                                         (screenHeight/2)-(imageview.image.size.height/2),
                                         imageview.image.size.width,
                                         imageview.image.size.height);
        

            if(image)
            {
                imageview.image = (UIImage*)image;
                imageview.contentMode = UIViewContentModeScaleAspectFit;


                if (imageview.image.size.width>screenWidth && imageview.image.size.height>screenHeight) {
                    imageview.frame = CGRectMake(0,0, screenWidth, screenHeight-50);

                }
                else
                {
                    imageview.frame = CGRectMake((screenWidth/2)-(imageview.image.size.width/2),(screenHeight/2)-(imageview.image.size.height/2), imageview.image.size.width, imageview.image.size.height-50);

                }

            }
            else
            {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                 {
                     if (connectionError == nil)
                     {
                         imageview.image = [UIImage imageWithData:data];
                         imageview.contentMode = UIViewContentModeScaleAspectFit;

                         [LazyLoadingImage imageCacheToPath:cachePath imgData:data];
                         if (imageview.image.size.width>screenWidth && imageview.image.size.height>screenHeight) {
                             imageview.frame = CGRectMake(0,0, screenWidth, screenHeight-50);
                             
                         }
                         else
                         {

                         imageview.frame = CGRectMake((screenWidth/2)-(imageview.image.size.width/2),(screenHeight/2)-(imageview.image.size.height/2), imageview.image.size.width, imageview.image.size.height-50);
                         }

                         
                     }
                 }];
            }
            

        [viewscroll addSubview:imageview];
        
        [scrollimageview addSubview:viewscroll];
        viewscroll.contentSize = CGSizeMake(self.view.frame.size.width-50,viewscroll.frame.origin.y + viewscroll.frame.size.height);
        x = viewscroll.frame.origin.x+viewscroll.frame.size.width;
    }
    
    
    scrollimageview.contentSize = CGSizeMake(self.view.frame.size.width * arrayImage.count,
                                              480);
    scrollimageview.pagingEnabled = true;
    
    CGPoint scrollPoint = CGPointMake(self.view.frame.size.width * indexpage, 0);
    //change the scroll view offset the the 3rd page so it will start from there
    [scrollimageview setContentOffset:scrollPoint animated:YES];
    
    [self.view addSubview:button];

//    imageview.contentMode = UIViewContentModeCenter;
    // Do any additional setup after loading the view.
    

}


-(void)btnBackClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
