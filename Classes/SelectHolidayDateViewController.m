//
//  SelectHolidayDateViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/16/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "SelectHolidayDateViewController.h"


@implementation SelectHolidayDateViewController

@synthesize title;
@synthesize tableToLookup;
@synthesize valueSelected;
@synthesize locationInList;

@synthesize holidayName;
@synthesize holidayMonth;
@synthesize holidayDay;
@synthesize holidayWeekday;
@synthesize holidayOrdinalWeekday;

@synthesize cancelledSave;


- (void)viewDidLoad {
    [super viewDidLoad];
	self.cancelledSave = NO;
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
		self.appDelegate.newdata = 1;
		self.appDelegate.holidayMonth = self.holidayMonth;
		self.appDelegate.holidayDay = self.holidayDay;
		self.appDelegate.holidayWeekday = self.holidayWeekday;
		self.appDelegate.holidayOrdinalWeekday = self.holidayOrdinalWeekday;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    NSInteger dim = 0;
	if ([tableToLookup isEqualToString:@"Month"]) {
		dim = 12;
	} else if ([tableToLookup isEqualToString:@"Day of the Month"]) {
		dim = [GlobalMethods daysinmonth:holidayMonth];

	} else if ([tableToLookup isEqualToString:@"Day of the Week"]) {
		dim = 7;
	} else if ([tableToLookup isEqualToString:@"Week of the Month"]) {
		dim = 5;
	}
	return dim;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.accessoryType = UITableViewCellAccessoryNone;
	if ([tableToLookup isEqualToString:@"Month"]) {
		cell.textLabel.text = [GlobalMethods nameOfMonthForInt:indexPath.row +1];
		if (self.holidayMonth == indexPath.row+1) {cell.accessoryType = UITableViewCellAccessoryCheckmark;}
	} else if ([tableToLookup isEqualToString:@"Day of the Month"]) {
		cell.textLabel.text = [NSString stringWithFormat:@"%i",indexPath.row+1];
		if (self.holidayDay == indexPath.row+1) { cell.accessoryType = UITableViewCellAccessoryCheckmark;}
	} else if ([tableToLookup isEqualToString:@"Day of the Week"]) {
		cell.textLabel.text = [GlobalMethods nameOfDayForInt:indexPath.row+1];
		if (self.holidayWeekday == indexPath.row+1) { cell.accessoryType = UITableViewCellAccessoryCheckmark;}
	} else if ([tableToLookup isEqualToString:@"Week of the Month"]) {
		cell.textLabel.text = [GlobalMethods nameOfOrdinalWeekdayForInt:indexPath.row+1];
		if (self.holidayOrdinalWeekday == indexPath.row+1){ cell.accessoryType = UITableViewCellAccessoryCheckmark;}
	}
	 
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if ([tableToLookup isEqualToString:@"Month"]) {
		self.holidayMonth = indexPath.row+1;

	} else if ([tableToLookup isEqualToString:@"Day of the Month"]) {
		self.holidayDay = indexPath.row+1;

	} else if ([tableToLookup isEqualToString:@"Day of the Week"]) {
		self.holidayWeekday = indexPath.row+1;

	} else if ([tableToLookup isEqualToString:@"Week of the Month"]) {
		self.holidayOrdinalWeekday = indexPath.row+1;

	}
	[tableView reloadData];
}


- (void)dealloc {
	[title release];
	[tableToLookup release];
	[holidayName release];

    [super dealloc];
}


@end

