//
//  MessageDetailCellTableViewCell.m
//  Thriftskool
//
//  Created by Asha on 25/09/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "MessageDetailCellTableViewCell.h"

@implementation MessageDetailCellTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        if (!_imageviewBg) {
            _imageviewBg = [[UIImageView alloc]init];
        }
//        _imageviewBg.layer.cornerRadius = 50.0;
        _imageviewBg.frame = CGRectMake(0, 0, screenWidth/2, 90);
        [self addSubview:_imageviewBg];
        
        
        if (!_lblUserName) {
            _lblUserName = [[UILabel alloc]init];
        }
        _lblUserName.frame = CGRectMake(10, 0,_imageviewBg.frame.size.width-20, 30);
//        [_imageviewBg addSubview:_lblUserName];
        
        
        if (!_lblMsg) {
            _lblMsg = [[UILabel alloc]init];
        }
        _lblMsg.frame = CGRectMake(10, _lblUserName.frame.origin.y+_lblUserName.frame.size.height,_imageviewBg.frame.size.width-80, 30);
       [_imageviewBg addSubview:_lblMsg];
        
        
        if (!_lblDate) {
            _lblDate = [[UILabel alloc]init];
        }
        _lblDate.frame = CGRectMake(_imageviewBg.frame.origin.x, _imageviewBg.frame.size.height,60 , 30);
        _lblDate.textAlignment = NSTextAlignmentRight;
       [self addSubview:_lblDate];


    }
    return self;
}

@end
