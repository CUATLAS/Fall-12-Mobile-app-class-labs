//
//  EmailViewController.m
//  Sayansi
//
//  Created by Josephine Kilde on 12/16/12.
//  Copyright (c) 2012 Josephine Kilde. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController


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
	
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)learnMoreButtonPressed:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mashable.com/2012/09/20/evolution-email/"]];
}


//Reference: http://mobile.tutsplus.com/tutorials/iphone/mfmailcomposeviewcontroller/

- (IBAction)openMail:(id)sender {

    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@""];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"", @"", nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
        [mailer removeFromParentViewController];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert removeFromSuperview];
    }
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
            switch (result)
    {
        
            case MFMailComposeResultCancelled: {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure:"
                                                                message:@"Message cancelled without saving"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
                
            }
            
            break;
        case MFMailComposeResultSaved: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Saved"
                                                            message:@"You message is saved in the drafts folder."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
            
            break;
        case MFMailComposeResultSent: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail sent:"
                                                            message:@"You message is queued in outbox ready to send."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
            break;
        case MFMailComposeResultFailed: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Failed:"
                                                            message:@"You message is not saved due to an error."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
            
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }

    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}
    
@end
