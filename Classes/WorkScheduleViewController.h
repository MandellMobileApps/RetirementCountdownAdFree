//
//  WorkScheduleViewController.h
//  RetirementCountdownAdFree
//
//  Created by Jon Mandell on 2/4/13.
//  Copyright (c) 2013 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WorkScheduleViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{

	NSDate			*firstDayOfWeek1;
    IBOutlet UITableView*	thisTableView;
    IBOutlet UIView*	thisView;
    NSArray* weekdaysList;
}

@property (nonatomic, retain	) NSDate			*firstDayOfWeek1;
@property (nonatomic, retain	) IBOutlet UITableView*	thisTableView;
@property (nonatomic, retain	) IBOutlet UIView*	thisView;
@property (nonatomic, retain	) NSArray* weekdaysList;

-(NSString*)stringFromDate:(NSDate*)thisDate;

@end
