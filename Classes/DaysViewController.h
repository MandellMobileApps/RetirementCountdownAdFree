//
//  DaysViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/14/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsViewController.h"
#import "CustomCell.h"
#import "ColorsClass.h"
#import "CalendarBackgroundViewController.h"
#import "BaseTableViewController.h"


@interface DaysViewController : BaseTableViewController {

	NSArray *backgrounds;
	IBOutlet UITableView *tableViewForReload;
	NSArray *backgroundImageNames;
	NSArray *textColorNames;
	
	
}

@property (nonatomic, retain) NSArray *backgrounds;
@property (nonatomic, retain) IBOutlet UITableView *tableViewForReload;
@property (nonatomic, retain) NSArray *backgroundImageNames;
@property (nonatomic, retain) NSArray *textColorNames;
@end
