//
//  ColorsViewController.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/14/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCellForColors.h"
#import "ColorsClass.h"
#import "BaseViewController.h"


@interface ColorsViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource> {

	int currentBackground;
	NSMutableArray *backgroundColors;
	NSMutableArray *textColors;
	IBOutlet UIButton *dayButton;
	IBOutlet UILabel *dayLabel;
		
IBOutlet	UITableView *tableViewButton;
IBOutlet	UITableView *tableViewLabel;
}

@property (nonatomic, retain) NSMutableArray *backgroundColors;
@property (nonatomic, retain) NSMutableArray *textColors;
@property (nonatomic, retain) IBOutlet UITableView *tableViewButton;
@property (nonatomic, retain) IBOutlet UITableView *tableViewLabel;
@property (nonatomic, retain) IBOutlet UIButton *dayButton;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel;
@property (nonatomic, assign) int currentBackground;

@end
