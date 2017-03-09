//
//  SelectCategoryPostLIstTableViewCell.m
//  Thriftskool
//
//  Created by Asha on 04/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "SelectCategoryPostLIstTableViewCell.h"

@implementation SelectCategoryPostLIstTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgviewpost = [[UIImageView alloc]initWithFrame:CGRectMake(8,15, 60, 60)];
        [self addSubview:_imgviewpost];
        
         _lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 13, screenWidth-(80+55), 36)];//self.frame.size.width-(80+55)
//        _lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 13, 400, 50)];
        _lblTitle.font = FontRegular;
        _lblTitle.numberOfLines=2;
        _lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_lblTitle];
        
        _lblExpDate = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 240, 34)];
//        _lblExpDate.backgroundColor = [UIColor redColor];
        _lblExpDate.font = FontRegular15;
        [self addSubview:_lblExpDate];
        
        _btnfav = [[UIButton alloc]initWithFrame:CGRectMake(250,0, 50, 50)];
        _btnfav  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnfav.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:20.0];
        _btnfav.frame = CGRectMake(screenWidth-50,15, 20.0, 20.0);
        [_btnfav setTitleColor:NavigationBarBgColor forState:UIControlStateNormal];
        
        [self addSubview:_btnfav];
        
        _lblPrice = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth-105, 50, 75, 34)];
        _lblPrice.font = FontRegular16;
        _lblPrice.textAlignment = NSTextAlignmentRight;
        [self addSubview:_lblPrice];
        
        
    }
    return self;
}
-(void) layoutSubviews
{
    NSMutableArray *subviews = [self.subviews mutableCopy];
    
    if (self.showingDeleteConfirmation)
    {
        UIView *subV = subviews[0];
        [subviews removeObjectAtIndex:0];
        CGRect f = subV.frame;
//        f.origin.x = 5;
        f.size.height = 85.0; // Here you set height of Delete button
        subV.frame = f;
        
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 5)];/// change size as you need.
        separatorLineView.backgroundColor = tableBackgroundColor;// you can also put image here
        [subV addSubview:separatorLineView];
        
        UIView* bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, cellHeight-5, screenWidth, 5)];/// change size as you need.
        bottomline.backgroundColor = tableBackgroundColor;// you can also put image here
        [subV addSubview:bottomline];

    }

}

@end
