//
//  ActionButton.m
//  CustomUIActionSheet
//
//  Created by Barrett Breshears on 8/8/14.
//  Copyright (c) 2014 Barrett Breshears. All rights reserved.
//

#import "ActionButton.h"

@implementation ActionButton

+ (ActionButton *)buttonWithText:(NSString *)text cancel:(BOOL)cancel
{
    // return the initalized button
    return [[self alloc] initWithText:text cancel:(BOOL)cancel];
}

- (id)initWithText:(NSString *)text cancel:(BOOL)cancel
{
    // initialize
    self = [super init];
    if (self != nil) {
        
        

        // we are only using a single image for the demo, but this project is set up for
        // an image with a highligted state
        
        // set up button label
        if (cancel == YES) {
            _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth-60 , 40)];
            _label.backgroundColor = [UIColor clearColor];

            _label.textAlignment = NSTextAlignmentCenter;
            _label.textColor = [UIColor whiteColor];


        }
        else
        {
            _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth-80 , 40)];
            _label.backgroundColor = [UIColor clearColor];

            _label.textAlignment = NSTextAlignmentLeft;
            _label.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];


        }
        _label.text = text;
        _label.font = FontRegular16;
//        [_label setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_label];
        
        

    }
    return self;
}

@end
