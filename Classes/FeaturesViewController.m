//
//  FeaturesViewController.m
//  RetirementCountdownAdFree
//
//  Created by Jon Mandell on 9/4/13.
//  Copyright (c) 2013 MandellMobileApps. All rights reserved.
//

#import "FeaturesViewController.h"
#import "WebViewController.h"

@interface FeaturesViewController ()

-(IBAction)loadFAQs:(id)sender;

@end

@implementation FeaturesViewController


- (void)viewDidLoad {
    [super viewDidLoad];


	
    
	//set label at top to settings colors
    self.scrollLabel.textColor = self.textColor;
	self.myScrollView.backgroundColor = self.backgroundColor;

    
	// set size of scrollview content
	[self.myScrollView setContentSize:CGSizeMake(320, 510)];
    
	// Features Text
	UILabel *features = [[UILabel alloc] init];
	features.font = [UIFont systemFontOfSize:14];
	features.textColor = self.textColor;
	features.backgroundColor = self.backgroundColor;
	features.numberOfLines = 0;
	features.text = @"* Select Your Own Picture!\n"
					@"If your retirement plans don't include a hammock on the beach, you can add a picture of your own.\n\n"
					@"* Customize your colors!\n"
					@"Customize with 13 color choices for each type of day(workday,holiday…).  Choose from 500 colors for your calendar background and text.\n\n"
					@"* Enter Your Vacation Days!\n"
					@"Single tap on a day and it will toggle between a workday and a non-workday, double tap and it goes back to default. You will have to do this for each day off.\n\n"
					@"* Time Remaining!\n"
					@"You can choose between \"Working Days Remaining\" or \"Calendar Days Remaining\" for your Countdown!  Your Working Days Remaining (down to the second of course).  The \"hours-minutes-seconds\" only displays during your working hours.  Your Calendar Days Remaining will show the total \"years-months-days\" to your retirement date.\n\n"
					@"* Email to a Friend!\n"
					@"Take a screen capture of your calendar and email to your friends or your boss??"
					"\n";
	[features setFrame:CGRectMake(10, 10 , 310, 500)];
    self.scrollLabel = features;
	[self.myScrollView addSubview:self.scrollLabel];



}

-(IBAction)loadFAQs:(id)sender
{
	WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	webViewController.title = @"FAQs";
	webViewController.urlString = @"http://www.mandellmobileapps.com/FAQs.html";
	[[self navigationController] pushViewController:webViewController animated:YES];



}




@end
