//
//  IAShareOnlineVC.h
//  Share Info
//
//  Created by Akashdeep on 15/03/14.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>





@interface IAShareOnlineVC : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIDocumentInteractionControllerDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *pickedImage;
    ACAccountStore *accountStore;

}

@property (weak, nonatomic) IBOutlet UIView *ElementsContainer;
@property (weak, nonatomic) IBOutlet UIView *ImageContainer;
@property (weak, nonatomic) IBOutlet UITextField *ImageCaption;
@property (weak, nonatomic) IBOutlet UIButton *ImagePickButton;
@property (weak, nonatomic) IBOutlet UIButton *ShareButton;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;
@property (weak, nonatomic) IBOutlet UIButton *ClearButton;
@property (weak, nonatomic) IBOutlet UILabel *CharLeft;
@property (weak, nonatomic) IBOutlet UIView *SettingsContainer;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

//@property bool TweetFlag, FBFlag, InstaFlag, AskPermission;
//@property bool TweetStatus, FBStatus;

- (IBAction)ImagePickAction:(id)sender;
- (IBAction)ShareAction:(id)sender;
- (IBAction)ClearAction:(id)sender;
- (IBAction)cameraAction:(id)sender;

- (IBAction)SettingsAction:(id)sender;



@end
