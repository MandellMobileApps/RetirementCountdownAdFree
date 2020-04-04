//
//  AboutViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/18/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "AboutViewController.h"
#import "WebViewController.h"


@implementation AboutViewController



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	//NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

	self.versionLabel.text = [NSString stringWithFormat:@"Retirement Countdown Version %@", version];
    self.logoImageView.image = [UIImage imageNamed:@"beach114.png"];

    
    	// Welcome Text
	UILabel *welcomeLabel = [[UILabel alloc] init];
	welcomeLabel.font = [UIFont systemFontOfSize:14];
	welcomeLabel.textColor = self.textColor;
	welcomeLabel.backgroundColor = self.backgroundColor;
	welcomeLabel.numberOfLines = 0;
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
	welcomeLabel.text = @"I hope you enjoy this Retirement Countdown Calendar.  You can have your remaining work years, months, days, hours, minutes, and seconds counting down!  It is meant for entertainment purposes only.   Have fun! \n\n";
	[welcomeLabel setFrame:CGRectMake(20, 150, 280, 180)];
//	welcomeLabel.layer.borderWidth = 2;
//	welcomeLabel.layer.borderColor = [[UIColor redColor] CGColor];
	[self.view addSubview:welcomeLabel];

	
}


-(IBAction) loadWebView {
	WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	webViewController.title = @"Web Viewer";
	webViewController.urlString = @"http://www.MandellMobileApps.com";
	[[self navigationController] pushViewController:webViewController animated:YES];

}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/






@end
