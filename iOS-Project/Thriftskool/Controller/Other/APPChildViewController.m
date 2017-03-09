//
//  APPChildViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPChildViewController.h"

@interface APPChildViewController ()
{
    UIPageControl *pageControl;
}
@end

@implementation APPChildViewController

@synthesize bgimageView;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
      bgimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    bgimageView.image = [UIImage imageNamed:@"bg.png"];
    [self.view addSubview:bgimageView];
    
  /*  pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-44,self.view.frame.size.width,44)];
    pageControl.pageIndicatorTintColor = NavigationBarBgColor;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    [pageControl addTarget:self action:@selector(turnPage:) forControlEvents:UIControlEventValueChanged];*/

    [self.view addSubview:pageControl];
    
    if((int)_index==0)
    {
        if(ipadDevice)
        {
            [bgimageView setImage:[UIImage imageNamed:@"UserGuide/Ipad/1-userguide-ipad"]];

        }
        else
        {
            [bgimageView setImage:[UIImage imageNamed:@"UserGuide/First_Screen_New"]];
        }
    }
    if((int)_index==1)
    {
        if(ipadDevice)
        {
            [bgimageView setImage:[UIImage imageNamed:@"UserGuide/Ipad/2-userguide-ipad"]];
        }
        else
        {
           [bgimageView setImage:[UIImage imageNamed:@"UserGuide/Second_Screen_New"]];
        }
    }
//    if((int)_index==2)
//    {
//        if(ipadDevice)
//        {
//            [bgimageView setImage:[UIImage imageNamed:@"UserGuide/Ipad/3-userguide-ipad"]];
//        }
//        else
//        {
//            [bgimageView setImage:[UIImage imageNamed:@"UserGuide/Third_Screen_New"]];
//        }
//    }
    if((int)_index==2)
    {
        if(ipadDevice)
        {
            [bgimageView setImage:[UIImage imageNamed:@"UserGuide/Ipad/4-userguide-ipad"]];
        }
        else
        {
            [bgimageView setImage:[UIImage imageNamed:@"UserGuide/Fourth_Screen_New"]];
        }
    }

    
    
}
-(void)turnPage:(UIPageControl *) page
{
    
    switch (page.currentPage) {
        case 0:
            pageControl.backgroundColor=[UIColor redColor];
            break;
            
        case 1:
            pageControl.backgroundColor=[UIColor grayColor];
            break;
            
        case 2:
            pageControl.backgroundColor=[UIColor orangeColor];
            break;
            
        case 3:
            pageControl.backgroundColor=[UIColor greenColor];
            break;
            
                   
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
