//
//  IASettingsVC.m
//  Share Info
//
//  Created by One MobiKwik Systems on 17/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import "IASettingsVC.h"
#import "IAShareOnlineVC.h"
#import "Constants.h"


@interface IASettingsVC ()

@end

@implementation IASettingsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)ClearSettingAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClearSettings"
                                                        object:[IAShareOnlineVC alloc]];
}

- (IBAction)TweetSwitchAction:(id)sender
{
    if ([self.TweetSwitch isOn])
    {
        TweetFlag = TRUE;
    }
    else
    {
        TweetFlag = FALSE;
        [self.SelectAllSwitch setOn:NO animated:YES];

    }

}

- (IBAction)FacebookSwitchAction:(id)sender
{
    if ([self.FBSwitch isOn])
    {
        FBFlag = TRUE;
        
    }
    else
    {
        FBFlag = FALSE;
        [self.SelectAllSwitch setOn:NO animated:YES];
    }
}

- (IBAction)InstaSwitchAction:(id)sender
{
    if ([self.InstaSwitch isOn])
    {
        InstaFlag = TRUE;
    }
    else
    {
        InstaFlag = FALSE;
        [self.SelectAllSwitch setOn:NO animated:YES];

    }
}

- (IBAction)SelectAllSwitchAction:(id)sender
{
    
    if ([self.SelectAllSwitch isOn])
    {
        [self.TweetSwitch setOn:YES animated:YES]; TweetFlag = TRUE;
        [self.FBSwitch setOn:YES animated:YES]; FBFlag = TRUE;
        [self.InstaSwitch setOn:YES animated:YES]; InstaFlag = TRUE;

        
    }
    
}

- (IBAction)PostingStyleAction:(id)sender
{
    if ([self.SharingOption selectedSegmentIndex] == 0)
    {
        AskPermission = FALSE;
    }
    else if ([self.SharingOption selectedSegmentIndex] == 1)
    {
        AskPermission = TRUE;
    }
    
}

@end







