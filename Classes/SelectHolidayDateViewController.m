//
//  SelectHolidayDateViewController.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 12/16/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "SelectHolidayDateViewController.h"
#import "ColorsClass.h"
#import "AddHolidayViewController.h"

@implementation SelectHolidayDateViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	self.cancelledSave = NO;

}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

}





#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSInteger dim = 0;
	if ([self.tableToLookup isEqualToString:@"Month"]) {
		dim = 12;
	} else if ([self.tableToLookup isEqualToString:@"Day of the Month"]) {
		dim = [GlobalMethods daysinmonth:[[self.holiday objectForKey:@"month"]integerValue] year:0];

	} else if ([self.tableToLookup isEqualToString:@"Day of the Week"]) {
		dim = 7;
	} else if ([self.tableToLookup isEqualToString:@"Week of the Month"]) {
		dim = 5;
	}
	return dim;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	cell.accessoryType = UITableViewCellAccessoryNone;
    if ([self.tableToLookup isEqualToString:@"Month"]) {
        cell.textLabel.text = [GlobalMethods nameOfMonthForInt:indexPath.row +1];
        if ([[self.holiday objectForKey:@"month"]integerValue]== indexPath.row+1) {cell.accessoryType = UITableViewCellAccessoryCheckmark;}
    } else if ([self.tableToLookup isEqualToString:@"Day of the Month"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%li",indexPath.row+1];
        if ([[self.holiday objectForKey:@"day"]integerValue] == indexPath.row+1) { cell.accessoryType = UITableViewCellAccessoryCheckmark;}
    } else if ([self.tableToLookup isEqualToString:@"Day of the Week"]) {
        cell.textLabel.text = [GlobalMethods dayTextForDayofWeek:indexPath.row+1];
        if ([[self.holiday objectForKey:@"weekday"]integerValue] == indexPath.row+1) { cell.accessoryType = UITableViewCellAccessoryCheckmark;}
    } else if ([self.tableToLookup isEqualToString:@"Week of the Month"]) {
        cell.textLabel.text = [GlobalMethods nameOfOrdinalWeekdayForInt:indexPath.row+1];
        if ([[self.holiday objectForKey:@"ordinalweekday"]integerValue] == indexPath.row+1){ cell.accessoryType = UITableViewCellAccessoryCheckmark;}
    }
	 
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString* object = [NSString stringWithFormat:@"%li",indexPath.row+1];
	if ([self.tableToLookup isEqualToString:@"Month"]) {
        [self.holiday setObject:object forKey:@"month"];

	} else if ([self.tableToLookup isEqualToString:@"Day of the Month"]) {
        [self.holiday setObject:object forKey:@"day"];

	} else if ([self.tableToLookup isEqualToString:@"Day of the Week"]) {
        [self.holiday setObject:object forKey:@"weekday"];

	} else if ([self.tableToLookup isEqualToString:@"Week of the Month"]) {
        [self.holiday setObject:object forKey:@"ordinalweekday"];

	}
	[tableView reloadData];
    self.addHolidayViewController.holiday = self.holiday;
    [self performSelector:@selector(doneWithEntry) withObject:nil afterDelay:.2];
}

-(void) doneWithEntry
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

