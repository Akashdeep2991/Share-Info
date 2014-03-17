//
//  IASplashScreenVC.h
//  Share Info
//
//  Created by One MobiKwik Systems on 17/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IASplashScreenVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *FacebookLogin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *AppLoader;
@property (weak, nonatomic) IBOutlet UIButton *Explore;
- (IBAction)ExploreAction:(id)sender;

@end
