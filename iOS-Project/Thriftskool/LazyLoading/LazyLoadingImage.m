//
//  LazyLoadingImage.m
//  webServiceTesting
//
//  Created by Asha on 11/03/15.
//  Copyright (c) 2015 Etilox. All rights reserved.
//

#import "LazyLoadingImage.h"
@implementation LazyLoadingImage

    +(NSString*)cachePath:(NSString *)fileName
    {
        NSArray *arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, 1, true);
        NSString *path = arr[0];
        NSString *pathWithFile = [NSString stringWithFormat:@"%@/%@",path,fileName];
        return pathWithFile;
    }
    +(NSString*)cachePath:(NSString *)fileName Name:(NSString*)folderName
    {
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, 1, true);
    NSString *path = arr[0];
    NSString *pathWithFile = [NSString stringWithFormat:@"%@/%@/%@",path,folderName,fileName];
    return pathWithFile;
    }

    +(BOOL)imageCacheToPath:(NSString *)path imgData:(NSData *)image
    {
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:[path stringByDeletingLastPathComponent]
                                      withIntermediateDirectories:YES attributes:nil error:nil];//Create folder
            }

        return [image writeToFile:path atomically:true];
    }
    +(id)imageDataFromPath:(NSString *)path
    {
        BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (exist)
        {
            return [UIImage imageWithContentsOfFile:path];
        }
        return (nil);
    }
@end
