//
//  BaseTableViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/10/10.
//  Copyright 2010 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetirementCountdownAppDelegate.h"

@interface BaseTableViewController : UITableViewController {
	RetirementCountdownAppDelegate *appDelegate;
}
@property (nonatomic,retain) RetirementCountdownAppDelegate *appDelegate;
@end
