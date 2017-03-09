//
//  CustomActionSheet.m
//  CustomUIActionSheet
//
//  Created by Barrett Breshears on 8/7/14.
//  Copyright (c) 2014 Barrett Breshears. All rights reserved.
//

#import "CustomActionSheet.h"
#import "ActionButton.h"

@interface CustomActionSheet ()

@end

@implementation CustomActionSheet
@synthesize backgroundView;
@synthesize yPosition;
@synthesize index;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super init];
    if (self) {
        
        // set the delegate
        _delegate = delegate;
        
        // create a frame this will take up the full screen size
        self.frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
        
        // set up the background view
        backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:255.0/255.0f green:255.0/255.0f blue:255.0/255.0 alpha:1];
        backgroundView.userInteractionEnabled = YES;
        CGRect frame = backgroundView.frame;
        frame.size = CGSizeMake(screenWidth-40,300);
        frame.origin = CGPointMake(20, self.frame.size.height);
        backgroundView.frame = frame;
        
        
        // get our button array from the otherButtonTittles parameter
        NSMutableArray *buttonArray = [[NSMutableArray alloc]init];
        va_list args;
        va_start(args, otherButtonTitles);
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString*))
        {
            [buttonArray addObject:arg];
        }
        va_end(args);
        
        
        // this will track the current postion of where the elements will be placed
        yPosition = 15;
        
        // check if there is a title
        if (title != nil) {
            // create a the title and position it in the view
            UILabel *titleField = [[UILabel alloc] init];
            titleField.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
            titleField.font = FontBold;
//            titleField.shadowColor = [UIColor blackColor];
            [titleField setTextAlignment:NSTextAlignmentCenter];
            titleField.text = title;
            frame = titleField.frame;
            frame.size.width = screenWidth-40 ;
            frame.size.height = 19;
            frame.origin.x = 0;
            frame.origin.y = yPosition;
            titleField.frame = frame;
            
            [backgroundView addSubview:titleField];
            yPosition += titleField.frame.size.height + 10;
        }
        
        // i will be used to set the button's tag and is returned to delegate menthod
        int i;
        // loop through the buttons and create an ActionButton for each
        for (i = 0; i < buttonArray.count; i++) {
            ActionButton *alertButton = [ActionButton buttonWithText:[buttonArray objectAtIndex:i] cancel:NO];
            frame = alertButton.frame;
            frame.origin.x = 0;//backgroundView.frame.size.width/2 - frame.size.width/2;
            frame.origin.y = yPosition;
            frame.size.width = screenWidth-40;
            frame.size.height = 40;
            alertButton.frame = frame;
            alertButton.tag = i;
            UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertButton.frame.size.width, 1)];
            bottomBorder.backgroundColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
            [alertButton addSubview:bottomBorder];

            [alertButton addTarget:self action:@selector(buttonPressedWithIndex:) forControlEvents:UIControlEventTouchUpInside];
            [backgroundView addSubview:alertButton];
            yPosition += alertButton.frame.size.height;
            
            UIButton * _btncheckmark = [[UIButton alloc]init];
            _btncheckmark  = [UIButton buttonWithType:UIButtonTypeCustom];
            _btncheckmark.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
            _btncheckmark.frame = CGRectMake(screenWidth-70,15, 15.0, 15.0);
            
            _btncheckmark.tag = i+1;


            if (_tapBtn == _btncheckmark.tag) {
            [_btncheckmark setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
            [_btncheckmark setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];
            }
            else
            {
                [_btncheckmark setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
                [_btncheckmark setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];

            }
            [alertButton addSubview:_btncheckmark];

            
        }
        
        // increase the tag index for the cancel button
        i++;
        
        // create the cancel button
        ActionButton * cancel = [ActionButton buttonWithText:cancelButtonTitle cancel:YES];
        frame = cancel.frame;
        frame.origin.x = 0;// backgroundView.frame.size.width/2 - frame.size.width/2;
        frame.origin.y = yPosition;
        frame.size.width = screenWidth-40;
        frame.size.height = 40;

        cancel.frame = frame;
        cancel.tag = -1;
        [cancel addTarget:self action:@selector(buttonPressedWithIndex:) forControlEvents:UIControlEventTouchUpInside];
        cancel.backgroundColor = [UIColor colorWithRed:57.0/255.0 green:182.0/255.0 blue:91.0/225.0 alpha:1.0];
        [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backgroundView addSubview:cancel];
        
        yPosition += cancel.frame.size.height;
        
        frame = backgroundView.frame;
        frame.size.width = screenWidth-40;//self.frame.size.width;
        frame.size.height = yPosition+40;
        backgroundView.frame = frame;
        
        // add the background view and animate the view on screen
        [self addSubview:backgroundView];
        [self animateOn];
        
        
    }
    return self;
}

// method that is fired when one of the ActionButtons is pressed
- (void)buttonPressedWithIndex:(id)sender
{
    // get the button that was pressed
    ActionButton *button = (ActionButton *)sender;
    
    for (UIView *subviews in [button subviews])
    {
        if ([subviews isKindOfClass:[UIButton class]]) {
            UIButton *btncheck = (UIButton*)subviews;
            [btncheck setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
            [btncheck setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];
            
            _tapBtn = (int)btncheck.tag+1;

//            NSUserDefaults *defults =[NSUserDefaults standardUserDefaults];
//            [defults setObject:[NSString stringWithFormat:@"%d",_tapBtn] forKey:@"selectedBtnIndex"];

            
        }
    }

    index = (int)button.tag;
    [self animateOff];
}


// shows the action sheet by adding it to the key window
- (void)showAlert
{
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
}


// animate the view on to the screen
- (void)animateOn
{
    [UIView animateWithDuration:.23 animations:^{
        
        CGRect frame = backgroundView.frame;
        frame.origin.y -= yPosition;
        backgroundView.frame = frame;
        
    }];
}

// remove the view with animation once removed the delegate method is fired off notifying the
// object that implemented the CustomActionSheet
- (void)animateOff
{
    [UIView animateWithDuration:.23 animations:^{
        
        CGRect frame = backgroundView.frame;
        frame.origin.y += yPosition;
        backgroundView.frame = frame;
        
    } completion:^(BOOL complete){
        [_delegate modalAlertPressed:self withButtonIndex:index];
        [self removeFromSuperview];
    }];
}



@end
