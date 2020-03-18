//
//  WebViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/18/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	NSURL *thisURL = [NSURL URLWithString:self.urlString];
	NSURLRequest *thisRequest = [NSURLRequest requestWithURL:thisURL];
	[self.thisWebView loadRequest:thisRequest];

}






@end
