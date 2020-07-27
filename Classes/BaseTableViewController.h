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
	
}
@property (nonatomic,retain) RetirementCountdownAppDelegate *appDelegate;
@property (nonatomic,retain) UIColor *backgroundColor;
@property (nonatomic,retain) UIColor *textColor;
@property (nonatomic) BOOL capture;
@end
