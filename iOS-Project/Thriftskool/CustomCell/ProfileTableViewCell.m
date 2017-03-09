//
//  ProfileTableViewCell.m
//  Thriftskool
//
//  Created by Asha on 28/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell

@synthesize imageProfile=_imageProfile, lblProfileData=_lblProfileData;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageProfile = [[UIImageView alloc]initWithFrame:CGRectMake(16, 20, 30, 30)];
        //        _imageUniversity.backgroundColor =[UIColor redColor];
        [self addSubview:_imageProfile];
        
        _lblProfileData = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, screenWidth-_imageProfile.frame.origin.x-_imageProfile.frame.size.width-50, 60)];//220
        _lblProfileData.font=FontRegular;
        
        [self addSubview:_lblProfileData];
        
        
        _lblUserData = [[UILabel alloc]initWithFrame:CGRectMake(110, 0, screenWidth-(_imageProfile.frame.origin.x+_imageProfile.frame.size.width)-100, 150)];//220
        _lblUserData.font=FontRegular16;
        _lblUserData.textColor = userNameInProfile;
        [self addSubview:_lblUserData];

        _imageUniversity = [[UIImageView alloc]initWithFrame:CGRectMake(16,35, 80, 80)];
        
        [self addSubview:_imageUniversity];

        
    }
    return self;
}

@end
