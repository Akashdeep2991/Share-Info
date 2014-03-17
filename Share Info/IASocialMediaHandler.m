//
//  IASocialMediaHandler.m
//  Share Info
//
//  Created by One MobiKwik Systems on 16/03/14.
//  Copyright (c) 2014 InfoAssembly. All rights reserved.
//

#import "IASocialMediaHandler.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import "IAHelperClass.h"
#import <Accounts/Accounts.h>
#import "IAShareOnlineVC.h"
#import "Constants.h"


@implementation IASocialMediaHandler
BOOL Result;
ACAccount *FBaccount;


+ (void)TweetThis:(NSString *)Caption and_Image:(UIImage *)pic
{
 
    
        ACAccountStore *account = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        NSArray *arrayOfAccons = [account accountsWithAccountType:accountType];
        for(ACAccount *acc in arrayOfAccons)
        {
            NSLog(@"%@",acc.username);
        }
        
    
    
        [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
         {
             if (granted == YES)
             {
                 NSArray *arrayOfAccounts = [account
                                             accountsWithAccountType:accountType];
                 
                 if ([arrayOfAccounts count] > 0)
                 {
                     ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                     
                     NSDictionary *message = [[NSDictionary alloc] initWithObjectsAndKeys:Caption, @"status", nil];
                     
                     NSURL *requestURL = [NSURL
                                          URLWithString:@"https://api.twitter.com/1.1/statuses/update_with_media.json"];
                     
                     SLRequest *postRequest = [SLRequest
                                               requestForServiceType:SLServiceTypeTwitter
                                               requestMethod:SLRequestMethodPOST
                                               URL:requestURL parameters:message];
                     
                     [postRequest addMultipartData:UIImageJPEGRepresentation(pic, 0.7) withName:@"media" type:@"image/jpg" filename:@"image001.jpg"];

                     
                     postRequest.account = twitterAccount;
                     
                     [postRequest performRequestWithHandler:^(NSData *responseData,
                                                              NSHTTPURLResponse *urlResponse, NSError *error)
                      {
                          
                          if(error)
                          {
                              TweetStatus = FALSE;
                              NSLog(@"1");
                              [[NSNotificationCenter defaultCenter] postNotificationName:@"TweetResponse"
                                                                                  object:[IAShareOnlineVC alloc]];
                              [IAHelperClass showMessage:@"Unable to Tweet!" :@"Error occurred while tweeting. Please try again later."];

                              
                          }
                          else
                          {
                              NSLog(@"%@",urlResponse);
                              
                              if ([urlResponse statusCode] != 200)
                              {
                                  TweetStatus = FALSE;
                                  NSLog(@"2");
                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"TweetResponse"
                                                                                      object:[IAShareOnlineVC alloc]];
                                  [IAHelperClass showMessage:@"Unable to Tweet!" :@"Error occurred while tweeting. Please try again later."];

                              }
                              else
                              {
                                  TweetStatus  = TRUE;
                                  NSLog(@"3");
                                  [[NSNotificationCenter defaultCenter] postNotificationName:@"TweetResponse"
                                                                                      object:[IAShareOnlineVC alloc]];
                              }
                              
                          }
                          
                          
                          
                      }];
                     
                 }
                 else
                 {
                     TweetStatus = FALSE;
                     NSLog(@"4");
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"TweetResponse"
                                                                         object:[IAShareOnlineVC alloc]];
                     [IAHelperClass showMessage:@"Unable to Tweet!" :@"There is no Twitter account associated with this device."];

                     
                 }
             }
         }];

    
    

    
    
}









+ (void)PostThis:(NSString *)Status and_Image:(UIImage *)pic
{
    
    
    
    NSData* imageData = UIImageJPEGRepresentation(pic, 90);
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    Status, @"message",
                                    imageData, @"source",
                                    nil];
    
    [FBRequestConnection startWithGraphPath:@"me/photos"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              [[NSNotificationCenter defaultCenter] postNotificationName:@"FBResponse" object:[IAShareOnlineVC alloc]];

                          }];

    
    
    /*
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    
    ACAccountType *accountTypeFacebook =
    [accountStore accountTypeWithAccountTypeIdentifier:
     ACAccountTypeIdentifierFacebook];
    
    NSDictionary *options = @{
                              ACFacebookAppIdKey: @"1415329298720388",
                              ACFacebookPermissionsKey: @[@"publish_stream",
                                                          @"publish_actions"],
                              ACFacebookAudienceKey: ACFacebookAudienceFriends
                              };
    
    [accountStore requestAccessToAccountsWithType:accountTypeFacebook
                                          options:options
                                       completion:^(BOOL granted, NSError *error) {
                                           
                                           if(granted) {
                                               
                                               NSArray *accounts = [accountStore
                                                                    accountsWithAccountType:accountTypeFacebook];
                                               FBaccount = [accounts lastObject];
                                               
                                               NSDictionary *parameters =
                                               @{@"access_token":FBaccount.credential.oauthToken,
                                                 @"message": Status};
                                               
                                               NSURL *feedURL = [NSURL
                                                                 URLWithString:@"https://graph.facebook.com/me/feed"];
                                               
                                               SLRequest *feedRequest =
                                               [SLRequest
                                                requestForServiceType:SLServiceTypeFacebook
                                                requestMethod:SLRequestMethodPOST
                                                URL:feedURL
                                                parameters:parameters];
                                               
 
                                               NSData *imageData = UIImageJPEGRepresentation(pic, 1.f);
                                               [feedRequest addMultipartData: imageData
                                                                        withName:@"source"
                                                                            type:@"multipart/form-data"
                                                                        filename:@"TestImage"];
                                               
                                               

                                               
                                               
                                               [feedRequest 
                                                performRequestWithHandler:^(NSData *responseData,
                                                                            NSHTTPURLResponse *urlResponse, NSError *error)
                                                {
                                                    NSLog(@"Request failed, %@", 
                                                          [urlResponse description]);
                                                }];
                                           } else {
                                               NSLog(@"Access Denied");
                                               NSLog(@"[%@]",[error localizedDescription]);
                                           }
                                       }];
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FBResponse" object:[IAShareOnlineVC alloc]];
     */
}







@end









