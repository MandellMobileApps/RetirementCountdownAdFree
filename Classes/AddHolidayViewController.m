//
//  AddHolidayViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/12/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "AddHolidayViewController.h"


@implementation AddHolidayViewController

@synthesize tableList;
@synthesize holidayType;
@synthesize locationInList;
@synthesize holiday;
@synthesize saveHoliday;
@synthesize holidayList;
@synthesize holidayTypeTableView;
@synthesize holidayNameTextField;
@synthesize holidayTypeSegmentControl;

@synthesize holidayName;
@synthesize holidayMonth;
@synthesize holidayDay;
@synthesize holidayWeekday;
@synthesize holidayOrdinalWeekday;



- (void)viewDidLoad {
    [super viewDidLoad];
	holidayNameTextField.delegate = self;
	UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit)];
	self.navigationItem.rightBarButtonItem = cancelBarItem;
	[cancelBarItem release];
	
	UIBarButtonItem *saveBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAndReturnToHolidayList)];
	self.navigationItem.leftBarButtonItem = saveBarItem;
	[saveBarItem release];
	
	UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarItem;
	[backBarItem release];	
	NSLog(@"self.locationInList %i",self.locationInList);

	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
	
	self.holidayList = self.appDelegate.holidaylist;
	if (self.locationInList < 1000) {
		self.holiday = [self.holidayList objectAtIndex:self.locationInList];
		self.holidayName = [self.holiday valueForKey:@"name"];
		self.holidayMonth = [[self.holiday valueForKey:@"month"] intValue];
		self.holidayDay = [[self.holiday valueForKey:@"day"] intValue];
		self.holidayWeekday = [[self.holiday valueForKey:@"weekday"] intValue];
		self.holidayOrdinalWeekday = [[self.holiday valueForKey:@"ordinalweekday"] intValue];
		self.holidayNameTextField.text = self.holidayName;
		if (self.holidayDay > 0) { 
			self.holidayType = 0;
			self.holidayTypeSegmentControl.selectedSegmentIndex = 0;
		} else {
			self.holidayType = 1;
			self.holidayTypeSegmentControl.selectedSegmentIndex = 1;
		}
	} else {
		self.holidayType = 0;
		self.holidayTypeSegmentControl.selectedSegmentIndex = 0;
		self.holidayMonth = 0;
		self.holidayDay = 0;
		self.holidayWeekday = 0;
		self.holidayOrdinalWeekday = 0;
	}	


}

-(void) cancelEdit {
	[self.navigationController  popViewControllerAnimated:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	if (self.appDelegate.newdata == 1) {
		self.holidayMonth = self.appDelegate.holidayMonth;
		self.holidayDay = self.appDelegate.holidayDay;
		self.holidayWeekday = self.appDelegate.holidayWeekday;
		self.holidayOrdinalWeekday = self.appDelegate.holidayOrdinalWeekday;
		[self.holidayTypeTableView reloadData];
		self.appDelegate.newdata = 0;
	}
}

-(void)saveAndReturnToHolidayList {
	
	BOOL validData = [self validateData];
	if (validData == YES) {
		[self.holidayNameTextField resignFirstResponder];
		self.appDelegate.newdata = 0;
		if (locationInList < 1000) {
			[self.holiday setObject:self.holidayName forKey:@"name"];
			if (self.holidayType == 1) {self.holidayDay = 0;}
			[self.holiday setObject:[NSNumber numberWithInt:self.holidayMonth] forKey:@"month"];
			[self.holiday setObject:[NSNumber numberWithInt:self.holidayDay] forKey:@"day"];
			[self.holiday setObject:[NSNumber numberWithInt:self.holidayWeekday] forKey:@"weekday"];
			[self.holiday setObject:[NSNumber numberWithInt:self.holidayOrdinalWeekday] forKey:@"ordinalweekday"];
			[self.holidayList replaceObjectAtIndex:locationInList withObject:self.holiday];
			self.appDelegate.holidaylist = self.holidayList;
		} else {
			NSMutableArray *tempArrayForObjects = [[NSMutableArray alloc] init];
			[tempArrayForObjects addObject:self.holidayName];
			if (self.holidayType == 1) {self.holidayDay = 0;}
			[tempArrayForObjects addObject:[NSNumber numberWithInt:self.holidayMonth]];
			[tempArrayForObjects addObject:[NSNumber numberWithInt:self.holidayDay]];
			[tempArrayForObjects addObject:[NSNumber numberWithInt:self.holidayWeekday]];
			[tempArrayForObjects addObject:[NSNumber numberWithInt:self.holidayOrdinalWeekday]];
			[tempArrayForObjects addObject:@"YES"];
			NSMutableArray *tempArrayForKeys = [[NSMutableArray alloc] init];
			[tempArrayForKeys addObject:@"name"];
			[tempArrayForKeys addObject:@"month"];
			[tempArrayForKeys addObject:@"day"];
			[tempArrayForKeys addObject:@"weekday"];
			[tempArrayForKeys addObject:@"ordinalweekday"];
			[tempArrayForKeys addObject:@"selected"];
			NSMutableDictionary *tempHolidayDictionary = [[NSMutableDictionary alloc ] initWithObjects:tempArrayForObjects forKeys:tempArrayForKeys]; 
			[self.holidayList addObject:tempHolidayDictionary];
			self.appDelegate.holidaylist = self.holidayList;
			[tempArrayForObjects release];
			[tempArrayForKeys release];
			[tempHolidayDictionary release];
		}
		self.appDelegate.colorsChanged = YES;
		[self.navigationController popViewControllerAnimated:YES];
	}
}

-(BOOL)validateData {

	BOOL validData;
	if (self.holidayType == 0) {
		if ((self.holidayDay == 0) || (self.holidayMonth == 0) || ([self.holidayName length] < 1)) {
			validData = NO;
		} else {	
			self.holidayWeekday = 0;
			self.holidayOrdinalWeekday = 0;
			validData = YES;
		}
	} else {
		if ((self.holidayWeekday == 0) || (self.holidayOrdinalWeekday == 0) || (self.holidayMonth == 0) || ([self.holidayName length] < 1)) {
			validData = NO;
		} else {	
			self.holidayDay = 0;
			validData = YES;
		}
	}
	if (validData == NO) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Holiday Information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
	return validData;

}


- (IBAction)segmentAction:(id)sender
{
	self.holidayType = [sender selectedSegmentIndex];
	[holidayTypeTableView reloadData];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	self.holidayName = [NSMutableString stringWithString:textField.text];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
		   self.holidayName = [NSMutableString stringWithString:holidayNameTextField.text];
			[holidayNameTextField resignFirstResponder];
			return YES;
}

- (IBAction)backgroundClick:(id)sender {
	[self.holidayNameTextField resignFirstResponder];

}

- (IBAction) changeHolidayName {
	
	
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    int r = 0;
	if (self.holidayType == 0) {
		r = 2;
	} else {
		r = 3;
	}
	return r;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	if (self.holidayType== 0) {
		if (indexPath.row == 0) { 
			cell.textLabel.text = @"Month";
				if (self.holidayMonth > 0) {
					cell.detailTextLabel.text = [GlobalMethods nameOfMonthForInt:self.holidayMonth];
				} else {
					cell.detailTextLabel.text = @"Enter";
				}
			}
		if (indexPath.row == 1) { 
			cell.textLabel.text = @"Day of the Month";
			if (self.holidayDay > 0 ) {
				cell.detailTextLabel.text = [NSString stringWithFormat:@"%i",self.holidayDay];	
			} else {
				cell.detailTextLabel.text = @"Enter";
			}
		}
	}
	if (self.holidayType== 1) {
		if (indexPath.row == 0) { 
			cell.textLabel.text = @"Month";
			if (self.holidayMonth > 0) {
				cell.detailTextLabel.text = [GlobalMethods nameOfMonthForInt:self.holidayMonth];
			} else {
				cell.detailTextLabel.text = @"Enter";
			}
		}
		if (indexPath.row == 1) { 
			cell.textLabel.text = @"Week of the Month";
			if (self.holidayOrdinalWeekday > 0)  {
				cell.detailTextLabel.text = [GlobalMethods nameOfOrdinalWeekdayForInt:self.holidayOrdinalWeekday];
			} else {
				cell.detailTextLabel.text = @"Enter";	
			}
		}
		if (indexPath.row == 2) { 
			cell.textLabel.text = @"Day of the Week";
			if (self.holidayWeekday > 0) {
				cell.detailTextLabel.text = [GlobalMethods nameOfDayForInt:self.holidayWeekday];
			} else {
				cell.detailTextLabel.text = @"Enter";
			}
		}		
	}

	return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[alertView dismissWithClickedButtonIndex:0 animated:YES];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	[self.holidayNameTextField resignFirstResponder];
	
	SelectHolidayDateViewController *selectHolidayDateViewController = [[SelectHolidayDateViewController alloc] initWithNibName:@"SelectHolidayDateViewController" bundle:nil];
	selectHolidayDateViewController.locationInList = self.locationInList;
	selectHolidayDateViewController.holidayMonth = self.holidayMonth;
	selectHolidayDateViewController.holidayDay = self.holidayDay;
	selectHolidayDateViewController.holidayWeekday = self.holidayWeekday;
	selectHolidayDateViewController.holidayOrdinalWeekday = self.holidayOrdinalWeekday;
	BOOL validSelection = YES;
	if (self.holidayType == 0) {
		if (indexPath.row == 0) { 
			selectHolidayDateViewController.tableToLookup = @"Month";
			selectHolidayDateViewController.title = @"Month";
		}
		if (indexPath.row == 1) { 
			selectHolidayDateViewController.tableToLookup = @"Day of the Month";
			selectHolidayDateViewController.title = @"Day of the Month";
			if (self.holidayMonth == 0) {
				validSelection = NO;
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Month First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];
				[alertView release];
			}
		}
	}
	if (self.holidayType == 1) {
		if (indexPath.row == 0) { 
			selectHolidayDateViewController.tableToLookup = @"Month";
			selectHolidayDateViewController.title = @"Month";
		}
		if (indexPath.row == 1) { 
			selectHolidayDateViewController.tableToLookup = @"Week of the Month";
			selectHolidayDateViewController.title = @"Week of the Month";
			if (self.holidayMonth == 0) {
				validSelection = NO;
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Month First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];
				[alertView release];
			}
		}
		if (indexPath.row == 2) { 
			selectHolidayDateViewController.tableToLookup = @"Day of the Week";
			selectHolidayDateViewController.title = @"Day of the Week";
			if (self.holidayMonth == 0) {
				validSelection = NO;
				UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Month First" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alertView show];
				[alertView release];
			}
		}		
	}
	if (validSelection == YES) {
		[[self navigationController] pushViewController:selectHolidayDateViewController animated:YES];

	}
		[selectHolidayDateViewController release];
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


- (void)dealloc {
	[tableList release];
	[holiday release];
	[holidayList release];
	[holidayTypeTableView release];
	[holidayNameTextField release];
	[holidayTypeSegmentControl release];
	[holidayName release];	
	
    [super dealloc];
}


@end
