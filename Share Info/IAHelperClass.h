//
//  IAHelperClass.h
//  Share Info
//
//  Created by One MobiKwik Systems on 16/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAHelperClass : NSObject

+ (BOOL)reachable;
+ (void)showMessage : (NSString *)title : (NSString *)description;

@end
