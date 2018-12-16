//
//  WebViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/18/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {

	IBOutlet UIWebView *thisWebView;
	NSString *urlString;
}


@property(nonatomic, retain) IBOutlet UIWebView *thisWebView;
@property(nonatomic, retain) NSString *urlString;

@end
