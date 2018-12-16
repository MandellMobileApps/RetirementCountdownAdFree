//
//  Workdays.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 10/3/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "WorkdaysViewController.h"


@implementation WorkdaysViewController

@synthesize selectedworkdays, allworkdays;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.allworkdays = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
	self.selectedworkdays = self.appDelegate.workdays;
	self.view.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	tableView.backgroundColor = [ColorsClass performSelector:NSSelectorFromString([self.appDelegate.backgroundColors objectAtIndex:7])];
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
         cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	cell.textLabel.text = [self.allworkdays objectAtIndex:indexPath.row];
	if ([[self.selectedworkdays objectAtIndex:indexPath.row] isEqualToString:@"YES"]) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark; 
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
	cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"320x44pattern_4.png"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([[self.selectedworkdays objectAtIndex:indexPath.row] isEqualToString:@"YES"]) {
		[self.selectedworkdays replaceObjectAtIndex:indexPath.row withObject:@"NO"];
	} else {
		[self.selectedworkdays replaceObjectAtIndex:indexPath.row withObject:@"YES"];
	}
	[tableView reloadData];
	self.appDelegate.workdays = self.selectedworkdays;
	self.appDelegate.colorsChanged = YES;
}


- (void)dealloc {
	[selectedworkdays release];
	[allworkdays release];
    [super dealloc];
}


@end

