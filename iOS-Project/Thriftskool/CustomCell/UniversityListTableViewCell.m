//
//  UniversityListTableViewCell.m
//  Thriftskool
//
//  Created by Asha on 18/08/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "UniversityListTableViewCell.h"

@implementation UniversityListTableViewCell
@synthesize imageUniversity=_imageUniversity, lblUniversityName=_lblUniversityName;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imageUniversity = [[UIImageView alloc]initWithFrame:CGRectMake(16, 17, 45, 45)];
        _imageUniversity.contentMode = UIViewContentModeScaleToFill;
//        _imageUniversity.backgroundColor = [UIColor redColor];
        [self addSubview:_imageUniversity];
        
        _lblUniversityName = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, self.bounds.size.width-_imageUniversity.frame.origin.x-_imageUniversity.frame.size.width-70, 70)];//220
        _lblUniversityName.font = FontRegular16;
//        _lblUniversityName.backgroundColor =[UIColor greenColor];
        [self addSubview:_lblUniversityName];
        

        
        
    }
    return self;
}
@end
