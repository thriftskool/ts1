//
//  APPViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPViewController.h"
#import "APPChildViewController.h"
#import "StartScreenViewController.h"
@interface APPViewController ()
{
    UIPageControl *pageControl;
    
    int currentIndextemp,lastIndextemp;
}
@end

@implementation APPViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=true;
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    lastIndextemp=0;
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    self.pageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);

    APPChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-60,self.view.frame.size.width,44)];
    pageControl.pageIndicatorTintColor = NavigationBarBgColor;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    self.btnNext.tag=0;
    pageControl.backgroundColor = [UIColor clearColor];
  
    [self.view addSubview:pageControl];
    [self.view bringSubviewToFront:self.btnNext];
    [self.view bringSubviewToFront:self.btnSkip];

}

#pragma mark Button Action method
-(IBAction)btnSkipPressed:(id)sender
{
    [self movetologinscreen];
    StartScreenViewController *objStartView = [self.storyboard instantiateViewControllerWithIdentifier:@"StartScreenViewController"];
    [self.navigationController pushViewController:objStartView animated:YES];
}
-(IBAction)btnNextPressed:(id)sender
{
    [self scrollToNext];
}
- (void)scrollToNext
{
    UIViewController *current = self.pageController.viewControllers[0];
    NSInteger currentIndex = [(APPChildViewController*)current index];
    currentIndextemp=(int)currentIndex;
    if (currentIndextemp >= 2)
    {
        [self movetologinscreen];
        StartScreenViewController *objStartView = [self.storyboard instantiateViewControllerWithIdentifier:@"StartScreenViewController"];
        [self.navigationController pushViewController:objStartView animated:YES];
        return;
    }
    lastIndextemp=currentIndextemp+1;
    UIViewController *nextController = [self viewControllerAtIndex:++currentIndex];//[self viewControllerForIndex:++currentIndex];
    if (nextController) {
        NSArray *viewControllers = @[nextController];
         [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        // This changes the View Controller and calls the presentationIndexForPageViewController datasource method
        
        [pageControl setCurrentPage:currentIndex];
    }
}
- (APPChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    currentIndextemp=(int)index;
    lastIndextemp=currentIndextemp;

    APPChildViewController *childViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"APPChildViewController"];
   
    childViewController.index = index;
    
    return childViewController;
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *current = self.pageController.viewControllers[0];
    NSInteger currentIndex = [(APPChildViewController*)current index];
    [pageControl setCurrentPage:currentIndex];
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
  
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(APPChildViewController *)viewController index];
   [pageControl setCurrentPage:index];

    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = [(APPChildViewController *)viewController index];
    [pageControl setCurrentPage:index];

    index++;

  
    if (index >= 3) {
        
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return currentIndextemp;
}
-(void)movetologinscreen
{
    [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"isuserGuide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
