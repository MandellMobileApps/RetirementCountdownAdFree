//
//  HelpViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/24/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "HelpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TimeRemaining.h"
#import "SSZipArchive/SSZipArchive.h"


@implementation HelpViewController


- (void)viewDidLoad {
    [super viewDidLoad];


    self.okToSend = NO;
    self.removeView = NO;
    self.submitButton.enabled = YES;
    
	//set label at top to settings colors
	self.textLabel.textColor = self.textColor;

	// add scrollview content
	
	UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beach.png"]];
	[iconView setFrame:CGRectMake(50, 20, 100, 100)];
	iconView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:iconView];


	// Welcome Title
	UILabel *welcome = [[UILabel alloc] init];
	welcome.font = [UIFont systemFontOfSize:24];
	welcome.frame = CGRectMake(170, 45, 150, 50);
	welcome.textColor = self.textColor;
	welcome.backgroundColor = self.backgroundColor;
	welcome.text = @" Enjoy!";
//	welcome.layer.borderWidth = 2;
//	welcome.layer.borderColor = [[UIColor redColor] CGColor];
	[self.view addSubview:welcome];

	

	UILabel *feedback = [[UILabel alloc] init];
	feedback.font = [UIFont systemFontOfSize:14];
	feedback.textColor = self.textColor;
	feedback.backgroundColor = self.backgroundColor;
	feedback.numberOfLines = 1;
	feedback.textAlignment = NSTextAlignmentCenter;
	feedback.text = @"Add Question or Comment Here: ";
	[feedback setFrame:CGRectMake(20, 120, self.view.bounds.size.width-40, 30)];
	[self.view addSubview:feedback];

	// issue
	self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
	self.textView.frame = CGRectMake(20, 150, self.view.bounds.size.width-40, 110.0);
     [self.view addSubview:self.textView];
    
 
    
    // email button
    self.submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.submitButton addTarget:self action:@selector(submitEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    self.submitButton.frame = CGRectMake(20, 330, self.view.bounds.size.width-40, 40.0);  //self.view.bounds.size.width
    [self.view addSubview:self.submitButton];
    
    UILabel *explain = [[UILabel alloc] init];
    explain.font = [UIFont systemFontOfSize:14];
    explain.textColor = self.textColor;
    explain.backgroundColor = self.backgroundColor;
    explain.numberOfLines = 3;
    explain.textAlignment = NSTextAlignmentCenter;
    explain.text = @"After you tap Submit,\nSend the email shown.";
    [explain setFrame:CGRectMake(20, 360, self.view.bounds.size.width-40, 75)];
    [self.view addSubview:explain];
    
        [self addDeviceInfo];
  
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.textView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0];

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text
{
     if ([text isEqualToString:@"\n"])
     {
         [textView resignFirstResponder];
         return FALSE;
     }
    return TRUE;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
   
    if (self.textView.hasText)
    {
  
        self.okToSend = YES;
    }
    else
    {

        self.okToSend = NO;
    }

    
}

-(void)submitEmail
{
    
    self.submitButton.enabled = NO;
    if (self.okToSend)
    {
        
        [self sendEmailWithDebug];
    }
    else
    {
               //Alert that cannot send mail on this device OS version;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Your Question or Comment" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        self.submitButton.enabled = YES;
        
    }

    
}


-(void) sendEmailWithDebug {

          MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
          mailcontroller.mailComposeDelegate = self;
          
          TimeRemaining *myTimeRemaining = [[TimeRemaining alloc] init];
          [myTimeRemaining updateTimeRemaining];

    NSString *subject;
    if (self.textView.text.length > 50)
    {
           subject =[self.textView.text substringToIndex:50];
    }
    else
    {
           subject =self.textView.text;
    }

          NSString *body = [NSString stringWithFormat:@"%@\n\n",self.textView.text];

          [mailcontroller setSubject:subject];
          [mailcontroller setMessageBody:body isHTML:NO];
          
          NSArray *recipient = [NSArray arrayWithObject:@"support@mandellmobileapps.zohodesk.com"];
          [mailcontroller setToRecipients:recipient];
          
          NSMutableArray* paths = [NSMutableArray array];
 
          NSString* path = [GlobalMethods dataFilePathofDocuments:@"Retirement.sqlite"];

            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:path])
            {
              [paths addObject:path];
            }

            NSString* path2 = [GlobalMethods dataFilePathofDocuments:@"TextLog.txt"];
            if ([fileManager fileExistsAtPath:path2])
            {
                [paths addObject:path2];
            }


          NSString* zipFilename = @"DebugLog.zip";
          NSString* zipPath = [GlobalMethods dataFilePathofDocuments:zipFilename];;
       

          BOOL success =  [SSZipArchive createZipFileAtPath:zipPath withFilesAtPaths:paths withPassword:nil];
              if (success) {
                  [mailcontroller addAttachmentData:[NSData dataWithContentsOfFile:zipPath] mimeType:@"application/zip" fileName:zipFilename];
              } else {
                  [self.appDelegate addToDebugLog:@"Zip File did not save"];
              }

          NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"lastScreenCapture"];
          NSData *imageinpng = [[NSData alloc] initWithContentsOfFile:pathName];
          if (imageinpng) {
              [mailcontroller addAttachmentData:imageinpng mimeType:@"image/png" fileName:@"Retirement Countdown"];
          }

          NSString *pathName2 = [GlobalMethods dataFilePathofDocuments:@"SettingsScreenCapture"];
          NSData *imageinpng2 = [[NSData alloc] initWithContentsOfFile:pathName2];
          if (imageinpng2) {
              [mailcontroller addAttachmentData:imageinpng2 mimeType:@"image/png" fileName:@"SettingsScreenCapture"];
          }
          
          NSString *pathName3 = [GlobalMethods dataFilePathofDocuments:@"WorkdaysScreenCapture"];
          NSData *imageinpng3 = [[NSData alloc] initWithContentsOfFile:pathName3];
          if (imageinpng3) {
              [mailcontroller addAttachmentData:imageinpng3 mimeType:@"image/png" fileName:@"WorkdaysScreenCapture"];
          }
          
          NSString *pathName4 = [GlobalMethods dataFilePathofDocuments:@"WorkhoursScreenCapture"];
          NSData *imageinpng4 = [[NSData alloc] initWithContentsOfFile:pathName4];
          if (imageinpng4) {
              [mailcontroller addAttachmentData:imageinpng4 mimeType:@"image/png" fileName:@"WorkhoursScreenCapture"];
          }

          [self presentViewController:mailcontroller animated:YES completion:nil];
          self.removeView = YES;
          

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
    if (!error)
    {
        switch (result)
        {
            case MFMailComposeResultCancelled:
                self.submitButton.enabled = YES;
                break;
            case MFMailComposeResultSaved:
                self.submitButton.enabled = YES;
                break;
            case MFMailComposeResultSent:
                self.removeView = YES;
                self.textView.text = @"";
                [self performSelector:@selector(removeViewAfterEmail) withObject:nil afterDelay:1.0];
                break;
            case MFMailComposeResultFailed:
                self.submitButton.enabled = YES;
                break;
            default:
                self.submitButton.enabled = YES;
                break;
        }
      
    }
    else
    {
        [self.appDelegate addToDebugLog:[NSString stringWithFormat:@"mailComposeController error %@",[error localizedDescription]]];
        self.submitButton.enabled = YES;
        
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [self messageSent];
//        [self.appDelagate deleteDebugLog];
     }
     
     ];
}

-(void)removeViewAfterEmail
{
    if (self.removeView)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void) emailfailed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Email did not send" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
}

-(void) messageSent
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank You!" message:@"Message Sent" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alertView.delegate = self;
    alertView.tag =1;
    [alertView layoutIfNeeded];
    [alertView show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag ==1)
    {
        [self removeViewAfterEmail];
    }
}



-(void)addDeviceInfo
{


    UIDevice *thisDevice = [UIDevice currentDevice];
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter3 setTimeStyle:NSDateFormatterShortStyle];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *deviceVersion = thisDevice.systemVersion;
    NSString *deviceModel = thisDevice.model;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSMutableString* deviceInfo  = [NSMutableString string];
    [deviceInfo appendFormat:@"AppVersion = %@,  ",version];
    [deviceInfo appendFormat:@"iOSVersion = %@,  ",deviceVersion];
    [deviceInfo appendFormat:@"DeviceModel = %@,  ",deviceModel];
    [deviceInfo appendFormat:@"TimeZone = %@  ",calendar.timeZone.abbreviation];
    
    [self.appDelegate addToDebugLog:deviceInfo];


}


@end
