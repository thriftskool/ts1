//
//  LazyLoadingImage.h
//  webServiceTesting
//
//  Created by Asha on 11/03/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LazyLoadingImage : NSObject

+ (NSString*)cachePath:(NSString*)fileName;
+(BOOL)imageCacheToPath:(NSString*)path imgData:(NSData*)image;
+(id)imageDataFromPath:(NSString*)path;
+(NSString*)cachePath:(NSString *)fileName Name:(NSString*)folderName;

@end
