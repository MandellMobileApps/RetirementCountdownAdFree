//
//  CalendarBackgroundViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorsClass.h"
#import "BackgroundColorViewController.h"
#import "BackgroundTextColorViewController.h"
#import "BaseViewController.h"

@interface CalendarBackgroundViewController : BaseViewController <UITableViewDelegate> {

}
@property (nonatomic, retain) NSString *currentObject;
@property (nonatomic, retain) IBOutlet UILabel *upperLine;
@property (nonatomic, retain) IBOutlet UILabel *lowerLine;
@property (nonatomic, retain) IBOutlet UITableView *backgroundColorTable;

@end
