//
//  HolidaysViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/3/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "HolidaysViewController.h"


@implementation HolidaysViewController

@synthesize changed;
@synthesize holidaynames;
@synthesize holidaymonth;
@synthesize holidayday;
@synthesize holidayweekday;
@synthesize holidayordinal;
@synthesize holidayused;
@synthesize holidayList;
@synthesize holidayTableView;


- (void)viewDidLoad {
    [super viewDidLoad];

	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];	
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
		self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.holidayList = self.appDelegate.holidaylist;
	[self.holidayTableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.appDelegate.holidaylist = self.holidayList;
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.holidayTableView setEditing:editing animated:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {	
        return UITableViewCellEditingStyleNone;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.holidayList removeObjectAtIndex:indexPath.row-1];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
		return [self.holidayList count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    NSMutableDictionary *holidayDictionary;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.detailTextLabel.textColor = [UIColor redColor];
	}
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Add New Holiday";
		cell.textLabel.textColor = [UIColor blueColor];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = nil;
	}else {
		holidayDictionary = [self.holidayList objectAtIndex:indexPath.row-1];
		cell.textLabel.text = [holidayDictionary valueForKey:@"name"];
		cell.textLabel.textColor = [UIColor blackColor];
		cell.detailTextLabel.text = @"";
		if ([[holidayDictionary valueForKey:@"selected"] isEqualToString:@"YES"])
        {
            cell.imageView.image = [UIImage imageNamed:@"checkbox_checked_gray.png"];
		}
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"checkbox_unchecked_gray.png"];
        }
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	}
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {

		if (indexPath.row == 0) {
			AddHolidayViewController *addHolidayViewController = [[AddHolidayViewController alloc] initWithNibName:@"AddHolidayViewController" bundle:nil];
			addHolidayViewController.title = @"Add Holiday";
			addHolidayViewController.locationInList = 1000;
			[[self navigationController] pushViewController:addHolidayViewController animated:YES];
			[addHolidayViewController release];
		} else {
			AddHolidayViewController *addHolidayViewController = [[AddHolidayViewController alloc] initWithNibName:@"AddHolidayViewController" bundle:nil];
			addHolidayViewController.title = @"Edit Holiday";
			addHolidayViewController.locationInList = indexPath.row - 1;
			[[self navigationController] pushViewController:addHolidayViewController animated:YES];
			[addHolidayViewController release];
		}


}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	if (indexPath.row == 0) {
		AddHolidayViewController *addHolidayViewController = [[AddHolidayViewController alloc] initWithNibName:@"AddHolidayViewController" bundle:nil];
		addHolidayViewController.title = @"Add Holiday";
		addHolidayViewController.locationInList = 1000;
		[[self navigationController] pushViewController:addHolidayViewController animated:YES];
		[addHolidayViewController release];
	} else {		
			
		if ([[[self.holidayList objectAtIndex:indexPath.row-1] valueForKey:@"selected"] isEqualToString:@"YES"]) {
			[[self.holidayList objectAtIndex:indexPath.row-1] setObject:@"NO" forKey:@"selected"];
		} else {
			[[self.holidayList objectAtIndex:indexPath.row-1] setObject:@"YES" forKey:@"selected"];
		}
		[self.holidayTableView reloadData];
		self.appDelegate.holidaylist = self.holidayList;
		self.appDelegate.colorsChanged = YES;
	}
}


- (void)dealloc {

	[holidaynames release];
	[holidaymonth release];
	[holidayday release];
	[holidayweekday release];
	[holidayordinal release];
	[holidayused release];
	[holidayList release];
	[holidayTableView release];
    [super dealloc];
}


@end

