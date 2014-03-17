//
//  IASplashScreenVC.m
//  Share Info
//
//  Created by One MobiKwik Systems on 17/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import "IASplashScreenVC.h"
#import <FacebookSDK/FacebookSDK.h>
#import "IAHelperClass.h"


@interface IASplashScreenVC ()

@end

@implementation IASplashScreenVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)viewWillLayoutSubviews
{
    [self.FacebookLogin setFrame:CGRectMake(self.FacebookLogin.frame.origin.x,self.view.frame.size.height - self.FacebookLogin.frame.size.height ,self.FacebookLogin.frame.size.width , self.FacebookLogin.frame.size.height)];
}



-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = FALSE;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = TRUE;
    

    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectMake((self.FacebookLogin.frame.size.width - loginView.frame.size.width)/2, self.FacebookLogin.frame.size.height - loginView.frame.size.height - 30, loginView.frame.size.width, loginView.frame.size.height);
    loginView.readPermissions = @[@"basic_info", @"email"];
    
    [self.FacebookLogin addSubview:loginView];
    
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
    {
        [self.FacebookLogin setAlpha:0.0];
        [self.Explore setAlpha:0.0];
        [self.Explore setHidden:NO];
        [self.FacebookLogin setHidden:NO];
        
        [UIView animateWithDuration:1.0 animations:^{
            
            [self.FacebookLogin setAlpha:1.0];
            [self.Explore setAlpha:1.0];
            [self.AppLoader setAlpha:0.0];
            
        } completion:nil];
    }
    else
    {
        double delay1 = 2.0;
        dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, delay1 * NSEC_PER_SEC);
        dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
            
            
            [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"IAHOME"] animated:YES];
            
            
        });
    }
    
    
    

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)ExploreAction:(id)sender
{
    if (FBSession.activeSession.state != FBSessionStateCreatedTokenLoaded)
    {
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"IAHOME"] animated:YES];
    }
    else
    {
        [IAHelperClass showMessage:@"Please login first !" :@"We need you to login Via your facebook account in order to share posts."];
    }
}

@end
