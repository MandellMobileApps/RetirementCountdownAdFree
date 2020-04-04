//
//  EmailViewController.m
//  RetirementCountdownAdFree
//
//  Created by Jon Development Account on 4/3/20.
//  Copyright © 2020 MandellMobileApps. All rights reserved.
//

#import "EmailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TimeRemaining.h"
#import "SSZipArchive/SSZipArchive.h"

@interface EmailViewController ()

@end

@implementation EmailViewController

//@property (nonatomic, retain) IBOutlet UILabel *subjectLabel;
//@property (nonatomic, retain) IBOutlet UILabel *toLabel;
//@property (nonatomic, retain) IBOutlet UILabel *fromLabel;
//@property (nonatomic, retain)  IBOutlet UITextView *bodyTextView;
//@property (nonatomic, retain)  IBOutlet UIButton *submitButton;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.submitButton.enabled = YES;


    
    // email button
    self.submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.submitButton addTarget:self action:@selector(submitEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    self.submitButton.frame = CGRectMake(20, 330, self.view.bounds.size.width-40, 40.0);  //self.view.bounds.size.width
    [self.view addSubview:self.submitButton];


}






-(void)submitEmail
{

         MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
         mailcontroller.mailComposeDelegate = self;

//    [mailcontroller setSubject:@""];
//    [mailcontroller setMessageBody:@"" isHTML:NO];
//
//    NSArray *recipient = [NSArray arrayWithObject:@""];
//    [mailcontroller setToRecipients:recipient];
    
    
         NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"lastScreenCapture"];
         NSData *imageinpng = [[NSData alloc] initWithContentsOfFile:pathName];
         if (imageinpng) {
             [mailcontroller addAttachmentData:imageinpng mimeType:@"image/png" fileName:@"Retirement Countdown"];
         }
          [self presentViewController:mailcontroller animated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
  
    [self performSelector:@selector(removeViewAfterEmail) withObject:nil afterDelay:1.0];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)removeViewAfterEmail
{
        [self.navigationController popViewControllerAnimated:YES];

}


-(void) messageSent
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email a Friend" message:@"Message Sent" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alertView.delegate = self;
    alertView.tag =1;
    [alertView layoutIfNeeded];
    [alertView show];
    
}




@end
