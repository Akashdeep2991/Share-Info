//
//  IASocialMediaHandler.h
//  Share Info
//
//  Created by One MobiKwik Systems on 16/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IASocialMediaHandler : NSObject

+ (void)TweetThis:(NSString *)Caption and_Image:(UIImage *)pic;
+ (void)PostThis:(NSString *)Status and_Image:(UIImage *)pic;
@end
