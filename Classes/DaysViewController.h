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

}
@property (nonatomic, retain) NSArray *backgroundSettings;
@property (nonatomic, retain) IBOutlet UITableView *tableViewForReload;
@property (nonatomic, retain) NSArray *textColors;

@end
