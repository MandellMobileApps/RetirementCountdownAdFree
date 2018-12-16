//
//  HelpViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/24/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "HelpViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation HelpViewController

@synthesize textLabel;

- (void)viewDidLoad {
    [super viewDidLoad];

	//set label at top to settings colors
	self.textLabel.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:7])];
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];

	// add scrollview content
	
	UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beach.png"]];
	[iconView setFrame:CGRectMake(50, 20, 100, 100)];
	iconView.contentMode = UIViewContentModeScaleAspectFit;
	[self.view addSubview:iconView];
	[iconView release];

	// Welcome Title
	UILabel *welcome = [[UILabel alloc] init];
	welcome.font = [UIFont systemFontOfSize:24];
	welcome.frame = CGRectMake(170, 45, 150, 50);
	welcome.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:7])];
	welcome.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	welcome.text = @" Enjoy!";
//	welcome.layer.borderWidth = 2;
//	welcome.layer.borderColor = [[UIColor redColor] CGColor];
	[self.view addSubview:welcome];
	[welcome release];
	

	UILabel *feedback = [[UILabel alloc] init];
	feedback.font = [UIFont systemFontOfSize:14];
	feedback.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:7])];
	feedback.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	feedback.numberOfLines = 0;
	feedback.textAlignment = UITextAlignmentCenter;
	feedback.text = @"Please Let me know \n what you think about this App!\n\n"
	@"You can post on the AppStore, \email me at Support@MandellMobileApps.com,\n or tap on the button below.\n\n"
	"\n";
	[feedback setFrame:CGRectMake(10, 140, 290, 150)];
//	feedback.layer.borderWidth = 2;
//	feedback.layer.borderColor = [[UIColor redColor] CGColor];
	[self.view addSubview:feedback];
	[feedback release];	


	// email button
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"Send Email" forState:UIControlStateNormal];
	button.frame = CGRectMake(100, 300, 120.0, 40.0);
	[self.view addSubview:button];

}


-(void) sendEmail {
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	NSDateFormatter *dateFormatter2 = [[[NSDateFormatter alloc] init] autorelease];
	NSDateFormatter *dateFormatter3 = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	[dateFormatter2 setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter2 setTimeStyle:NSDateFormatterShortStyle];	
	
	[dateFormatter3 setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter3 setTimeStyle:NSDateFormatterShortStyle];
	
	if ((mailClass != nil) && ([mailClass canSendMail])){
		MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc] init];
		mailcontroller.mailComposeDelegate = self;
		UIDevice *thisDevice = [UIDevice currentDevice];
		NSMutableString *holidays = [NSMutableString string];
		for (id item in appDelegate.holidaylist) {
			if ([[item objectForKey:@"selected"] isEqualToString:@"YES"]) {
				[holidays appendString:[NSString stringWithFormat:@"%@;\n",[item objectForKey:@"name"]]];
				[holidays appendString:[NSString stringWithFormat:@"     month: %i\n",[[item objectForKey:@"month"] intValue]]];
				[holidays appendString:[NSString stringWithFormat:@"     day: %i\n",[[item objectForKey:@"day"] intValue]]];
				[holidays appendString:[NSString stringWithFormat:@"     weekday: %i\n",[[item objectForKey:@"weekday"]intValue]]];
				[holidays appendString:[NSString stringWithFormat:@"     ordinalweekday: %i\n\n",[[item objectForKey:@"ordinalweekday"] intValue]]];
			}
		}
		NSMutableString *workdays = [NSMutableString stringWithString:@"Workdays: "];
		for (int i=0;i<[appDelegate.workdays count];i++) {
				[workdays appendString:[NSString stringWithFormat:@"%@,",[appDelegate.workdays objectAtIndex:i]]];
			}
		[workdays appendString:@"\n"];
		
		NSMutableString *manualworkdays = [NSMutableString stringWithString:@"Manual Workdays: "];
		NSLog(@"[appDelegate.manualworkdays count] %i",[appDelegate.manualworkdays count]);

		for (int i=0;i<[appDelegate.manualworkdays count];i++) {
			[manualworkdays appendString:[NSString stringWithFormat:@"%@ - ",[dateFormatter stringFromDate:[[appDelegate.manualworkdays objectAtIndex:i] objectAtIndex:0]]]];
			[manualworkdays appendString:[NSString stringWithFormat:@"%@\n",[[appDelegate.manualworkdays objectAtIndex:i] objectAtIndex:1]]];
		}
		[manualworkdays appendString:@"\n"];
		

				
		NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
		NSString *subject;
#ifdef LITE_VERSION
		subject = [NSString stringWithFormat:@"Retirement Countdown Lite feedback"];

#else
		subject = [NSString stringWithFormat:@"Retirement Countdown feedback"];

#endif 
		
		NSString *body = [NSString stringWithFormat:@"App Settings: \nApp Version: %@\nDevice Name: %@\niOS Version: %@\nDevice Model: %@\nCurrent Date: %@\nRetirement Date: %@\nBeginning Workhours: %@\nEnd Workhours: %@\nCurrent Display: %@\nDisplay Option: %@\nAnnual Days Off: %@, %@, %@\n%@\n%@\nHolidays: %@\n",
							 version,
							 thisDevice.systemName,
							 thisDevice.systemVersion,
							 thisDevice.model,
							 [dateFormatter3 stringFromDate:[NSDate date]],
							 [dateFormatter stringFromDate:[appDelegate.settings objectForKey:@"RetirementDate"]],
							 [dateFormatter2 stringFromDate:[appDelegate.settings objectForKey:@"BeginWorkhours"]],
							 [dateFormatter2 stringFromDate:[appDelegate.settings objectForKey:@"EndWorkhours"]],
							 [appDelegate.settings objectForKey:@"CurrentDisplay"],
							 [appDelegate.settings objectForKey:@"DisplayOption"],
							 [appDelegate.settings objectForKey:@"ThisYearDaysOff"],
							 [appDelegate.settings objectForKey:@"AllYearsDaysOff"],
							 [appDelegate.settings objectForKey:@"RetirementYearDaysOff"],
							 workdays,
							 manualworkdays,
							 holidays
									];		

		[mailcontroller setSubject:subject];
		[mailcontroller setMessageBody:body isHTML:NO];
		NSArray *recipient = [NSArray arrayWithObject:@"support@mandellmobileapps.com"];
		[mailcontroller setToRecipients:recipient];
		
		NSString *pathName = [GlobalMethods dataFilePathofDocuments:@"lastScreenCapture"];
		NSData *imageinpng = [[NSData alloc] initWithContentsOfFile:pathName];
		if (imageinpng) {
			[mailcontroller addAttachmentData:imageinpng mimeType:@"image/png" fileName:@"Retirement Countdown"];
		}
		[imageinpng release];
		
		
		
		
		
		[self presentModalViewController:mailcontroller animated:YES];
		[mailcontroller release];
		
	}else{
		//Alert that cannot send mail on this device OS version;
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Cannot send mail on this OS version" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			//message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			//message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			//message.text = @"Result: failed";
			break;
		default:
			//message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[textLabel release];
    [super dealloc];
}


@end
