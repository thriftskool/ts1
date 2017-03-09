//
//  ViewController.m
//  Thriftskool
//
//  Created by Asha on 17/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "StartScreenViewController.h"
#import "LogInViewController.h"

@interface StartScreenViewController()

@end

@implementation StartScreenViewController
@synthesize signUpObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
    {
        btnLogIn.hidden = NO;
        btnSignUp.hidden = NO;
        logoImage.hidden = NO;

        tryAgain.hidden = YES;
        lblnetwork.hidden = YES;
        
        self.navigationController.navigationBar.hidden = YES;
        // Do any additional setup after loading the view, typically from a nib.
        btnLogIn.layer.borderWidth = 1.0;
        btnLogIn.layer.borderColor = [UIColor whiteColor].CGColor;
        btnLogIn.layer.cornerRadius = 6.0;
        btnLogIn.titleLabel.font = FontBold;
        
        btnSignUp.layer.borderWidth = 1.0;
        btnSignUp.layer.borderColor = [UIColor whiteColor].CGColor;
        btnSignUp.layer.cornerRadius = 6.0;
        btnSignUp.titleLabel.font = FontBold;
    }
    else
    {
        btnLogIn.hidden = YES;
        btnSignUp.hidden = YES;
        logoImage.hidden = YES;
        tryAgain.hidden = NO;
        lblnetwork.hidden = NO;
        
        lblnetwork = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, screenWidth-20, 60)];
        lblnetwork.text = @"Your device is not connected with Internet. Please check your device Internet settings.";
        lblnetwork.numberOfLines = lblnetwork.frame.size.height/lblnetwork.font.lineHeight;
        lblnetwork.font = FontRegular14;
        lblnetwork.textColor = [UIColor whiteColor];
        lblnetwork.textAlignment = NSTextAlignmentCenter;
        [startscreenView addSubview:lblnetwork];
        lblnetwork.hidden = NO;
        
        tryAgain = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2-50, 100, 100, 30)];
        [tryAgain setTitle:@"Try Again" forState:UIControlStateNormal];
        tryAgain.layer.cornerRadius = 6.0;
        tryAgain.layer.borderWidth = 1.0;
        tryAgain.layer.borderColor = [UIColor whiteColor].CGColor;
        [tryAgain addTarget:self action:@selector(btnTryAgianClicked) forControlEvents:UIControlEventTouchUpInside];
        tryAgain.titleLabel.font = FontRegular16;
        [startscreenView addSubview:tryAgain];

    }
    
   // UIImageView *bgimage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
   // bgimage.image = [UIImage imageNamed:@"bg.png"];
   // [self.view addSubview:bgimage];
//    startscreenView.backgroundColor = BackgroundImage;
//    startscreenView.contentMode = UIViewContentModeScaleToFill;￼
    
}

-(void)btnTryAgianClicked
{
//    if ([GlobalMethod shareGlobalMethod].connectedToNetwork)
//    {
        btnLogIn.hidden = NO;
        btnSignUp.hidden = NO;
        tryAgain.hidden = YES;
        logoImage.hidden = NO;
        
        self.navigationController.navigationBar.hidden = YES;
        // Do any additional setup after loading the view, typically from a nib.
        btnLogIn.layer.borderWidth = 1.0;
        btnLogIn.layer.borderColor = [UIColor whiteColor].CGColor;
        btnLogIn.layer.cornerRadius = 6.0;
        btnLogIn.titleLabel.font = FontBold;
        
        btnSignUp.layer.borderWidth = 1.0;
        btnSignUp.layer.borderColor = [UIColor whiteColor].CGColor;
        btnSignUp.layer.cornerRadius = 6.0;
        btnSignUp.titleLabel.font = FontBold;
        lblnetwork.hidden = YES;
        
//    }
//    else{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Your device is not connected with Internet. Please check your device Internet settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
        self.navigationController.navigationBar.hidden = YES;
        self.tabBarController.tabBar.hidden = YES;
    
    appDelegate.startscreenviewObj = self;
    if (self.navigationController == nil)
    {
        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"navigationController2"];
        appDelegate.window.rootViewController = nav;
    }
    
    if (signUpObj.strverify)
    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:_strVerfication delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        
        [self.view makeToast:signUpObj.strverify];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnLogInClicked:(id)sender
{
    LogInViewController *loginObj= [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    [self.navigationController pushViewController:loginObj animated:YES];
}

-(IBAction)btnSignUpClicked:(id)sender
{
//    SignUpViewController *
    signUpObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    signUpObj.strverify = nil;
    [self.navigationController pushViewController:signUpObj animated:YES];
}
@end
