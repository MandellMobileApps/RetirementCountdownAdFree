//
//  DisplayOptionsViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/31/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"



@interface DisplayOptionsViewController : BaseTableViewController {
NSArray *badgedisplayoptions;
NSArray *displayoptions;
NSString *option;
}
@property (nonatomic, retain) NSArray *badgedisplayoptions;
@property (nonatomic, retain) NSArray *displayoptions;
@property (nonatomic, retain) NSString *option;

@end
