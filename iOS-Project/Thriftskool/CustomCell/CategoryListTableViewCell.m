//
//  CategoryListTableViewCell.m
//  Thriftskool
//
//  Created by Asha on 28/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "CategoryListTableViewCell.h"

@implementation CategoryListTableViewCell
@synthesize imageCategory=_imageCategory, lblCategoryName=_lblCategoryName,btncheckmark = _btncheckmark;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageCategory = [[UIImageView alloc]initWithFrame:CGRectMake(16, 20, 40, 40)];
        
        [self addSubview:_imageCategory];
        
        _lblCategoryName = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, self.bounds.size.width-_imageCategory.frame.origin.x-_imageCategory.frame.size.width-50, 70)];//220
        [self addSubview:_lblCategoryName];
        
        _btncheckmark = [[UIButton alloc]initWithFrame:CGRectMake(270, 15, 40, 30)];
        _btncheckmark  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btncheckmark.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:15.0];
        _btncheckmark.frame = CGRectMake(screenWidth-50,30 , 20.0, 20.0);
        [_btncheckmark setTitleColor:NavigationTitleColor forState:UIControlStateNormal];
        [_btncheckmark setTitle:[NSString fontAwesomeIconStringForEnum:FACheck] forState:UIControlStateNormal];

        [self addSubview:_btncheckmark];

}
    return self;
}
@end
