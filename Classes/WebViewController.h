//
//  WebViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/18/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface WebViewController : BaseViewController {

}


@property(nonatomic, retain) IBOutlet UIWebView *thisWebView;
@property(nonatomic, retain) NSString *urlString;

@end
