//
//  IAHelperClass.m
//  Share Info
//
//  Created by One MobiKwik Systems on 16/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import "IAHelperClass.h"
#import "Reachability.h"

@implementation IAHelperClass


+(BOOL)reachable
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus netStatus = [reachability currentReachabilityStatus];;
    if(netStatus == NotReachable) {
        return NO;
    }
    return YES;
}



+ (void)showMessage : (NSString *)title : (NSString *)description{
    
    
    UIAlertView *alertEmpty = [[UIAlertView alloc] initWithTitle:title message:description delegate:self cancelButtonTitle: @"OK" otherButtonTitles:nil, nil];
    
    [alertEmpty show];
    
    
}



@end
