//
//  IASettingsVC.h
//  Share Info
//
//  Created by One MobiKwik Systems on 17/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAShareOnlineVC.h"

@interface IASettingsVC : UIViewController
{
    IAShareOnlineVC *SetFlags;
}

@property (weak, nonatomic) IBOutlet UISwitch *TweetSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *FBSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *InstaSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *SelectAllSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SharingOption;




- (IBAction)ClearSettingAction:(id)sender;
- (IBAction)TweetSwitchAction:(id)sender;
- (IBAction)FacebookSwitchAction:(id)sender;
- (IBAction)InstaSwitchAction:(id)sender;
- (IBAction)SelectAllSwitchAction:(id)sender;

- (IBAction)PostingStyleAction:(id)sender;


@end
