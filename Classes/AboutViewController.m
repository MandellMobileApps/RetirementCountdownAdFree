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
@synthesize versionLabel, logoImageView;

- (void)dealloc {
	[versionLabel release];
    [logoImageView release];
    [super dealloc];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    //set label at top to settings colors
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	
	NSString *version =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"];
#ifdef LITE_VERSION
	self.versionLabel.text = [NSString stringWithFormat:@"Retirement Countdown Lite Version %@", version];
    self.logoImageView.image = [UIImage imageNamed:@"beach114Lite.png"];
#else
	self.versionLabel.text = [NSString stringWithFormat:@"Retirement Countdown Version %@", version];
    self.logoImageView.image = [UIImage imageNamed:@"beach114.png"];
#endif    
    
    

	
	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];
    
    	// Welcome Text
	UILabel *welcomeImage = [[UILabel alloc] init];
	welcomeImage.font = [UIFont systemFontOfSize:14];
	welcomeImage.textColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.textColors objectAtIndex:7])];
	welcomeImage.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	welcomeImage.numberOfLines = 0;
    welcomeImage.textAlignment = UITextAlignmentCenter;
	welcomeImage.text = @"I hope you enjoy this Retirement Countdown Calendar.  You can have your remaining work years, months, days, hours, minutes, and seconds counting down!  It is meant for entertainment purposes only.   Have fun! \n\n";
	[welcomeImage setFrame:CGRectMake(20, 150, 280, 180)];
//	welcomeImage.layer.borderWidth = 2;
//	welcomeImage.layer.borderColor = [[UIColor redColor] CGColor];
	[self.view addSubview:welcomeImage];
	[welcomeImage release];
	
}


-(IBAction) loadWebView {
	WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
	webViewController.title = @"Web Viewer";
	webViewController.urlString = @"http://www.MandellMobileApps.com";
	[[self navigationController] pushViewController:webViewController animated:YES];
	[webViewController release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
