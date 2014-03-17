//
//  IAShareOnlineVC.m
//  Share Info
//
//  Created by Akashdeep on 15/03/14.
//

#import "IAShareOnlineVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "IAHelperClass.h"
#import "IASocialMediaHandler.h"
#import <Social/Social.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Constants.h"


@interface IAShareOnlineVC ()

@end

@implementation IAShareOnlineVC

float marker;


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
    self.navigationItem.hidesBackButton = YES;
    
    if ([UIScreen mainScreen].bounds.size.height == 568)
    {
        [self.ElementsContainer setFrame:CGRectMake(self.ElementsContainer.frame.origin.x, ((self.view.frame.size.height - self.ElementsContainer.frame.size.height )/2) + 24, self.ElementsContainer.frame.size.width , self.ElementsContainer.frame.size.height)];
        
        CGRect frm = self.SettingsContainer.frame;
        frm.size.height = 1136;
        frm.origin.y = 65;
        self.SettingsContainer.frame = frm;
        
        
    }
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    
    
    //***********************************       CAPTION SETTINGS        ************************************************
    
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleDefault;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleBordered target:self
                                                                  action:@selector(DoneClicked:)];
    
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];

    
    
    [self.ImageCaption setDelegate:self];
    [self.ImageCaption setInputAccessoryView:keyboardDoneButtonView];
    
    
    //------------------------------------------------------------------------------------------------------------------
    
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    
    imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setDelegate:self];
    [imagePicker setAllowsEditing:YES];
    imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];

    if ([UIScreen mainScreen].bounds.size.height == 568)
    {
        marker = (self.ShareButton.frame.origin.y + 122) - (self.view.frame.size.height - 260);
    }
    else
    {
        marker = (self.ShareButton.frame.origin.y + 86) - (self.view.frame.size.height - 260);
    }
    
    TweetFlag = TRUE;FBFlag = TRUE;InstaFlag = TRUE;
    AskPermission = FALSE;
    
    [self.ElementsContainer.layer setCornerRadius:3.0];
    //alert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)ImagePickAction:(id)sender
{
    [self.ImageCaption resignFirstResponder];

    [self presentViewController:imagePicker animated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.imagePreview setImage:pickedImage];
    [self.ImagePickButton setAlpha:0.05];
    [self.cameraButton setAlpha:0.05];
    [self.ClearButton setHidden:NO];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)ShareAction:(id)sender
{

    if (![IAHelperClass reachable])
    {
        [IAHelperClass showMessage:@"Unable to Connect!" :@"Please check your internet connection in the settings section of your device."];
    }
    else
    {
        if (TweetFlag)
        {
            if (!AskPermission)
            {
                [self ChangeAlertview];//:SendingTweet];
            }
            [self TweetOnMyBehalf];
        }
        else if (FBFlag)
        {
            if (!AskPermission)
            {
                [self ChangeAlertview];//:SendingPost];
            }
            [self Post_On_My_Wall];
        }
        else if (InstaFlag){   [self ShareOnInstagram];  }
    }
    

}






-(void)TweetOnMyBehalf
{
    if (AskPermission)
    {
        
        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            
            
            NSString *message = @"Sorry, we cannot tweet at this moment. You need to have a Twitter account associated with this device.";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to Tweet!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            
            
            SLComposeViewController *InfoTweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            [InfoTweet setInitialText:[self.ImageCaption text]];
            [InfoTweet addImage:pickedImage];
            
            
            [self presentViewController:InfoTweet animated:YES completion:^{}];
            
            InfoTweet.completionHandler = ^( SLComposeViewControllerResult result)
            {
                if (result == SLComposeViewControllerResultCancelled)
                {
                    NSLog(@"Tweet was canceled.");
                }
                else if (result == SLComposeViewControllerResultDone)
                {
                    NSLog(@"Tweet completed.");
                }
                
                if (FBFlag)
                {
                    [self Post_On_My_Wall];
                }
                else if (InstaFlag)
                {
                    [self ShareOnInstagram];
                }
                
                
            };
            
        }
        
        
        
    }
    else
    {
        [IASocialMediaHandler TweetThis:[self.ImageCaption text] and_Image:pickedImage];
    }

}




-(void)Post_On_My_Wall
{
    if (AskPermission)
    {
        
        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            
            NSString *message = @"Sorry, we cannot post at this moment. You need to have a Facebook account associated with this device.";
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to Post!" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            
            SLComposeViewController *InfoPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
            [InfoPost setInitialText:[self.ImageCaption text]];
            [InfoPost addImage:pickedImage];
            
            
            [self presentViewController:InfoPost animated:YES completion:^{}];
            
            InfoPost.completionHandler = ^( SLComposeViewControllerResult result)
            {
                if (result == SLComposeViewControllerResultCancelled)
                {
                    NSLog(@"Post was canceled.");
                }
                else if (result == SLComposeViewControllerResultDone)
                {
                    NSLog(@"Post completed.");
                }
                
                if (InstaFlag)
                {
                    [self ShareOnInstagram];
                }
                
                
            };
            
            
            
        }
        
        
        
    }
    else
    {
        
        [IASocialMediaHandler PostThis:[self.ImageCaption text] and_Image:pickedImage];
        
    }

}





-(void)ShareOnInstagram
{
    
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://camera"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    }
    
  
}



- (IBAction)ClearAction:(id)sender
{
    
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.imagePreview setAlpha:0.0];
        [self.ImagePickButton setAlpha:0.2];
        [self.cameraButton setAlpha:0.3];
        [self.ClearButton setHidden:YES];
    } completion:^(BOOL finished)
    {
        [self.imagePreview setImage:nil];
        [self.imagePreview setAlpha:1.0];
    }];

    
    
}

- (IBAction)cameraAction:(id)sender
{
    [self.ImageCaption resignFirstResponder];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        [IAHelperClass showMessage:@"Unable to open Camera!" :@"Camera service is currently unavailable "];
    }
    
    
}

- (IBAction)SettingsAction:(id)sender
{
    
    [self.SettingsContainer setAlpha:0.0];
    [self.SettingsContainer setHidden:NO];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.SettingsContainer setAlpha:1.0];
        
    }];
    
}





- (IBAction)DoneClicked:(id)sender
{
    [self.ImageCaption resignFirstResponder];
}


- (void)changingCaptionfield:(NSNotification*)notification
{
    if ([self.ImageCaption text].length > 140)
    {
        [self.ImageCaption setText:[[self.ImageCaption text] substringToIndex:140]];
    }
    
    [self.CharLeft setText:[NSString stringWithFormat:@"%d",140-[self.ImageCaption text].length]];
    
}




- (void)ClearSettingsScreen:(NSNotification*)notification
{
    if ([[notification name] isEqualToString:@"ClearSettings"])
    {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            [self.SettingsContainer setAlpha:0.0];
            
        } completion:^(BOOL finished) {
            
            [self.SettingsContainer setHidden:YES];

            
        }];
    }
    
}




- (void)TwitterResponseHandler:(NSNotification*)notification
{
    NSLog(@"Twitter Response Recieved");
    
    if ([[notification name] isEqualToString:@"TweetResponse"])
    {
        if (TweetStatus)
        {
            [self StopAlertview];
            [self ChangeAlertview];//:TweetSuccess];
        }
        else
        {
            [self StopAlertview];
            [self ChangeAlertview];//:TweetFailed];
        }
        
        
        double delay1 = 2.0;
        dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, delay1 * NSEC_PER_SEC);
        dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
            
            if (FBFlag)
            {
                [self StopAlertview];
                [self ChangeAlertview];//:SendingPost];
                [self Post_On_My_Wall];
            }
            else if (InstaFlag)
            {
                [self ShareOnInstagram];
            }
            else
            {
                [self StopAlertview];
            }
            
            
        });
        
        
        
        
    }
    
    
    
}



- (void)FBResponseHandler:(NSNotification*)notification
{
    NSLog(@"Facebook Response Recieved");
    
    if ([[notification name] isEqualToString:@"FBResponse"])
    {
        [self StopAlertview];
        
        if (InstaFlag)
        {
            [self ShareOnInstagram];
        }
        else
        {
            [self StopAlertview];
        }
    }
    
}



-(void)ChangeAlertview//:(NSString*)ChangedText
{
    [self.ShareButton setEnabled:NO];
    [self.SharingIndicator setHidden:NO];
    
    //[alert setTitle:ChangedText];
    //[alert show];
}


-(void)StopAlertview
{
    [self.ShareButton setEnabled:YES];
    [self.SharingIndicator setHidden:YES];
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
}



- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyboardShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(KeyboardHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changingCaptionfield:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.ImageCaption];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ClearSettingsScreen:)
                                                 name:@"ClearSettings"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(TwitterResponseHandler:)
                                                 name:@"TweetResponse"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(FBResponseHandler:)
                                                 name:@"FBResponse"
                                               object:nil];
    
}


-(void)viewDidDisappear:(BOOL)animated
{
    if ([UIScreen mainScreen].bounds.size.height == 568)
    {
        marker = (self.ShareButton.frame.origin.y + 52) - (self.view.frame.size.height - 260);
    }
    else
    {
        marker = (self.ShareButton.frame.origin.y - 10) - (self.view.frame.size.height - 260);
    }

    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FBResponse" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TweetResponse" object:nil];

}


- (void)KeyboardShown:(NSNotification*)notification
{
    [UIView animateWithDuration:0.2f animations:^{CGRect frm =
        self.ElementsContainer.frame;  frm.origin.y -= marker; self.ElementsContainer.frame = frm; }];
}

- (void)KeyboardHidden:(NSNotification*)notification
{
    [UIView animateWithDuration:0.2f animations:^{CGRect frm = self.ElementsContainer.frame;  frm.origin.y += marker; self.ElementsContainer.frame = frm; }];
}




@end















