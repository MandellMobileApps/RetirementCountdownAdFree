//
//  AboutViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/18/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface AboutViewController : BaseViewController {
	IBOutlet UILabel *versionLabel;
    IBOutlet UIImageView *logoImageView;
}
@property(nonatomic,retain) IBOutlet UILabel *versionLabel;
@property(nonatomic,retain) IBOutlet UIImageView *logoImageView;

-(IBAction) loadWebView;
@end
